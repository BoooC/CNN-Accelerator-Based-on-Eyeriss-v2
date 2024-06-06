

import torch
import torch.nn as nn
import torch.optim as optim
import torchvision.transforms as transforms
from torch.optim import lr_scheduler
from torchvision import datasets
from torchvision import models
from torch.utils.data import DataLoader
from matplotlib import pyplot as plt
import copy
import pandas as pd

def get_data_loaders(batch_size , train = False):
    if train:
        transform = transforms.Compose([
            transforms.Resize(196),
            transforms.CenterCrop(180),
            transforms.ToTensor(),
            transforms.RandomHorizontalFlip(p = 0.3),
            transforms.RandomVerticalFlip(p = 0.01),
            transforms.RandomApply(torch.nn.ModuleList([transforms.ColorJitter(), transforms.GaussianBlur(3)]), p = 0.1),
            transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225))
        ])
        
        train_set    = datasets.ImageFolder("dataset/train/", transform = transform)
        train_loader = DataLoader(train_set, batch_size = batch_size, shuffle = True)
        
        return train_loader, len(train_set)
    
    else:
        transform = transforms.Compose([
            transforms.Resize(196),
            transforms.CenterCrop(180),
            transforms.ToTensor(),
            transforms.Normalize((0.485, 0.456, 0.406), (0.229, 0.224, 0.225)),
        ])
        
        vali_set = datasets.ImageFolder("dataset/valid/", transform = transform)
        test_set = datasets.ImageFolder("dataset/test/",  transform = transform)
        
        vali_loader = DataLoader(vali_set, batch_size = batch_size, shuffle = True)
        test_loader = DataLoader(test_set, batch_size = batch_size, shuffle = True)
        
        return vali_loader, test_loader, len(vali_set), len(test_set)
    
def train_model(model, criterion, optimizer, scheduler):
    model.train()
                
    wrongs   = 0.0
    corrects = 0
            
    for inputs, labels in train_loader:
        inputs = inputs.to(device)
        labels = labels.to(device)
        # initailization
        optimizer.zero_grad()
        
        with torch.set_grad_enabled(True):        
            outputs = model(inputs)
            _, pred = torch.max(outputs, 1)
            loss = criterion(outputs, labels)
                        
            loss.backward()
            optimizer.step()
           
        wrongs   += loss.item() * inputs.size(0)
        corrects += torch.sum(pred == labels.data)
            
    epoch_loss = wrongs / len_train_data
    epoch_accu = corrects.double() / len_train_data
    
    scheduler.step()        
    Training_Loss.append(float(epoch_loss))
    Training_Accuracy.append(float(epoch_accu))
    
    print("Training   Loss: {:.4f} | Accuracy: {:.4f}".format(epoch_loss, epoch_accu))
    
def validate_model(model):
    model.eval()
    
    wrongs   = 0.0
    corrects = 0
    
    with torch.no_grad():
        for inputs, labels in valid_loader:
            inputs = inputs.to(device)
            labels = labels.to(device)
            
            with torch.set_grad_enabled(False):
                outputs = model(inputs)
                _, pred = torch.max(outputs, 1)
                loss = criterion(outputs, labels)
            
            wrongs   += loss.item() * inputs.size(0)
            corrects += torch.sum(pred == labels.data)
                
        epoch_loss = wrongs / len_test_data
        epoch_accu = corrects.double() / len_test_data
        
        Validation_Loss.append(float(epoch_loss))
        Validation_Accuracy.append(float(epoch_accu))
        
        print("Validation Loss: {:.4f} | Accuracy: {:.4f}".format(epoch_loss, epoch_accu))
    return epoch_accu           
    
    
def test_model(model):
    model.eval()
    
    wrongs   = 0.0
    corrects = 0
    
    with torch.no_grad():
        for inputs, labels in test_loader:
            inputs = inputs.to(device)
            labels = labels.to(device)
            
            with torch.set_grad_enabled(False):
                outputs = model(inputs)
                _, pred = torch.max(outputs, 1)
                loss = criterion(outputs, labels)
            
            wrongs   += loss.item() * inputs.size(0)
            corrects += torch.sum(pred == labels.data)
                
        epoch_loss = wrongs / len_test_data
        epoch_accu = corrects.double() / len_test_data
        
        Testing_Loss.append(float(epoch_loss))
        Testing_Accuracy.append(float(epoch_accu))
        
        print("Testing    Loss: {:.4f} | Accuracy: {:.4f}".format(epoch_loss, epoch_accu))
    return epoch_accu             


def test_img(model, inputs):
    model.eval()
    
    with torch.no_grad():
        inputs = inputs.to(device)
            
        with torch.set_grad_enabled(False):
            outputs = model(inputs)
            _, pred = torch.max(outputs, 1)
            
        
    return outputs, pred          



# cuda
device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")

class_dict = pd.read_csv("dataset/class_dict.csv")
classes    = list(class_dict['class'])
num_class  = len(classes)

