import torch
import torchvision
import torchvision.transforms as transforms
import torch.nn as nn
import torch.nn.utils.prune as prune
import torch.optim as optim
import os
from torch.utils.data import DataLoader
import torch.quantization
from torch.quantization import QuantStub, DeQuantStub
from torch.quantization.observer import MovingAverageMinMaxObserver
import numpy as np


class AverageMeter(object):
    """Computes and stores the average and current value"""
    def __init__(self, name, fmt=':f'):
        self.name = name
        self.fmt = fmt
        self.reset()

    def reset(self):
        self.val = 0
        self.avg = 0
        self.sum = 0
        self.count = 0

    def update(self, val, n=1):
        self.val = val
        self.sum += val * n
        self.count += n
        self.avg = self.sum / self.count

    def __str__(self):
        fmtstr = '{name} {val' + self.fmt + '} ({avg' + self.fmt + '})'
        return fmtstr.format(**self.__dict__)

def accuracy(output, target):
    """ Computes the top 1 accuracy """
    with torch.no_grad():
        batch_size = target.size(0)

        _, pred = output.topk(1, 1, True, True)
        pred = pred.t()
        correct = pred.eq(target.view(1, -1).expand_as(pred))

        correct_one = correct[:1].view(-1).float().sum(0, keepdim=True)
        return correct_one.mul_(100.0 / batch_size).item()

def print_size_of_model(model):
    """ Prints the real size of the model """
    torch.save(model.state_dict(), "temp.p")
    print('Size (MB):', os.path.getsize("temp.p")/1e6)
    os.remove('temp.p')

def load_model(quantized_model, model_path):
    """Loads weights from the given path into an object meant for quantization."""
    # Load the saved weights from .pth file
    saved_state_dict = torch.load(model_path, map_location='cpu')

    # Load the state dict into the quantized model
    quantized_model.load_state_dict(saved_state_dict)


def fuse_modules(model):
    """ Fuse together convolutions/linear layers and ReLU """
    torch.quantization.fuse_modules(model, [['conv1', 'relu1'], 
                                            ['conv2', 'relu2'],
                                            ['fc1', 'relu3'],
                                            ['fc2', 'relu4']], inplace=True)
    
    
class Net(nn.Module):
    def __init__(self, q = False):
        # By turning on Q we can turn on/off the quantization
        super(Net, self).__init__()
        self.conv1 = nn.Conv2d(1, 6, 5, bias=False)
        self.relu1 = nn.ReLU()
        self.pool1 = nn.MaxPool2d(2, 2)
        self.conv2 = nn.Conv2d(6, 16, 5, bias=False)
        self.relu2 = nn.ReLU()
        self.pool2 = nn.MaxPool2d(2, 2)
        self.fc1 = nn.Linear(256, 120, bias=False)
        self.relu3 = nn.ReLU()
        self.fc2 = nn.Linear(120, 84, bias=False)
        self.relu4 = nn.ReLU()
        self.fc3 = nn.Linear(84, 10, bias=False)
        self.q = q
        if q:
          self.quant = QuantStub()
          self.dequant = DeQuantStub()
        

    def forward(self, x: torch.Tensor) -> torch.Tensor:
        if self.q:
          x = self.quant(x)
        x = self.conv1(x)
        x = self.relu1(x)
        x = self.pool1(x)
        x = self.conv2(x)
        x = self.relu2(x)
        x = self.pool2(x)
        # Be careful to use reshape here instead of view
        x = x.reshape(x.shape[0], -1)
        x = self.fc1(x)
        x = self.relu3(x)
        x = self.fc2(x)
        x = self.relu4(x)
        x = self.fc3(x)
        if self.q:
          x = self.dequant(x)
          
        return x
    
    
def custom_l1_unstructured_pruning(layer, amount):
    weight_abs = torch.abs(layer.weight.data)
    
    threshold = torch.quantile(weight_abs, amount)

    mask = weight_abs.ge(threshold).float()  

    layer.weight.data.mul_(mask)  




def apply_pruning(model, amount):
    layers = [model.conv1, model.conv2, model.fc1, model.fc2, model.fc3]
    for layer in layers:
        custom_l1_unstructured_pruning(layer, amount)

'''
def apply_pruning(model, amount):
    layers = [model.conv1, model.conv2, model.fc1, model.fc2, model.fc3]
    for layer in layers:
        prune.l1_unstructured(layer, 'weight', amount=amount)
'''
        
def calculate_total_sparsity(model):
    total_weights = total_zero_weights = 0
    layers = [model.conv1, model.conv2, model.fc1, model.fc2, model.fc3]
    for layer in layers:
        weight = layer.weight.data.cpu().numpy()
        total_weights += weight.size
        total_zero_weights += np.count_nonzero(weight == 0)
    return total_zero_weights / total_weights


