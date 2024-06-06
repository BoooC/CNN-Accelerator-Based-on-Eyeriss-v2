import numpy as np
from PIL import Image
import torch
import torchvision.transforms as transforms
from torchvision.datasets import MNIST


def read_matrices_from_file(file_path, matrix_size, channels):
    with open(file_path, 'r') as file:
        data = file.read().replace('[', '').replace(']', '').replace(',', '').split()
        data = [int(num) for num in data]

        if len(data) % (matrix_size * matrix_size * channels) != 0:
            raise ValueError("數據大小不適合指定的矩陣尺寸和通道數")

        num_matrices = len(data) // (matrix_size * matrix_size * channels)
        matrices = []

        for i in range(num_matrices):
            matrix = data[i * matrix_size * matrix_size * channels:(i + 1) * matrix_size * matrix_size * channels]
            matrix = np.array(matrix).reshape(channels, matrix_size, matrix_size)
            matrices.append(matrix)

        return np.array(matrices)


def read_and_group_data(file_path, elements_per_group, num_groups):
    with open(file_path, 'r') as file:
        data = file.read().replace('[', '').replace(']', '').split()

        data = [int(num) for num in data]

        if len(data) != elements_per_group * num_groups:
            raise ValueError("檔案中的數據量與指定的分組規則不匹配")

        grouped_data = np.array([data[i:i + elements_per_group] for i in range(0, len(data), elements_per_group)])

        return grouped_data



def max_pool2d(input, kernel_size, stride):
    in_height, in_width = input.shape
    out_height = (in_height - kernel_size) // stride + 1
    out_width = (in_width - kernel_size) // stride + 1

    output = np.zeros((out_height, out_width))

    for y in range(out_height):
        for x in range(out_width):
            window = input[y*stride:y*stride+kernel_size, x*stride:x*stride+kernel_size]
            output[y, x] = np.max(window)

    return output



def relu(input):
    return np.maximum(0, input)


def linear(input, weight):
    return np.dot(weight, input)


def conv_multi_input(output_channels, input_channels, kernel_height, kernel_width, weights, ifmap, stride, padding):
    if weights.shape != (output_channels, input_channels, kernel_height, kernel_width):
        raise ValueError("The shape of weights are wrong")

    output_height = int((ifmap.shape[1] - kernel_height + 2 * padding) / stride + 1)
    output_width = int((ifmap.shape[2] - kernel_width + 2 * padding) / stride + 1)

    output = np.zeros((output_channels, output_height, output_width))

    if padding > 0:
        ifmap_padded = np.pad(ifmap, ((0, 0), (padding, padding), (padding, padding)), mode='constant', constant_values=0)
    else:
        ifmap_padded = ifmap

    for i in range(output_channels):
        for j in range(input_channels):
            for y in range(output_height):
                for x in range(output_width):
                    output[i, y, x] += np.sum(
                        ifmap_padded[j, y*stride:y*stride+kernel_height, x*stride:x*stride+kernel_width] * weights[i, j]
                    )

    return output


def softmax(x):
    return np.argmax(x)


def forward(ifmap):
    relu1_out = []
    relu2_out = []
    relu3_out = []
    relu4_out = []
    
    pool1_out = []
    pool2_out = []
    
    # layer 1
    conv1_out = conv_multi_input(6, 1, 5, 5, conv1_weight, ifmap, stride=1, padding=0)
    for i in range(conv1_out.shape[0]):
        relu1_out.append(relu(conv1_out[i]))
        pool1_out.append(max_pool2d(relu1_out[i], kernel_size=2, stride=2))
        
    pool1_out = np.array(pool1_out)
    pool1_out = pool1_out // 4096
    
    # layer 2
    conv2_out = conv_multi_input(16, 6, 5, 5, conv2_weight, pool1_out, stride=1, padding=0)
    for i in range(conv2_out.shape[0]):
        relu2_out.append(relu(conv2_out[i]))
        pool2_out.append(max_pool2d(relu2_out[i], kernel_size=2, stride=2))
        
    pool2_out = np.array(pool2_out)
    pool2_out = pool2_out // 4096
    
    flattened = pool2_out.flatten()
    
    # layer 3
    fc1_out = linear(flattened, fc1_weight)
    relu3_out = relu(fc1_out)
    relu3_out =relu3_out // 4096
    
    # layer 4
    fc2_out = linear(relu3_out, fc2_weight)
    relu4_out = relu(fc2_out)
    relu4_out =relu4_out // 4096
    
    # layer 5
    fc3_out = linear(relu4_out, fc3_weight)
    
    return fc3_out

def LeNet_5(ifmap):
    output = forward(ifmap)
    prediction = softmax(output)

    print(f"The prediction is {prediction}")
    
    return prediction
    
    

def image_image_as_txt(image_path, txt_path):
    with Image.open(image_path).convert('L') as img:
        img_array = np.array(img)

        img_array = img_array.astype(np.uint8)

    with open(txt_path, 'w') as file:
        for row in img_array:
            formatted_row = '[' + ' '.join(f'{num:3d}' for num in row) + ']\n'
            file.write(formatted_row)


def save_array_with_shape(array, file_path):
    with open(file_path, 'w') as file:
        for channel in range(array.shape[0]):
            file.write(f'Channel {channel}:\n')
            for row in array[channel]:
                formatted_row = ' '.join(f'{int(num):7d}' for num in row) + '\n'
                file.write(formatted_row)
            file.write('\n')
    
    
def save_1d_array_as_int(array, file_path):
    with open(file_path, 'w') as file:
        formatted_row = ' '.join(f'{int(num):7d}' for num in array) + '\n'
        file.write(formatted_row)
        
        