# parameters
batch_size = 64
epochs     = 10 
Learning_rate = 0.005

# data loader
train_loader, len_train_data = get_data_loaders(batch_size = batch_size, train = True)
valid_loader, test_loader, len_valid_data, len_test_data = get_data_loaders(batch_size = batch_size, train = False)

Training_Loss       = []
Testing_Loss        = []
Validation_Loss     = []
Training_Accuracy   = []
Testing_Accuracy    = []
Validation_Accuracy = []

'''
#------------------- resnet18 -----------------#
# use resnet18 structure
model = torch.hub.load('pytorch/vision:v0.10.0', 'mobilenet_v2', pretrained=True)

for param in model.parameters():
    param.requires_grad = False

# append output features = num_class(400)  (transfer learning)
num_ftrs   = model.fc.in_features # inputs of the lastest fc layer 
model.fc   = nn.Linear(num_ftrs , num_class) 
#------------------- resnet18 -----------------#
'''

'''
#------------------   vgg16  ------------------#
# use VGG16 structure
model = torch.hub.load('pytorch/vision:v0.10.0', 'vgg16', pretrained=True)

for param in model.features.parameters():
    param.requires_grad = False
    
# append output features = num_class(400)  (transfer learning)
num_ftrs = model.classifier[6].in_features
feature_model = list(model.classifier.children())
feature_model.pop()            
feature_model.append(nn.Linear(num_ftrs, num_class))
model.classifier = nn.Sequential(*feature_model)
#------------------   vgg16  ------------------#
'''

#------------------   mobilenet_v2  ------------------#
# use mobilenet_v2 structure
model = torch.hub.load('pytorch/vision', 'mobilenet_v2', pretrained=True)

for param in model.features.parameters():
    param.requires_grad = False
    
# append output features = num_class(400)  (transfer learning)
num_ftrs = model.classifier[1].in_features
feature_model = list(model.classifier.children())
feature_model.pop()            
feature_model.append(nn.Linear(num_ftrs, num_class))
model.classifier = nn.Sequential(*feature_model)
#------------------   mobilenet_v2  ------------------#


# condition settings
model      = model.to(device)
criterion  = nn.CrossEntropyLoss()
optimizer  = optim.SGD(model.parameters(), lr = Learning_rate, momentum = 0.9)
exp_lr_sch = lr_scheduler.StepLR(optimizer, step_size = 2, gamma = 0.8) # learning rate regulated 

# main
epoch_accu = 0.0
best_accu  = 0.0
for epoch in range(epochs):
    best_weight = copy.deepcopy(model.state_dict())
    print("Epoch : {} / {}".format(epoch + 1, epochs))
    print("-" * 40)
    # training
    train_model(model, criterion, optimizer, exp_lr_sch)
    # validation
    epoch_accu = validate_model (model)
    print('\t')
    
    if(epoch_accu > best_accu):
        best_accu   = epoch_accu
        best_weight = copy.deepcopy(model.state_dict())
    
    if(epoch == epochs-1):
        print("Best Validation Accuracy : {}".format(best_accu))
        print('\t')
        print("-" * 40)
        print("Testing...")
        test_model (model)


model.load_state_dict(best_weight)


'''
torch.save(model,'trained_model.pt')
'''

# plot
epoch = [x for x in range(1, epochs+1)]
plt.figure(1)
plt.plot(epoch, Training_Loss, color = 'blue')
#plt.plot(epoch, Validation_Loss,  linestyle='-', marker = '*', color = 'red')
plt.title("Loss")
plt.xlabel("Epochs")
plt.ylabel("Loss")
plt.legend(['Training_Loss', 'Testing_Loss'], title_fontsize = 15)

plt.figure(2)
plt.plot(epoch, Training_Accuracy, color = 'blue')
#plt.plot(epoch, Validation_Accuracy,  linestyle='-', marker = '*', color = 'red')
plt.title("Accuracy")
plt.xlabel("Epochs")
plt.ylabel("Accuracy")
plt.legend(['Training_Accuracy', 'Testing_Accuracy'], title_fontsize = 15)


'''
import cv2 as cv
import torch
from model import MobileNetV2
from PIL import Image
from torchvision import transforms
import matplotlib.pyplot as plt
import json

data_transform = transforms.Compose(
    [transforms.Resize(256),
     transforms.CenterCrop(224),
     transforms.ToTensor(),
     transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])])

# load image
    
PATH = '1.jpg'
img = cv.imread(PATH)
plt.imshow(img)

img = data_transform(img)
# expand batch dimension
img = torch.unsqueeze(img, dim=0)

# create model
#model = MobileNetV2(num_classes=400)
# load model weights
#model_weight_path = "./MobileNetV2.pth"
#model.load_state_dict(best_weight)
model.eval()
with torch.no_grad():
    # predict class
    output = torch.squeeze(model(img))
    predict = torch.softmax(output, dim=0)
    predict_cla = torch.argmax(predict).numpy()
print(predict[predict_cla].numpy())
plt.show()
'''