def train(model, dataloader, cuda=False, q=False, epochs=20, post_pruning_epochs=1):
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    scheduler = optim.lr_scheduler.StepLR(optimizer, step_size=7, gamma=0.1)
    criterion = nn.CrossEntropyLoss()

    for epoch in range(epochs):
        run_training_epoch(model, dataloader, optimizer, criterion, scheduler, cuda, q, epoch)
        '''
        total_sparsity = calculate_total_sparsity(model)
        desired_sparsity = (epoch + 1) / epochs * 0.2
        if total_sparsity < desired_sparsity:
            additional_sparsity = (desired_sparsity - total_sparsity) / (1 - total_sparsity)
            apply_pruning(model, additional_sparsity)
            
            print(f'Epoch {epoch + 1}: Total Sparsity: {calculate_total_sparsity(model):.2f}')
            
            for post_epoch in range(post_pruning_epochs):
                print(f'Post-pruning training epoch {post_epoch + 1}')
                run_training_epoch(model, dataloader, optimizer, criterion, scheduler, cuda, q, epoch)
        '''
    print('Finished Training')


def run_training_epoch(model, dataloader, optimizer, criterion, scheduler, cuda, q, epoch):
    model.train()
    running_loss = AverageMeter('loss')
    acc = AverageMeter('train_acc')

    for i, data in enumerate(dataloader, 0):
        inputs, labels = data
        if cuda:
            inputs = inputs.cuda()
            labels = labels.cuda()

        optimizer.zero_grad()

        if epoch >= 3 and q:
            model.apply(torch.quantization.disable_observer)

        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()

        running_loss.update(loss.item(), outputs.shape[0])
        acc.update(accuracy(outputs, labels), outputs.shape[0])
        if i % 100 == 0:    # print every 100 mini-batches
            print('[%d, %5d] ' % (epoch + 1, i + 1), running_loss, acc)

    scheduler.step()




'''
def train(model: nn.Module, dataloader: DataLoader, cuda=False, q=False, epochs=20):
    
    optimizer = optim.Adam(model.parameters(), lr=0.001)
    scheduler = optim.lr_scheduler.StepLR(optimizer, step_size=7, gamma=0.1)

    criterion = nn.CrossEntropyLoss()
    
    model.train()
    
    print("Started Traning")
    for epoch in range(epochs):  # loop over the dataset multiple times
    
        running_loss = AverageMeter('loss')
        acc = AverageMeter('train_acc')
        for i, data in enumerate(dataloader, 0):
            # get the inputs; data is a list of [inputs, labels]
            inputs, labels = data
            if cuda:
              inputs = inputs.cuda()
              labels = labels.cuda()

            # zero the parameter gradients
            optimizer.zero_grad()

            if epoch>=3 and q:
              model.apply(torch.quantization.disable_observer)

            # forward + backward + optimize
            outputs = model(inputs)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            # print statistics
            running_loss.update(loss.item(), outputs.shape[0])
            acc.update(accuracy(outputs, labels), outputs.shape[0])
            if i % 100 == 0:    # print every 100 mini-batches
                print('[%d, %5d] ' % (epoch + 1, i + 1), running_loss, acc)
        
        scheduler.step()
        
        
        total_sparsity = calculate_total_sparsity(model)
        desired_sparsity = (epoch + 1) / epoches * 0.7
        if total_sparsity < desired_sparsity:
            additional_sparsity = (desired_sparsity - total_sparsity) / (1 - total_sparsity)
            apply_pruning(model, additional_sparsity)
        
        print(f'Epoch {epoch + 1}: Total Sparsity: {calculate_total_sparsity(model):.2f}')
        
                
    print('Finished Training')
'''


def test(model: nn.Module, dataloader: DataLoader, cuda=False) -> float:
    correct = 0
    total = 0
    model.eval()
    print("Started Testing")
    with torch.no_grad():
        for data in dataloader:
            inputs, labels = data

            if cuda:
              inputs = inputs.cuda()
              labels = labels.cuda()

            outputs = model(inputs)
            _, predicted = torch.max(outputs.data, 1)
            total += labels.size(0)
            correct += (predicted == labels).sum().item()
    print("Finished Testing")
    
    return 100 * correct / total


def data_loader():
    transform = transforms.Compose([transforms.ToTensor()]) # , transforms.Normalize((0.5,), (0.5,))
    trainset = torchvision.datasets.MNIST(root='./data', train=True, download=True, transform=transform)
    trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True, num_workers=16, pin_memory=True)
    testset = torchvision.datasets.MNIST(root='./data', train=False, download=True, transform=transform)
    testloader = torch.utils.data.DataLoader(testset, batch_size=64, shuffle=False, num_workers=16, pin_memory=True)
    
    return trainloader, testloader