def threshold_array_by_mean_abs(arr, factor=0.8):
    threshold = np.mean(np.abs(arr)) * factor
    arr[np.abs(arr) < threshold] = 0
    return arr


def zero_elements_ratio(arr):
    total_elements = arr.size
    zero_elements = np.sum(arr == 0)
    return zero_elements / total_elements


def save_ndarray_to_txt_full(arr, file_name):
    with open(file_name, 'w') as f:
        np.set_printoptions(threshold=np.inf, linewidth=np.inf, formatter={'int': lambda x: f"{x:4d}"})
        f.write(np.array2string(arr, separator=', '))


'''
input_path = '4.png'
output_path = 'layer1/5.txt'
image_image_as_txt(input_path, output_path)
'''

conv1_weight_path = 'layer1/kernel1.txt' 
conv2_weight_path = 'layer1/kernel2.txt' 

fc1_weight_path = 'layer1/kernel3.txt' 
fc2_weight_path = 'layer1/kernel4.txt' 
fc3_weight_path = 'layer1/kernel5.txt' 

ifmap_path = 'layer1/5.txt' 

conv1_weight = read_matrices_from_file(conv1_weight_path, 5, 1)
conv2_weight = read_matrices_from_file(conv2_weight_path, 5, 6)

fc1_weight = read_and_group_data(fc1_weight_path, 256, 120)
fc2_weight = read_and_group_data(fc2_weight_path, 120, 84)
fc3_weight = read_and_group_data(fc3_weight_path, 84, 10)

# purning
conv_threshold = 0.7
fc_threshold = 0.7

conv1_weight = threshold_array_by_mean_abs(conv1_weight, conv_threshold)
conv2_weight = threshold_array_by_mean_abs(conv2_weight, conv_threshold)

fc1_weight = threshold_array_by_mean_abs(fc1_weight, fc_threshold)
fc2_weight = threshold_array_by_mean_abs(fc2_weight, fc_threshold)
fc3_weight = threshold_array_by_mean_abs(fc3_weight, fc_threshold)

# calculate sparse ratio
conv1_sparsity = zero_elements_ratio(conv1_weight)
conv2_sparsity = zero_elements_ratio(conv2_weight)
fc1_sparsity = zero_elements_ratio(fc1_weight)
fc2_sparsity = zero_elements_ratio(fc2_weight)
fc3_sparsity = zero_elements_ratio(fc3_weight)


overall_sparsity = (conv1_sparsity * conv1_weight.size + conv2_sparsity * conv2_weight.size + \
                   fc1_sparsity * fc1_weight.size + fc2_sparsity * fc2_weight.size + fc3_sparsity * fc3_weight.size) / \
                   (conv1_weight.size + conv2_weight.size + fc1_weight.size + fc2_weight.size + fc3_weight.size)

print(f"The overall sparse ratio = {overall_sparsity*100}%\n")

ifmap = read_matrices_from_file(ifmap_path, 28, 1)
ifmap = np.squeeze(ifmap, axis=0)
ifmap = ifmap // 2

prediction = LeNet_5(ifmap)


'''
save_ndarray_to_txt_full(conv1_weight, 'layer1/conv1_weights.txt')
save_ndarray_to_txt_full(conv2_weight, 'layer1/conv2_weights.txt')
save_ndarray_to_txt_full(fc1_weight,   'layer1/fc1_weights.txt')
save_ndarray_to_txt_full(fc2_weight,   'layer1/fc2_weights.txt')
save_ndarray_to_txt_full(fc3_weight,   'layer1/fc3_weights.txt')


relu1_out = np.array(relu1_out)
relu2_out = np.array(relu2_out)

save_array_with_shape(conv1_out, 'layer1/each_layer_out/conv1_out.txt')
save_array_with_shape(relu1_out, 'layer1/each_layer_out/relu1_out.txt')
save_array_with_shape(pool1_out, 'layer1/each_layer_out/pool1_out.txt')

save_array_with_shape(conv2_out, 'layer1/each_layer_out/conv2_out.txt')
save_array_with_shape(relu2_out, 'layer1/each_layer_out/relu2_out.txt')
save_array_with_shape(pool2_out, 'layer1/each_layer_out/pool2_out.txt')

save_1d_array_as_int(fc1_out, 'layer1/each_layer_out/fc1_out.txt')
save_1d_array_as_int(relu3_out, 'layer1/each_layer_out/relu3_out.txt')

save_1d_array_as_int(fc2_out, 'layer1/each_layer_out/fc2_out.txt')
save_1d_array_as_int(relu4_out, 'layer1/each_layer_out/relu4_out.txt')

save_1d_array_as_int(fc3_out, 'layer1/each_layer_out/fc3_out.txt')

'''

'''
# MNIST Test
def evaluate_mnist(model_func, batch_size=1):
    transform = transforms.Compose([transforms.ToTensor()])
    test_data = MNIST(root='./data', train=False, download=True, transform=transform)
    test_loader = torch.utils.data.DataLoader(test_data, batch_size=batch_size, shuffle=False)
    
    total = 0
    correct = 0
    i = 0
    for images, labels in test_loader:
        images_np = images.numpy() * 255
        images_np = images_np.astype(np.uint8)
        images_np = np.squeeze(images_np, axis=1)  
        images_np = images_np // 2
        
        for i in range(len(images_np)):
            ifmap = images_np[i].reshape(1, 28, 28)  
            predicted = model_func(ifmap)
            correct += (predicted == labels[i].item())
            
        total += len(images)
        
        print(f" {correct}   /   {total}")
        
        if total == 1000:
            break
        
    accuracy = correct / total *100
    return accuracy

accuracy = evaluate_mnist(LeNet_5, 10)
print(f'Accuracy on MNIST test set: {accuracy:.4f}%')
'''



