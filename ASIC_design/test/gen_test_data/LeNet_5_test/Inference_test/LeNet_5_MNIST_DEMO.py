import tkinter as tk
from tkinter import Button
from PIL import Image, ImageDraw, ImageOps
import torch
import numpy as np
from torchvision import transforms
import datetime 
import time 

class App(tk.Tk):
    def __init__(self, model):
        super().__init__()
        self.model = model
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
        # 缩小图像并转为灰度
        img = self.image.resize((28, 28), Image.ANTIALIAS)
        
        transform = transforms.Compose([
            transforms.ToTensor()# , 
            # transforms.Normalize((0.1307,), (0.3081,)) 
        ])
        img = transform(img).unsqueeze(0)
        return img
    
    def save_image(self):
        # 保存处理后的 28x28 图像
        img_28x28 = self.image.resize((28, 28), Image.ANTIALIAS)
        img_28x28 = ImageOps.invert(img_28x28)  # 反转颜色以匹配 MNIST 数据集的格式
        img_28x28 = img_28x28.convert("L")  # 确保图像是灰度格式

        timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")
        filename = f"digit_{timestamp}.jpg"
        img_28x28.save(filename, 'JPEG')
        print(f"Image saved as {filename}")

    def predict(self):
        img = self.preprocess()

        np_img = np.array(self.image.resize((28, 28), Image.ANTIALIAS))
        print("Handwritten digit as matrix (0-255):")
        print(np_img)

        self.model.to('cpu')
        img = img.to('cpu')

        start_time = time.time()

        with torch.no_grad():
            output = self.model(img)
            
        end_time = time.time()
        inference_time = end_time - start_time
        print(f'Inference time: {inference_time:.4f} seconds')

        prediction = output.argmax(dim=1)
        print(f'Predicted digit: {prediction.item()}')

# 加载模型
scripted_qnet = torch.jit.load('scripted_quantized_model.pth')

# 运行应用
app = App(scripted_qnet)
app.mainloop()