def save_quantized_model_params_to_txt(model, file_name):
    np.set_printoptions(threshold=np.inf, linewidth=np.inf)  

    with open(file_name, 'w') as file:
        for name, module in model.named_modules():
            if isinstance(module, (torch.nn.quantized.Conv2d, torch.nn.quantized.Linear)):
                weight = module.weight().int_repr().numpy()  
                file.write(f'Layer Name: {name}\n')
                file.write(f'Quantized Weight (int8): \n{weight}\n\n')
                if module.bias() is not None:
                    bias = module.bias().numpy()
                    file.write(f'Bias: \n{bias}\n\n')

            if hasattr(module, 'scale') and hasattr(module, 'zero_point'):
                scale = float(module.scale)
                zero_point = int(module.zero_point)
                file.write(f'Layer Name: {name}\n')
                file.write(f'Scale: {scale}\n')
                file.write(f'Zero Point: {zero_point}\n\n')    
    
    
def save_dequantized_model_params_to_txt(model, file_name):
    np.set_printoptions(threshold=np.inf, linewidth=np.inf)  

    with open(file_name, 'w') as file:
        for name, module in model.named_modules():
            if isinstance(module, (torch.nn.quantized.Conv2d, torch.nn.quantized.Linear)):
                weight = module.weight().dequantize().numpy()
                file.write(f'Layer Name: {name}\n')
                file.write(f'Dequantized Weight (float): \n{weight}\n\n')
                
                if module.bias() is not None:
                    bias = module.bias().numpy()
                    file.write(f'Bias (float): \n{bias}\n\n')

            if hasattr(module, 'scale') and hasattr(module, 'zero_point'):
                scale = float(module.scale)
                zero_point = int(module.zero_point)
                file.write(f'Layer Name: {name}\n')
                file.write(f'Scale: {scale}\n')
                file.write(f'Zero Point: {zero_point}\n\n')    



def make_pruned_parameters_trainable(model):
    for module in model.modules():
        if isinstance(module, torch.nn.Conv2d) or isinstance(module, torch.nn.Linear):
            module.weight = torch.nn.Parameter(module.weight)
            if module.bias is not None:
                module.bias = torch.nn.Parameter(module.bias)



