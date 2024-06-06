import tkinter as tk
from tkinter import Button
from PIL import Image, ImageDraw, ImageOps
import numpy as np
import datetime 
import time 


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
        raise ValueError("Weights的形狀不正確")

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

    print("\n")
    print(f"The prediction is {prediction}")
    
    return prediction
    

def threshold_array_by_mean_abs(arr, factor=0.8):
    threshold = np.mean(np.abs(arr)) * factor
    arr[np.abs(arr) < threshold] = 0
    return arr


class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.canvas = tk.Canvas(self, width=280, height=280, bg='black')
        self.canvas.pack(padx=10, pady=10)

        # 创建 PIL 图像和绘图对象，背景为黑色
        self.image = Image.new('L', (280, 280), 'black')
        self.draw = ImageDraw.Draw(self.image)

        # 画笔设置为白色
        self.brush_size = 10
        self.brush_color = 'white'
        self.setup()

        # 添加预测按钮
        self.predict_button = Button(self, text='Predict', command=self.predict)
        self.predict_button.pack(side=tk.LEFT, padx=10, pady=10)

        # 添加清除按钮
        self.clear_button = Button(self, text='Clear', command=self.clear_canvas)
        self.clear_button.pack(side=tk.RIGHT, padx=10, pady=10)
        
        # 添加保存图像按钮
        self.save_button = Button(self, text='Save Image', command=self.save_image)
        self.save_button.pack(side=tk.RIGHT, padx=10, pady=10)

    def setup(self):
        self.canvas.bind('<B1-Motion>', self.paint)
        self.canvas.bind('<ButtonRelease-1>', self.reset)

    def paint(self, event):
        x1, y1 = (event.x - self.brush_size), (event.y - self.brush_size)
        x2, y2 = (event.x + self.brush_size), (event.y + self.brush_size)
        self.canvas.create_oval(x1, y1, x2, y2, fill=self.brush_color, outline='')
        self.draw.ellipse([x1, y1, x2, y2], fill=self.brush_color)

    def reset(self, event):
        self.canvas.bind('<B1-Motion>', self.paint)

    def clear_canvas(self):
        self.canvas.delete('all')
        self.image = Image.new('L', (280, 280), 'black')
        self.draw = ImageDraw.Draw(self.image)

    def preprocess(self):
        img_28x28 = self.image.resize((28, 28), Image.ANTIALIAS)
        img_28x28 = ImageOps.invert(img_28x28)  
        img_np = np.array(img_28x28.convert("L"))

        img_np = img_np.astype(np.uint8)

        img_np = img_np.reshape(1, 28, 28)
        
        img_np = 255 - img_np
        
        img_np = img_np // 2
        
        return img_np
    
    def save_image(self):
        img_28x28 = self.image.resize((28, 28), Image.ANTIALIAS)
        img_28x28 = ImageOps.invert(img_28x28) 

        img_28x28 = img_28x28.convert("L")
        timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"digit_{timestamp}.jpg"
        img_28x28.save(filename, 'JPEG')
        print(f"Image saved as {filename}")
        
    def predict(self):
        ifmap = self.preprocess()

        print("Handwritten digit as matrix (0-255):")
        print(ifmap)

        start_time = time.time()
        prediction = LeNet_5(ifmap)  
        end_time = time.time()
        inference_time = end_time - start_time

        print(f'Inference time: {inference_time:.4f} seconds')
        print(f'The prediction is {prediction}')
        


conv1_weight_path = 'layer1/kernel1.txt' 
conv2_weight_path = 'layer1/kernel2.txt' 

fc1_weight_path = 'layer1/kernel3.txt' 
fc2_weight_path = 'layer1/kernel4.txt' 
fc3_weight_path = 'layer1/kernel5.txt' 


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

app = App()
app.mainloop()