if __name__ == '__main__':
    
    mode = 'aware' # demo # aware
    quan_mode = 'custom'
    trainloader, testloader = data_loader()
    net = Net(q=True).cuda()
    epoches = 20
    print("The model size without quantization")
    print_size_of_model(net)
    
    if mode == 'train':
        print_size_of_model(net)
        train(net, trainloader, cuda=True)
        score = test(net, testloader, cuda=True)
        print('Accuracy of the network on the test images: {}% - FP32'.format(score))
        
        torch.save(net.state_dict(), 'path_to_save_model.pth')
        
    # Post-training quantization
    elif mode == 'test':
        qnet = Net(q=True)
        load_model(qnet, 'path_to_save_model.pth')
        fuse_modules(qnet)
        
        if quan_mode == 'float':
            print_size_of_model(qnet)
            score = test(qnet, testloader, cuda=False)
            print('Accuracy of the fused network on the test images: {}% - FP32'.format(score))
            
        elif quan_mode == 'defalut':
            qnet.qconfig = torch.quantization.default_qconfig
            torch.quantization.prepare(qnet, inplace=True)
            test(qnet, trainloader, cuda=False)
            torch.quantization.convert(qnet, inplace=True)
            print_size_of_model(qnet)
            
            score = test(qnet, testloader, cuda=False)
            print('Accuracy of the fused and quantized network on the test images: {}% - INT8'.format(score))
            
        elif quan_mode == 'custom':
            qnet.qconfig = torch.quantization.QConfig(activation=MovingAverageMinMaxObserver.with_args(reduce_range=True), weight=MovingAverageMinMaxObserver.with_args(dtype=torch.qint8, qscheme=torch.per_tensor_symmetric))
            print(qnet.qconfig)
            torch.quantization.prepare(qnet, inplace=True)

            test(qnet, trainloader, cuda=False)
            torch.quantization.convert(qnet, inplace=True)
            print_size_of_model(qnet)
            
            score = test(qnet, testloader, cuda=False)
            print('Accuracy of the fused and quantized network on the test images: {}% - INT8'.format(score))
            
        elif quan_mode == 'fbgemm':
            qnet.qconfig = torch.quantization.get_default_qconfig('fbgemm')
            print(qnet.qconfig)
            torch.quantization.prepare(qnet, inplace=True)
            test(qnet, trainloader, cuda=False)
            torch.quantization.convert(qnet, inplace=True)
            print_size_of_model(qnet)
            
            score = test(qnet, testloader, cuda=False)
            print('Accuracy of the fused and quantized network on the test images: {}% - INT8'.format(score))
            
    elif mode == 'aware':
        
        qnet = Net(q=True)
        
        fuse_modules(qnet)
        qnet.qconfig = torch.quantization.get_default_qat_qconfig('fbgemm')
        torch.quantization.prepare_qat(qnet, inplace=True)
        
        qnet = qnet.cuda()
        train(qnet, trainloader, cuda=True, q=True, epochs=epoches)
        qnet = qnet.cpu()
        
        torch.quantization.convert(qnet, inplace=True)
        
        print_size_of_model(net)
        print("before quantization\n")
        print_size_of_model(qnet)
        print("after quantization")
        
        score = test(qnet, testloader, cuda=False)
        print('Accuracy of the fused and quantized network (trained quantized) on the test images: {}% - INT8'.format(score))
        
        # save model
        # torch.save(qnet.state_dict(), 'quantized_model_state_dict.pth')
        # torch.save(qnet, 'quantized_model.pth')
        
        # save as script
        scripted_qnet = torch.jit.script(qnet)
        
        # torch.jit.save(scripted_qnet, 'scripted_quantized_model.pth')
        
        save_quantized_model_params_to_txt(qnet, 'quantized_model_params.txt')
        # save_dequantized_model_params_to_txt(qnet, 'dequantized_model_params.txt')
        
    
    # Demo
    from PIL import Image
    # load model
    scripted_qnet = torch.jit.load('scripted_quantized_model.pth')
    
    image_path = '5.png'
    image = Image.open(image_path).convert('L')

    transform = transforms.Compose([
        transforms.Resize((28, 28)), 
        transforms.ToTensor() 
        ])
    image = transform(image).unsqueeze(0)  

    scripted_qnet.to('cpu')
    image = image.to('cpu')

    with torch.no_grad():
        output = scripted_qnet(image)

    prediction = output.argmax(dim=1)
    print(f'Predicted digit: {prediction.item()}')
    
    '''
    conv1_params = qnet.conv1.weight()
    conv1_integer_weights = qnet.conv1.weight().int_repr()

    print(conv1_params)
    print(conv1_integer_weights)
    '''
    
    '''
    # display the output of each layer
    def forward_hook(layer_name):
        def hook(module, input, output):
            outputs[layer_name].append(output.int_repr())
        return hook
    
    outputs = {'conv1': [], 'conv2': [], 'fc1': [], 'fc2': [], 'fc3': []}    
    
    qnet.conv1.register_forward_hook(forward_hook('conv1'))
    qnet.conv2.register_forward_hook(forward_hook('conv2'))
    qnet.fc1.register_forward_hook(forward_hook('fc1'))
    qnet.fc2.register_forward_hook(forward_hook('fc2'))
    qnet.fc3.register_forward_hook(forward_hook('fc3'))
    
    # qnet.fc1.register_forward_hook(forward_hook)
        
    with torch.no_grad():
        output = qnet(image)
        
    file_path = 'model_layer_outputs.txt'

    # Write the outputs to the file
    with open(file_path, 'w') as file:
        for layer, output_list in outputs.items():
            file.write(f"{layer} outputs:\n")
            for output in output_list:
                file.write(f"{output.numpy()}\n")
            file.write("\n")
        
        
    # svae each ofamp in fp format
    activations = {}

    def get_activation(name):
        def hook(model, input, output):
            if hasattr(output, 'is_quantized') and output.is_quantized:
                output = output.dequantize()
            activations[name] = output.detach()
        return hook

    model = qnet
    
    for name, layer in model.named_modules():
        layer.register_forward_hook(get_activation(name))

    with torch.no_grad():
        output = model(image)

    np.set_printoptions(threshold=np.inf, linewidth=np.inf, formatter={'float_kind':lambda x: f'{x:0.4f}'})

    def format_numpy_array(array):
        array_str = np.array2string(array, separator=', ')
        # 替換逗號和後繼空格為單個空格
        array_str = array_str.replace(', ', ' ')
        # 移除多餘的空格
        array_str = array_str.replace('[ ', '[').replace(' ]', ']')
        lines = []
        bracket_level = 0
        for char in array_str:
            if char == '[':
                bracket_level += 1
            elif char == ']':
                bracket_level -= 1

            if bracket_level == 0 and char == ']':
                lines[-1] += char
                lines.append('')
            else:
                if not lines:
                    lines.append(char)
                else:
                    lines[-1] += char
        return '\n'.join(lines).strip()


    with open('model_outputs.txt', 'w') as file:
        for name, act in activations.items():
            act_np = act.cpu().numpy()
            formatted_output = format_numpy_array(act_np)
            file.write(f'Layer Name: {name}\n')
            file.write(f'Output: \n{formatted_output}\n\n')
        
    
    '''
    
    