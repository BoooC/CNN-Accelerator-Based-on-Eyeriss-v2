import numpy as np
import torch
import torchvision.transforms as transforms
from torchvision.datasets import MNIST
import tkinter as tk
from tkinter import Button, ttk
from PIL import Image, ImageDraw, ImageOps
import datetime 
import time 
import serial
import serial.tools.list_ports  


def elementwise_addition(list1, list2, list3):
    return [a + b + c for a, b, c in zip(list1, list2, list3)]


def genAdrCountData(listA, inActOrWeight, modified_mask):
    if inActOrWeight:
        zeroCode = 255
        # max_val = 255
        max_count = 31
    else:
        zeroCode = 127
        # max_val = 127
        max_count = 15

    adrList = []
    countList = []
    dataList = []

    for j in range(len(listA[0])):  # for each column
        currentCol = [row[j] for row in listA]
        currentMaskCol = [row[j] for row in modified_mask]
        if max(map(abs, currentCol)) == 0:
            adrList.append(zeroCode)
        else:
            if j != 0:
                adrList.append(len(dataList))
            for i, value in enumerate(currentCol):
                if value != 0:
                    if currentMaskCol[i]:
                        countList.append(max_count) 
                    else:
                        countList.append(i)
                    dataList.append(value)

    # if the last column contains more than one elements
    if len(dataList) - 1 > adrList[-1]:
        adrList.append(len(dataList))

    # Check if the last column has only one non-zero element and ensure it's address is added
    if len(dataList) - adrList[-1] == 1:
        adrList.append(len(dataList))    
    
    if all([row[-1] == 0 for row in listA]):
        adrList.append(zeroCode)
        
    # add zero signal to their end
    adrList.append(0)
    countList.append(0)
    dataList.append(0)
        
    return adrList, countList, dataList 


def csc_compression_single_col(matrix):
    addr = []
    count = []
    data = []

    for row_idx in range(matrix.shape[0]):
        for col_idx in range(matrix.shape[1]):
            value = int(matrix[row_idx, col_idx])
            if value != 0:
                count.append(row_idx)
                data.append(value)

    addr.append(len(data))
    
    addr.append(0)
    count.append(0)
    data.append(0)

    return addr, count, data


def toBinary(i, digits, signed=False):
    if signed:
        # Handle negative numbers using two's complement
        if i < 0:
            # Calculate two's complement for negative numbers
            return format((1 << digits) + i, f'0{digits}b')
        else:
            # Positive numbers are the same as unsigned
            return format(i, f'0{digits}b')
    else:
        # Unsigned conversion
        return format(i, f'0{digits}b')
    

def combineDataAndCount(theData, theCount, cscDataWidth=8, cscCountWidth=4):
    theDataWithCount = list(zip(theData, theCount))
    theDataCountBinary = [toBinary(x, cscDataWidth, signed=True) + toBinary(y, cscCountWidth, signed=False) for x, y in theDataWithCount]
    # theDataCountSigned = [int(binary_str, 2) if binary_str[0] == '0' else int(binary_str, 2) - (1 << (cscDataWidth + cscCountWidth)) for binary_str in theDataCountBinary]
    return theDataCountBinary



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



def modify_matrix(matrix):
    rows, cols = matrix.shape
    modified_mask = np.zeros_like(matrix, dtype=bool) 

    for j in range(cols):
        if np.all(matrix[:, j] == 0):
            matrix[-1, j] = 1
            modified_mask[-1, j] = True

    return matrix, modified_mask

'''
# first 2 col, contineous col, last col processing
def modify_matrix(matrix):
    rows, cols = matrix.shape
    last_col_was_zero = False
    modified_mask = np.zeros_like(matrix, dtype=bool) 

    for j in range(2):
        if np.all(matrix[:, j] == 0):
            matrix[-1, j] = 1
            modified_mask[-1, j] = True
            last_col_was_zero = True
        else:
            last_col_was_zero = False

    for j in range(2, cols):
        if np.all(matrix[:, j] == 0):
            if not last_col_was_zero:
                matrix[-1, j] = 1
                modified_mask[-1, j] = True
                last_col_was_zero = True
            else:
                last_col_was_zero = False
        else:
            last_col_was_zero = False

    if cols > 1 and np.all(matrix[:, -1] == 0):
        matrix[-1, -1] = 1
        modified_mask[-1, j] = True

    return matrix, modified_mask
'''


def im2col(input_array, kernel_size):
    # Extracting the dimensions of the input array
    input_height, input_width = input_array.shape

    # Output dimensions
    output_height = input_height - kernel_size + 1
    output_width = input_width - kernel_size + 1

    # Initialize the output array
    col_array = np.zeros((output_height * output_width, kernel_size * kernel_size))

    # Perform im2col transformation
    col_row = 0
    for y in range(0, output_height):
        for x in range(0, output_width):
            window = input_array[y:y+kernel_size, x:x+kernel_size].flatten()
            col_array[col_row, :] = window
            col_row += 1

    return col_array


def matrix_multiply(arr1, arr2):
    return np.dot(arr1, arr2)


def flatten_2d_array(arr):
    return arr.flatten()


def stack_and_transpose(arrays):
    stacked_array = np.vstack(arrays)
    return np.transpose(stacked_array)   

def reshape_to_squares(arr, side_length):
    rows, cols = arr.shape

    if rows != side_length * side_length:
        raise ValueError("每列的元素数量不足以填充方阵")

    reshaped = [arr[:, i].reshape(side_length, side_length) for i in range(cols)]
    return reshaped


def merge_arrays(*arrays):
    if not arrays:
        raise ValueError("至少需要一个数组来进行合并")
    
    shape = arrays[0].shape
    if not all(arr.shape == shape for arr in arrays):
        raise ValueError("所有数组的形状必须相同")

    result = np.zeros(shape)

    for arr in arrays:
        result = np.add(result, arr)

    return result


def reshape_array(arr, rows, cols):
    if arr.size != rows * cols:
        raise ValueError("数组的长度必须等于 rows * cols")

    reshaped_array = arr.reshape(rows, cols)
    return reshaped_array


def binary_str_to_16bit_hex(binary_list):
    hex_list = [format(int(binary_str, 2), '04x') for binary_str in binary_list]
    return hex_list

def binary_str_to_12bit_hex(binary_list):
    hex_list = [format(int(binary_str, 2), '03x') for binary_str in binary_list]
    return hex_list
            
def save_dec_as_hex_to_txt(input_list, filename, mode):
    hex_list = [hex(item)[2:] for item in input_list]
    
    with open(filename, mode) as file:
        for hex_val in hex_list:
            file.write(hex_val + "\n")


def save_data_to_txt(data_list, filename, mode):
    with open(filename, mode) as file:
        for item in data_list:
            file.write(item + "\n")


            
def goldenFlatResult(golden_result):
    resultList = []
    
    for j in range(len(golden_result[0])):
        currentCol = [row[j] for row in golden_result]
        resultList.extend(currentCol)
        
    return resultList            


def save_array_to_txt(array, filename, mode):
    int_array = array.astype(int)

    flattened = int_array.flatten()

    with open(filename, mode) as file:
        for item in flattened:
            file.write(str(item) + '\n')

'''
def save_array_to_21bit_binary_txt(arr, filename):
    int_array = arr.astype(int)

    with open(filename, 'w') as file:
        for col in range(arr.shape[1]):
            for row in range(arr.shape[0]):
                item = int_array[row, col]
                if item < 0:
                    binary_str = format(2**21 + item, '021b')
                else:
                    binary_str = format(item, '021b')
                
                file.write(binary_str + '\n')
'''

def save_array_to_21bit_binary_txt(array, filename, mode):
    int_array = array.astype(int)

    flattened = int_array.flatten()

    with open(filename, mode) as file:
        for item in flattened:
            if item < 0:
                binary_str = format(2**21 + item, '021b')
            else:
                binary_str = format(item, '021b')
            
            file.write(binary_str + '\n')
            

'''
def save_array_to_21bit_binary_txt(arr, filename):
    int_array = arr.astype(int)

    with open(filename, 'w') as file:
        for col in range(arr.shape[1]):
            for row in range(arr.shape[0]):
                item = int_array[row, col]
                if item < 0:
                    binary_str = format(2**21 + item, '021b')
                else:
                    binary_str = format(item, '021b')
                
                file.write(binary_str + '\n')
'''

def save_3d_array_as_hex_to_txt(array, filename):
    with open(filename, 'w') as file:
        for depth in range(array.shape[0]):
            for row in range(array.shape[1]):
                for col in range(array.shape[2]):
                    hex_str = format(int(array[depth, row, col]), 'x')
                    file.write(hex_str + '\n')


def save_array_as_8bit_hex_to_txt(array, filename):
    with open(filename, 'w') as file:
        for val in array.flatten():
            hex_val = format(int(val) & 0xff, '02x')
            file.write(hex_val + '\n')
            

def check_groups_for_zeros(array):
    split_arrays = np.split(array.flatten(), 4)
    
    for i, group in enumerate(split_arrays):
        if np.all(group == 0):
            print(f"Group {i+1} is all zeros.")
    
            


def LeNet_with_GEMM(ifmap_matrix):
	quan_scale = 1024
	layer_1_out_split = []
	for i in range(ifmap_matrix.shape[0] // 4 ):
		# noise
		ifamp_splited, ifamp_splited_mask = modify_matrix(ifmap_matrix[4 * i: 4 * i + 4])
		
		iact_0_addr, iact_0_count, iact_0_data = genAdrCountData(ifamp_splited, True, ifamp_splited_mask)
		iact_0_data_count = combineDataAndCount([int(item) for item in iact_0_data], iact_0_count, cscDataWidth=8, cscCountWidth=4)
		'''
		if i == 0:
			mode='w'
		else:
			mode='a'
			
		save_dec_as_hex_to_txt(iact_0_addr, 'iact_0_addr.txt', mode)
		
		save_data_to_txt(iact_0_data_count, 'iact_0_data_count.txt', mode) 
        '''
		
		result = matrix_multiply(ifamp_splited, conv1_weight_merge)
		layer_1_out_split.append(result)
		
	layer_1_out = np.vstack(layer_1_out_split)
	layer_1_out = np.array(reshape_to_squares(layer_1_out,24))
	
	# save_array_to_21bit_binary_txt(layer_1_out, 'layer_1_out.txt')
	
	relu1_out = []
	pool1_out = []
	for i in range(layer_1_out.shape[0]):
		relu1_out.append(relu(layer_1_out[i]))
		pool1_out.append(max_pool2d(relu1_out[i], kernel_size=2, stride=2))
			
	pool1_out = np.array(pool1_out)
	pool1_out = pool1_out // quan_scale
	
	
	layer_1_out_matrix_0_c0 = im2col(pool1_out[0], 5)
	layer_1_out_matrix_0_c1 = im2col(pool1_out[1], 5)
	layer_1_out_matrix_0_c2 = im2col(pool1_out[2], 5)
	layer_1_out_matrix_0_c3 = im2col(pool1_out[3], 5)
	layer_1_out_matrix_0_c4 = im2col(pool1_out[4], 5)
	layer_1_out_matrix_0_c5 = im2col(pool1_out[5], 5)
	
	
	# layer 2
	psum_c0_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c0), conv2_weight_merge_c0_former).astype(int)
	psum_c0_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c0), conv2_weight_merge_c0_later).astype(int)
	psum_c1_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c1), conv2_weight_merge_c1_former).astype(int)
	psum_c1_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c1), conv2_weight_merge_c1_later).astype(int)
	psum_c2_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c2), conv2_weight_merge_c2_former).astype(int)
	psum_c2_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c2), conv2_weight_merge_c2_later).astype(int)
	psum_c3_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c3), conv2_weight_merge_c3_former).astype(int)
	psum_c3_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c3), conv2_weight_merge_c3_later).astype(int)
	psum_c4_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c4), conv2_weight_merge_c4_former).astype(int)
	psum_c4_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c4), conv2_weight_merge_c4_later).astype(int)
	psum_c5_former = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c5), conv2_weight_merge_c5_former).astype(int)
	psum_c5_later  = matrix_multiply(modify_matrix(layer_1_out_matrix_0_c5), conv2_weight_merge_c5_later).astype(int)
    
	conv2_out_former = psum_c0_former+psum_c1_former+psum_c2_former+psum_c3_former+psum_c4_former+psum_c5_former
	conv2_out_later  = psum_c0_later+psum_c1_later+psum_c2_later+psum_c3_later+psum_c4_later+psum_c5_later
	conv2_out        = np.hstack((conv2_out_former, conv2_out_later))
    
	layer_2_out_split_0 = []
	layer_2_out_split_1 = []
	layer_2_out_split_2 = []
	layer_2_out_split_3 = []
	layer_2_out_split_4 = []
	layer_2_out_split_5 = []
	for i in range(layer_1_out_matrix_0_c0.shape[0] // 4):
		# noise
		ifamp_splited_0, ifamp_splited_0_mask = modify_matrix(layer_1_out_matrix_0_c0[4 * i: 4 * i + 4])
		ifamp_splited_1, ifamp_splited_1_mask = modify_matrix(layer_1_out_matrix_0_c1[4 * i: 4 * i + 4])
		ifamp_splited_2, ifamp_splited_2_mask = modify_matrix(layer_1_out_matrix_0_c2[4 * i: 4 * i + 4])
		ifamp_splited_3, ifamp_splited_3_mask = modify_matrix(layer_1_out_matrix_0_c3[4 * i: 4 * i + 4])
		ifamp_splited_4, ifamp_splited_4_mask = modify_matrix(layer_1_out_matrix_0_c4[4 * i: 4 * i + 4])
		ifamp_splited_5, ifamp_splited_5_mask = modify_matrix(layer_1_out_matrix_0_c5[4 * i: 4 * i + 4])
		
		iact_2_c0_addr, iact_2_c0_count, iact_2_c0_data = genAdrCountData(ifamp_splited_0, True, ifamp_splited_0_mask)
		iact_2_c1_addr, iact_2_c1_count, iact_2_c1_data = genAdrCountData(ifamp_splited_1, True, ifamp_splited_1_mask)
		iact_2_c2_addr, iact_2_c2_count, iact_2_c2_data = genAdrCountData(ifamp_splited_2, True, ifamp_splited_2_mask)
		iact_2_c3_addr, iact_2_c3_count, iact_2_c3_data = genAdrCountData(ifamp_splited_3, True, ifamp_splited_3_mask)
		iact_2_c4_addr, iact_2_c4_count, iact_2_c4_data = genAdrCountData(ifamp_splited_4, True, ifamp_splited_4_mask)
		iact_2_c5_addr, iact_2_c5_count, iact_2_c5_data = genAdrCountData(ifamp_splited_5, True, ifamp_splited_5_mask)
		
		iact_0_data_count = combineDataAndCount([int(item) for item in iact_2_c0_data], iact_2_c0_count, cscDataWidth=8, cscCountWidth=4)
		iact_1_data_count = combineDataAndCount([int(item) for item in iact_2_c1_data], iact_2_c1_count, cscDataWidth=8, cscCountWidth=4)
		iact_2_data_count = combineDataAndCount([int(item) for item in iact_2_c2_data], iact_2_c2_count, cscDataWidth=8, cscCountWidth=4)
		iact_3_data_count = combineDataAndCount([int(item) for item in iact_2_c3_data], iact_2_c3_count, cscDataWidth=8, cscCountWidth=4)
		iact_4_data_count = combineDataAndCount([int(item) for item in iact_2_c4_data], iact_2_c4_count, cscDataWidth=8, cscCountWidth=4)
		iact_5_data_count = combineDataAndCount([int(item) for item in iact_2_c5_data], iact_2_c5_count, cscDataWidth=8, cscCountWidth=4)
		'''
		if i == 0:
			mode='w'
		else:
			mode='a'
			
		save_dec_as_hex_to_txt(iact_2_c0_addr, 'iact_2_c0_addr.txt', mode)
		save_dec_as_hex_to_txt(iact_2_c1_addr, 'iact_2_c1_addr.txt', mode)
		save_dec_as_hex_to_txt(iact_2_c2_addr, 'iact_2_c2_addr.txt', mode)
		save_dec_as_hex_to_txt(iact_2_c3_addr, 'iact_2_c3_addr.txt', mode)
		save_dec_as_hex_to_txt(iact_2_c4_addr, 'iact_2_c4_addr.txt', mode)
		save_dec_as_hex_to_txt(iact_2_c5_addr, 'iact_2_c5_addr.txt', mode)
		
		save_data_to_txt(iact_0_data_count, 'iact_2_c0_data_count.txt', mode) 
		save_data_to_txt(iact_1_data_count, 'iact_2_c1_data_count.txt', mode) 
		save_data_to_txt(iact_2_data_count, 'iact_2_c2_data_count.txt', mode) 
		save_data_to_txt(iact_3_data_count, 'iact_2_c3_data_count.txt', mode) 
		save_data_to_txt(iact_4_data_count, 'iact_2_c4_data_count.txt', mode) 
		save_data_to_txt(iact_5_data_count, 'iact_2_c5_data_count.txt', mode) 
		'''
       
		result_0 = matrix_multiply(ifamp_splited_0, conv2_weight_merge_c0)
		result_1 = matrix_multiply(ifamp_splited_1, conv2_weight_merge_c1)
		result_2 = matrix_multiply(ifamp_splited_2, conv2_weight_merge_c2)
		result_3 = matrix_multiply(ifamp_splited_3, conv2_weight_merge_c3)
		result_4 = matrix_multiply(ifamp_splited_4, conv2_weight_merge_c4)
		result_5 = matrix_multiply(ifamp_splited_5, conv2_weight_merge_c5)
		
        
		layer_2_out_split_0.append(result_0)
		layer_2_out_split_1.append(result_1)
		layer_2_out_split_2.append(result_2)
		layer_2_out_split_3.append(result_3)
		layer_2_out_split_4.append(result_4)
		layer_2_out_split_5.append(result_5)
		
	layer_2_out_0 = np.vstack(layer_2_out_split_0)
	layer_2_out_1 = np.vstack(layer_2_out_split_1)
	layer_2_out_2 = np.vstack(layer_2_out_split_2)
	layer_2_out_3 = np.vstack(layer_2_out_split_3)
	layer_2_out_4 = np.vstack(layer_2_out_split_4)
	layer_2_out_5 = np.vstack(layer_2_out_split_5)
	
	layer_2_out = merge_arrays(layer_2_out_0, layer_2_out_1, layer_2_out_2, layer_2_out_3, layer_2_out_4, layer_2_out_5)
	
	# save_array_to_21bit_binary_txt(layer_2_out, 'layer_2_out.txt', 'w')
    
	layer_2_out = np.array(reshape_to_squares(layer_2_out, 8))
	
	relu2_out = []
	pool2_out = []
	for i in range(layer_2_out.shape[0]):
		relu2_out.append(relu(layer_2_out[i]))
		pool2_out.append(max_pool2d(relu2_out[i], kernel_size=2, stride=2))
			
	pool2_out = np.array(pool2_out)
	pool2_out = pool2_out // quan_scale
	
	
	flattened = pool2_out.flatten()
		
	# layer 3
	iact_3_addr_list = []
	iact_3_data_count_list = []
	ifmap_batches = 16
	for i in range(ifmap_batches):
		single_col = flattened[i*ifmap_batches:(i+1)*ifmap_batches].reshape(-1, 1)
		iact_3_addr, iact_3_count, iact_3_data = csc_compression_single_col(single_col)
		iact_3_data_count = combineDataAndCount(iact_3_data, iact_3_count, cscDataWidth=8, cscCountWidth=5)
		
		iact_3_addr_list.append(iact_3_addr)
		iact_3_data_count_list.append(iact_3_data_count)
        
		'''
		if i == 0:
			mode = 'w'
		else:
			mode = 'a'
			
		for j in range(30):
			save_dec_as_hex_to_txt(iact_3_addr, 'iact_3_addr.txt', mode)
			save_data_to_txt(iact_3_data_count, 'iact_3_data_count.txt', mode) 
			
			mode = 'a'
		'''
    
    
	fc1_out_split = []
	fc1_out = [] 
	fc1_weight_rows = 16
	fc1_weight_batch = 4
	for i in range(flattened.shape[0]//fc1_weight_rows):
		fc1_out_split = []
		for j in range(fc1_weight.shape[0]//fc1_weight_batch):
			result = matrix_multiply(modify_matrix((fc1_weight[0+fc1_weight_batch*j:fc1_weight_batch+fc1_weight_batch*j, 0+i*fc1_weight_rows:fc1_weight_rows+i*fc1_weight_rows]))[0], np.transpose(flattened[0+i*fc1_weight_rows:fc1_weight_rows+i*fc1_weight_rows]))
			
			fc1_out_split = np.concatenate([fc1_out_split, result])
			
		fc1_out.append(fc1_out_split)
		
	fc1_out = np.array(fc1_out).sum(axis=0).reshape(1, 120)
	
	# save_array_to_21bit_binary_txt(fc1_out, 'layer_3_out.txt', 'w')
    
	# fc1_out = matrix_multiply(fc1_weight, flattened)
	
	relu3_out = relu(fc1_out)
	
	relu3_out = relu3_out // quan_scale
	
	relu3_out = stack_and_transpose(relu3_out)
	
    
    
	
	# layer 4
	iact_4_addr_list = []
	iact_4_data_count_list = []
	ifmap_batches = 20
	for i in range(120//ifmap_batches):
		single_col = relu3_out.reshape(-1, 1)[i*ifmap_batches:(i+1)*ifmap_batches]
		iact_4_addr, iact_4_count, iact_4_data = csc_compression_single_col(single_col)
		iact_4_data_count = combineDataAndCount(iact_4_data, iact_4_count, cscDataWidth=8, cscCountWidth=5)
		
		iact_4_addr_list.append(iact_4_addr)
		iact_4_data_count_list.append(iact_4_data_count)
		'''
		if i == 0:
			mode = 'w'
		else:
			mode = 'a'
			
		for j in range(21):
			save_dec_as_hex_to_txt(iact_4_addr, 'iact_4_addr.txt', mode)
			save_data_to_txt(iact_4_data_count, 'iact_4_data_count.txt', mode) 
			
			mode = 'a'
		'''
    
	fc2_out_split = []
	fc2_out = [] 
	fc2_weight_rows = 20
	fc2_weight_batch = 4
	for i in range(relu3_out.shape[0]//fc2_weight_rows):
		fc2_out_split = []
		for j in range(fc2_weight.shape[0]//fc2_weight_batch):
			result = matrix_multiply(modify_matrix(fc2_weight[0+fc2_weight_batch*j:fc2_weight_batch+fc2_weight_batch*j, 0+i*fc2_weight_rows:fc2_weight_rows+i*fc2_weight_rows])[0], (relu3_out[0+i*fc2_weight_rows:fc2_weight_rows+i*fc2_weight_rows]))
            
			fc2_out_split = np.concatenate([fc2_out_split, result.squeeze()])
			
		fc2_out.append(fc2_out_split)
		
	fc2_out = np.array(fc2_out).sum(axis=0).reshape(1, 84)
	
	# save_array_to_21bit_binary_txt(fc2_out, 'layer_4_out.txt', 'w')
	
	# fc2_out = matrix_multiply(fc2_weight, relu3_out)
	relu4_out = relu(fc2_out)
	relu4_out = relu4_out // quan_scale
	relu4_out = stack_and_transpose(relu4_out)
    
	# check_groups_for_zeros(relu4_out)
	
	# layer 5
	iact_5_addr_list = []
	iact_5_data_count_list = []
	ifmap_batches = 21
	for i in range(84//ifmap_batches):
		single_col = relu4_out.reshape(-1, 1)[i*ifmap_batches:(i+1)*ifmap_batches]
		iact_5_addr, iact_5_count, iact_5_data = csc_compression_single_col(single_col)
		iact_5_data_count = combineDataAndCount(iact_5_data, iact_5_count, cscDataWidth=8, cscCountWidth=5)
		
		iact_5_addr_list.append(iact_5_addr)
		iact_5_data_count_list.append(iact_5_data_count)
		'''
		if i == 0:
			mode = 'w'
		else:
			mode = 'a'
			
		for j in range(3):
			save_dec_as_hex_to_txt(iact_5_addr, 'iact_5_addr.txt', mode)
			save_data_to_txt(iact_5_data_count, 'iact_5_data_count.txt', mode) 
			
			mode = 'a'
		'''
    
	fc3_out_split = []
	fc3_out = [] 
	fc3_weight_rows = 21
	fc3_weight_batch = 5
	for i in range(relu4_out.shape[0]//fc3_weight_rows):
		fc3_out_split = []
		for j in range(fc3_weight.shape[0]//fc3_weight_batch):
			result = matrix_multiply(modify_matrix(fc3_weight[0+fc3_weight_batch*j:fc3_weight_batch+fc3_weight_batch*j, 0+i*fc3_weight_rows:fc3_weight_rows+i*fc3_weight_rows])[0], (relu4_out[0+i*fc3_weight_rows:fc3_weight_rows+i*fc3_weight_rows]))
            
			fc3_out_split = np.concatenate([fc3_out_split, result.squeeze()])
			
		fc3_out.append(fc3_out_split)
		
	fc3_out = np.array(fc3_out).sum(axis=0).reshape(1, 10)

	# save_array_to_21bit_binary_txt(fc3_out, 'layer_5_out.txt', 'w')
	
	# fc3_out = matrix_multiply(fc3_weight, relu4_out)
    
	
	return fc3_out


def merge_txt_files(input_filenames, repetitions, output_filename):
    with open(output_filename, 'w') as output_file:
        for filename, repeat in zip(input_filenames, repetitions):
            for _ in range(repeat):
                with open(filename, 'r') as input_file:
                    for line in input_file:
                        output_file.write(line)


'''
input_path = '5.png'
output_path = 'layer1/5.txt'
image_image_as_txt(input_path, output_path)
'''

conv1_weight_path = 'layer2/kernel1.txt' 
conv2_weight_path = 'layer2/kernel2.txt' 
fc1_weight_path   = 'layer2/kernel3.txt' 
fc2_weight_path   = 'layer2/kernel4.txt' 
fc3_weight_path   = 'layer2/kernel5.txt' 

ifmap_path = 'layer1/5.txt' 

conv1_weight = read_matrices_from_file(conv1_weight_path, 5, 1)
conv2_weight = read_matrices_from_file(conv2_weight_path, 5, 6)

fc1_weight = read_and_group_data(fc1_weight_path, 256, 120)
fc2_weight = read_and_group_data(fc2_weight_path, 120, 84)
fc3_weight = read_and_group_data(fc3_weight_path, 84, 10)

# purning
conv_threshold = 0.9
fc_threshold = 0.9

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


def save_array_as_hex(array, file_path):
    with open(file_path, 'w') as file:
        for row in array:
            for elem in row:
                for val in elem:
                    hex_val = format(val, '02x')
                    file.write(hex_val + '\n')  



 
# Implementation with GEMM
conv1_weight_0 = flatten_2d_array(conv1_weight[0])
conv1_weight_1 = flatten_2d_array(conv1_weight[1])
conv1_weight_2 = flatten_2d_array(conv1_weight[2])
conv1_weight_3 = flatten_2d_array(conv1_weight[3])
conv1_weight_4 = flatten_2d_array(conv1_weight[4])
conv1_weight_5 = flatten_2d_array(conv1_weight[5])

conv2_weight_0 = flatten_2d_array(conv2_weight[0])
conv2_weight_1 = flatten_2d_array(conv2_weight[1])
conv2_weight_2 = flatten_2d_array(conv2_weight[2])
conv2_weight_3 = flatten_2d_array(conv2_weight[3])

conv2_weight_4 = flatten_2d_array(conv2_weight[4])
conv2_weight_5 = flatten_2d_array(conv2_weight[5])
conv2_weight_6 = flatten_2d_array(conv2_weight[6])
conv2_weight_7 = flatten_2d_array(conv2_weight[7])

conv2_weight_8 = flatten_2d_array(conv2_weight[8])
conv2_weight_9 = flatten_2d_array(conv2_weight[9])
conv2_weight_10 = flatten_2d_array(conv2_weight[10])
conv2_weight_11 = flatten_2d_array(conv2_weight[11])

conv2_weight_12 = flatten_2d_array(conv2_weight[12])
conv2_weight_13 = flatten_2d_array(conv2_weight[13])
conv2_weight_14 = flatten_2d_array(conv2_weight[14])
conv2_weight_15 = flatten_2d_array(conv2_weight[15])


conv1_weight_merge = stack_and_transpose([conv1_weight_0, conv1_weight_1, conv1_weight_2, conv1_weight_3, conv1_weight_4, conv1_weight_5])
conv1_weight_merge, conv1_weight_merge_mask = modify_matrix(conv1_weight_merge)

weight_0_addr, weight_0_count, weight_0_data = genAdrCountData(conv1_weight_merge, True, conv1_weight_merge_mask)
weight_0_data_count = combineDataAndCount(weight_0_data, weight_0_count, cscDataWidth=8, cscCountWidth=5)

save_dec_as_hex_to_txt(weight_0_addr, 'weight_0_addr.txt', 'w')
save_data_to_txt(binary_str_to_12bit_hex(weight_0_data_count), 'weight_0_data_count.txt', 'w')


conv2_weight_merge_c0 = stack_and_transpose([conv2_weight_0[0:25], conv2_weight_1[0:25], conv2_weight_2[0:25], 
                                             conv2_weight_3[0:25], conv2_weight_4[0:25], conv2_weight_5[0:25],
                                             conv2_weight_6[0:25], conv2_weight_7[0:25], conv2_weight_8[0:25],
                                             conv2_weight_9[0:25], conv2_weight_10[0:25], conv2_weight_11[0:25],
                                             conv2_weight_12[0:25], conv2_weight_13[0:25], conv2_weight_14[0:25],
                                             conv2_weight_15[0:25]])

conv2_weight_merge_c1 = stack_and_transpose([conv2_weight_0[25:50], conv2_weight_1[25:50], conv2_weight_2[25:50], 
                                             conv2_weight_3[25:50], conv2_weight_4[25:50], conv2_weight_5[25:50],
                                             conv2_weight_6[25:50], conv2_weight_7[25:50], conv2_weight_8[25:50],
                                             conv2_weight_9[25:50], conv2_weight_10[25:50], conv2_weight_11[25:50],
                                             conv2_weight_12[25:50], conv2_weight_13[25:50], conv2_weight_14[25:50],
                                             conv2_weight_15[25:50]])

conv2_weight_merge_c2 = stack_and_transpose([conv2_weight_0[50:75], conv2_weight_1[50:75], conv2_weight_2[50:75], 
                                             conv2_weight_3[50:75], conv2_weight_4[50:75], conv2_weight_5[50:75],
                                             conv2_weight_6[50:75], conv2_weight_7[50:75], conv2_weight_8[50:75],
                                             conv2_weight_9[50:75], conv2_weight_10[50:75], conv2_weight_11[50:75],
                                             conv2_weight_12[50:75], conv2_weight_13[50:75], conv2_weight_14[50:75],
                                             conv2_weight_15[50:75]])

conv2_weight_merge_c3 = stack_and_transpose([conv2_weight_0[75:100], conv2_weight_1[75:100], conv2_weight_2[75:100], 
                                             conv2_weight_3[75:100], conv2_weight_4[75:100], conv2_weight_5[75:100],
                                             conv2_weight_6[75:100], conv2_weight_7[75:100], conv2_weight_8[75:100],
                                             conv2_weight_9[75:100], conv2_weight_10[75:100], conv2_weight_11[75:100],
                                             conv2_weight_12[75:100], conv2_weight_13[75:100], conv2_weight_14[75:100],
                                             conv2_weight_15[75:100]])

conv2_weight_merge_c4 = stack_and_transpose([conv2_weight_0[100:125], conv2_weight_1[100:125], conv2_weight_2[100:125], 
                                             conv2_weight_3[100:125], conv2_weight_4[100:125], conv2_weight_5[100:125],
                                             conv2_weight_6[100:125], conv2_weight_7[100:125], conv2_weight_8[100:125],
                                             conv2_weight_9[100:125], conv2_weight_10[100:125], conv2_weight_11[100:125],
                                             conv2_weight_12[100:125], conv2_weight_13[100:125], conv2_weight_14[100:125],
                                             conv2_weight_15[100:125]])

conv2_weight_merge_c5 = stack_and_transpose([conv2_weight_0[125:150], conv2_weight_1[125:150], conv2_weight_2[125:150], 
                                             conv2_weight_3[125:150], conv2_weight_4[125:150], conv2_weight_5[125:150],
                                             conv2_weight_6[125:150], conv2_weight_7[125:150], conv2_weight_8[125:150],
                                             conv2_weight_9[125:150], conv2_weight_10[125:150], conv2_weight_11[125:150],
                                             conv2_weight_12[125:150], conv2_weight_13[125:150], conv2_weight_14[125:150],
                                             conv2_weight_15[125:150]])


conv2_weight_merge_c0_former, conv2_weight_merge_c0_former_mask = modify_matrix(conv2_weight_merge_c0[:, 0:8])
conv2_weight_merge_c1_former, conv2_weight_merge_c1_former_mask = modify_matrix(conv2_weight_merge_c1[:, 0:8])
conv2_weight_merge_c2_former, conv2_weight_merge_c2_former_mask = modify_matrix(conv2_weight_merge_c2[:, 0:8])
conv2_weight_merge_c3_former, conv2_weight_merge_c3_former_mask = modify_matrix(conv2_weight_merge_c3[:, 0:8])
conv2_weight_merge_c4_former, conv2_weight_merge_c4_former_mask = modify_matrix(conv2_weight_merge_c4[:, 0:8])
conv2_weight_merge_c5_former, conv2_weight_merge_c5_former_mask = modify_matrix(conv2_weight_merge_c5[:, 0:8])

conv2_weight_merge_c0_later, conv2_weight_merge_c0_later_mask   = modify_matrix(conv2_weight_merge_c0[:, 8:16])
conv2_weight_merge_c1_later, conv2_weight_merge_c1_later_mask   = modify_matrix(conv2_weight_merge_c1[:, 8:16])
conv2_weight_merge_c2_later, conv2_weight_merge_c2_later_mask   = modify_matrix(conv2_weight_merge_c2[:, 8:16])
conv2_weight_merge_c3_later, conv2_weight_merge_c3_later_mask   = modify_matrix(conv2_weight_merge_c3[:, 8:16])
conv2_weight_merge_c4_later, conv2_weight_merge_c4_later_mask   = modify_matrix(conv2_weight_merge_c4[:, 8:16])
conv2_weight_merge_c5_later, conv2_weight_merge_c5_later_mask   = modify_matrix(conv2_weight_merge_c5[:, 8:16])


weight_2_c0_former_addr, weight_2_c0_former_count, weight_2_c0_former_data = genAdrCountData(conv2_weight_merge_c0_former, True, conv2_weight_merge_c0_former_mask)
weight_2_c1_former_addr, weight_2_c1_former_count, weight_2_c1_former_data = genAdrCountData(conv2_weight_merge_c1_former, True, conv2_weight_merge_c1_former_mask)
weight_2_c2_former_addr, weight_2_c2_former_count, weight_2_c2_former_data = genAdrCountData(conv2_weight_merge_c2_former, True, conv2_weight_merge_c2_former_mask)
weight_2_c3_former_addr, weight_2_c3_former_count, weight_2_c3_former_data = genAdrCountData(conv2_weight_merge_c3_former, True, conv2_weight_merge_c3_former_mask)
weight_2_c4_former_addr, weight_2_c4_former_count, weight_2_c4_former_data = genAdrCountData(conv2_weight_merge_c4_former, True, conv2_weight_merge_c4_former_mask)
weight_2_c5_former_addr, weight_2_c5_former_count, weight_2_c5_former_data = genAdrCountData(conv2_weight_merge_c5_former, True, conv2_weight_merge_c5_former_mask)

weight_2_c0_later_addr, weight_2_c0_later_count, weight_2_c0_later_data = genAdrCountData(conv2_weight_merge_c0_later, True, conv2_weight_merge_c0_later_mask)
weight_2_c1_later_addr, weight_2_c1_later_count, weight_2_c1_later_data = genAdrCountData(conv2_weight_merge_c1_later, True, conv2_weight_merge_c1_later_mask)
weight_2_c2_later_addr, weight_2_c2_later_count, weight_2_c2_later_data = genAdrCountData(conv2_weight_merge_c2_later, True, conv2_weight_merge_c2_later_mask)
weight_2_c3_later_addr, weight_2_c3_later_count, weight_2_c3_later_data = genAdrCountData(conv2_weight_merge_c3_later, True, conv2_weight_merge_c3_later_mask)
weight_2_c4_later_addr, weight_2_c4_later_count, weight_2_c4_later_data = genAdrCountData(conv2_weight_merge_c4_later, True, conv2_weight_merge_c4_later_mask)
weight_2_c5_later_addr, weight_2_c5_later_count, weight_2_c5_later_data = genAdrCountData(conv2_weight_merge_c5_later, True, conv2_weight_merge_c5_later_mask)


weight_2_c0_former_data_count = combineDataAndCount([int(item) for item in weight_2_c0_former_data], weight_2_c0_former_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c1_former_data_count = combineDataAndCount([int(item) for item in weight_2_c1_former_data], weight_2_c1_former_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c2_former_data_count = combineDataAndCount([int(item) for item in weight_2_c2_former_data], weight_2_c2_former_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c3_former_data_count = combineDataAndCount([int(item) for item in weight_2_c3_former_data], weight_2_c3_former_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c4_former_data_count = combineDataAndCount([int(item) for item in weight_2_c4_former_data], weight_2_c4_former_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c5_former_data_count = combineDataAndCount([int(item) for item in weight_2_c5_former_data], weight_2_c5_former_count, cscDataWidth=8, cscCountWidth=5)

weight_2_c0_later_data_count = combineDataAndCount([int(item) for item in weight_2_c0_later_data], weight_2_c0_later_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c1_later_data_count = combineDataAndCount([int(item) for item in weight_2_c1_later_data], weight_2_c1_later_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c2_later_data_count = combineDataAndCount([int(item) for item in weight_2_c2_later_data], weight_2_c2_later_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c3_later_data_count = combineDataAndCount([int(item) for item in weight_2_c3_later_data], weight_2_c3_later_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c4_later_data_count = combineDataAndCount([int(item) for item in weight_2_c4_later_data], weight_2_c4_later_count, cscDataWidth=8, cscCountWidth=5)
weight_2_c5_later_data_count = combineDataAndCount([int(item) for item in weight_2_c5_later_data], weight_2_c5_later_count, cscDataWidth=8, cscCountWidth=5)


save_dec_as_hex_to_txt(weight_2_c0_former_addr, 'weight_2_c0_former_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c1_former_addr, 'weight_2_c1_former_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c2_former_addr, 'weight_2_c2_former_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c3_former_addr, 'weight_2_c3_former_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c4_former_addr, 'weight_2_c4_former_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c5_former_addr, 'weight_2_c5_former_addr.txt', 'w')

save_dec_as_hex_to_txt(weight_2_c0_later_addr, 'weight_2_c0_later_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c1_later_addr, 'weight_2_c1_later_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c2_later_addr, 'weight_2_c2_later_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c3_later_addr, 'weight_2_c3_later_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c4_later_addr, 'weight_2_c4_later_addr.txt', 'w')
save_dec_as_hex_to_txt(weight_2_c5_later_addr, 'weight_2_c5_later_addr.txt', 'w')

save_data_to_txt(weight_2_c0_former_data_count, 'weight_2_c0_former_data_count.txt', 'w')
save_data_to_txt(weight_2_c1_former_data_count, 'weight_2_c1_former_data_count.txt', 'w')
save_data_to_txt(weight_2_c2_former_data_count, 'weight_2_c2_former_data_count.txt', 'w')
save_data_to_txt(weight_2_c3_former_data_count, 'weight_2_c3_former_data_count.txt', 'w')
save_data_to_txt(weight_2_c4_former_data_count, 'weight_2_c4_former_data_count.txt', 'w')
save_data_to_txt(weight_2_c5_former_data_count, 'weight_2_c5_former_data_count.txt', 'w')

save_data_to_txt(weight_2_c0_later_data_count, 'weight_2_c0_later_data_count.txt', 'w')
save_data_to_txt(weight_2_c1_later_data_count, 'weight_2_c1_later_data_count.txt', 'w')
save_data_to_txt(weight_2_c2_later_data_count, 'weight_2_c2_later_data_count.txt', 'w')
save_data_to_txt(weight_2_c3_later_data_count, 'weight_2_c3_later_data_count.txt', 'w')
save_data_to_txt(weight_2_c4_later_data_count, 'weight_2_c4_later_data_count.txt', 'w')
save_data_to_txt(weight_2_c5_later_data_count, 'weight_2_c5_later_data_count.txt', 'w')



save_data_to_txt(binary_str_to_16bit_hex(weight_2_c0_former_data_count), 'weight_2_c0_former_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c1_former_data_count), 'weight_2_c1_former_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c2_former_data_count), 'weight_2_c2_former_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c3_former_data_count), 'weight_2_c3_former_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c4_former_data_count), 'weight_2_c4_former_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c5_former_data_count), 'weight_2_c5_former_data_count.txt', 'w')

save_data_to_txt(binary_str_to_16bit_hex(weight_2_c0_later_data_count), 'weight_2_c0_later_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c1_later_data_count), 'weight_2_c1_later_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c2_later_data_count), 'weight_2_c2_later_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c3_later_data_count), 'weight_2_c3_later_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c4_later_data_count), 'weight_2_c4_later_data_count.txt', 'w')
save_data_to_txt(binary_str_to_16bit_hex(weight_2_c5_later_data_count), 'weight_2_c5_later_data_count.txt', 'w')




# merge_txt_files(['iact_2_c0_addr.txt', 'iact_2_c1_addr.txt', 'iact_2_c2_addr.txt', 'iact_2_c3_addr.txt', 'iact_2_c4_addr.txt', 'iact_2_c5_addr.txt'], [2,2,2,2,2,2,], 'iact_2_addr.txt')
# merge_txt_files(['iact_2_c0_data_count.txt', 'iact_2_c1_data_count.txt', 'iact_2_c2_data_count.txt', 'iact_2_c3_data_count.txt', 'iact_2_c4_data_count.txt', 'iact_2_c5_data_count.txt'], [2,2,2,2,2,2,], 'iact_2_data_count.txt')


merge_txt_files(['weight_2_c0_former_addr.txt', 
                 'weight_2_c1_former_addr.txt', 
                 'weight_2_c2_former_addr.txt', 
                 'weight_2_c3_former_addr.txt', 
                 'weight_2_c4_former_addr.txt', 
                 'weight_2_c5_former_addr.txt'], [1,1,1,1,1,1], 'weight_2_addr_former.txt')


merge_txt_files(['weight_2_c0_later_addr.txt', 
                 'weight_2_c1_later_addr.txt', 
                 'weight_2_c2_later_addr.txt', 
                 'weight_2_c3_later_addr.txt', 
                 'weight_2_c4_later_addr.txt', 
                 'weight_2_c5_later_addr.txt'], [1,1,1,1,1,1], 'weight_2_addr_later.txt')

merge_txt_files(['weight_2_c0_former_data_count.txt', 
                 'weight_2_c1_former_data_count.txt', 
                 'weight_2_c2_former_data_count.txt', 
                 'weight_2_c3_former_data_count.txt', 
                 'weight_2_c4_former_data_count.txt', 
                 'weight_2_c5_former_data_count.txt'], [1,1,1,1,1,1], 'weight_2_data_count_former.txt')

merge_txt_files(['weight_2_c0_later_data_count.txt', 
                 'weight_2_c1_later_data_count.txt', 
                 'weight_2_c2_later_data_count.txt', 
                 'weight_2_c3_later_data_count.txt', 
                 'weight_2_c4_later_data_count.txt', 
                 'weight_2_c5_later_data_count.txt'], [1,1,1,1,1,1], 'weight_2_data_count_later.txt')


weight_3_addr_list = []
weight_3_data_count_list = []
mode = 'w'
for i in range(16):
	for j in range(30):
		fc1_weight_matrix_temp = fc1_weight[0+4*j:4+4*j, i*16:16+i*16]
		fc1_modify_matrix, fc1_modify_matrix_mask = modify_matrix(fc1_weight_matrix_temp)
		weight_3_addr, weight_3_count, weight_3_data = genAdrCountData(fc1_modify_matrix, False, fc1_modify_matrix_mask)
		weight_3_data_count = combineDataAndCount(weight_3_data, weight_3_count, cscDataWidth=8, cscCountWidth=4)
	
		weight_3_addr_list.append(weight_3_addr)
		weight_3_data_count_list.append(weight_3_data_count)
		
		
		save_dec_as_hex_to_txt(weight_3_addr, 'weight_3_addr.txt', mode)
		save_data_to_txt(binary_str_to_12bit_hex(weight_3_data_count), 'weight_3_data_count.txt', mode) 
        
		mode = 'a'
           


weight_4_addr_list = []
weight_4_data_count_list = []
mode = 'w'
for i in range(6):
	for j in range(21):
		fc2_weight_matrix_temp = fc2_weight[0+4*j:4+4*j, i*20:20+i*20]
		fc2_modify_matrix, fc2_modify_matrix_mask = modify_matrix(fc2_weight_matrix_temp)
		weight_4_addr, weight_4_count, weight_4_data = genAdrCountData(fc2_modify_matrix, False, fc2_modify_matrix_mask)
		weight_4_data_count = combineDataAndCount(weight_4_data, weight_4_count, cscDataWidth=8, cscCountWidth=4)
	
		weight_4_addr_list.append(weight_4_addr)
		weight_4_data_count_list.append(weight_4_data_count)
		
		if fc2_modify_matrix.any() != fc2_weight_matrix_temp.any():
			print('7')
        
		save_dec_as_hex_to_txt(weight_4_addr, 'weight_4_addr.txt', mode)
		save_data_to_txt(binary_str_to_12bit_hex(weight_4_data_count), 'weight_4_data_count.txt', mode) 
        
		mode = 'a'



weight_5_addr_list = []
weight_5_data_count_list = []
mode = 'w'
for i in range(4):
	for j in range(3):
        
		if j != 2:
			fc3_weight_matrix_temp = fc3_weight[0+4*j:4+4*j, i*21:21+i*21]
		else:
			fc3_weight_matrix_temp = fc3_weight[8:10, i*21:21+i*21]

		fc3_modify_matrix, fc3_modify_matrix_mask = modify_matrix(fc3_weight_matrix_temp)
		weight_5_addr, weight_5_count, weight_5_data = genAdrCountData(fc3_modify_matrix, False, fc3_modify_matrix_mask)
		weight_5_data_count = combineDataAndCount(weight_5_data, weight_5_count, cscDataWidth=8, cscCountWidth=4)
	
		weight_5_addr_list.append(weight_5_addr)
		weight_5_data_count_list.append(weight_5_data_count)
		
		save_dec_as_hex_to_txt(weight_5_addr, 'weight_5_addr.txt', mode)
		save_data_to_txt(binary_str_to_12bit_hex(weight_5_data_count), 'weight_5_data_count.txt', mode) 
        
		mode = 'a'

def output_file_lengths(file_names, output_file):
    total_length = 0
    with open(output_file, 'w') as out_file:
        for file_name in file_names:
            with open(file_name, 'r') as in_file:
                length = sum(1 for _ in in_file)
                total_length += length
                out_file.write(f'{total_length}\n')

'''
file_names = ['weight_0_addr.txt', 
				'weight_0_data_count.txt', 
				'weight_2_addr_former.txt', 
				'weight_2_data_count_former.txt', 
				'weight_2_addr_later.txt', 
				'weight_2_data_count_later.txt',
				'weight_3_addr.txt',
				'weight_3_data_count.txt',
				'weight_4_addr.txt',
				'weight_4_data_count.txt',
				'weight_5_addr.txt',
				'weight_5_data_count.txt']
              
output_file_lengths(file_names,  'output_lengths.txt')
merge_txt_files(file_names, [1,1,1,1,1,1,1,1,1,1,1,1], 'ROM_sparse.txt')
'''


ifmap = read_matrices_from_file(ifmap_path, 28, 1)
ifmap = np.squeeze(ifmap)
ifmap = ifmap // 2

ifmap_matrix = im2col(ifmap, 5)

output = LeNet_with_GEMM(ifmap_matrix)
prediction = softmax(LeNet_with_GEMM(ifmap_matrix))
print(prediction)


# MNIST Test
def evaluate_mnist(batch_size=1):
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
            ifmap = np.squeeze(ifmap)
            ifmap_matrix = im2col(ifmap, 5)
            
            predicted = softmax(LeNet_with_GEMM(ifmap_matrix))
            correct += (predicted == labels[i].item())
            
        total += len(images)
        
        print(f" {correct}   /   {total}")
        
        if total == 1000:
            break
        
    accuracy = correct / total *100
    return accuracy

'''
accuracy = evaluate_mnist(10)
print(f'Accuracy on MNIST test set: {accuracy:.4f}%')
'''


# get test image txt file
import torchvision

def get_mnist_image_and_label(index):
    transform = transforms.Compose([
        transforms.ToTensor()
    ])

    train_set = torchvision.datasets.MNIST(root='./data', train=True, download=True, transform=transform)

    image, label = train_set[index]
    image = (image * 255 // 2).type(torch.uint8).numpy().squeeze()

    return image, label

def save_mnist_data_as_hex(start_index, end_index, file_path_data, file_path_labels):
    mode_data = 'w' 
    mode_labels = 'w'  

    for index in range(start_index, end_index):
        image, label = get_mnist_image_and_label(index)

        with open(file_path_data, mode_data) as file_data:
            for row in image:
                for val in row:
                    hex_val = format(val, '02x')
                    file_data.write(hex_val + '\n')

        with open(file_path_labels, mode_labels) as file_labels:
            hex_label = format(label, '01x') 
            file_labels.write(hex_label + '\n')

        mode_data = 'a'
        mode_labels = 'a'

# save_mnist_data_as_hex(0, 1000, 'DRAM.txt', 'GOLDEN.txt')


def txt_to_coe(input_file_path, output_file_path):
    with open(input_file_path, 'r') as file:
        lines = file.readlines()

    with open(output_file_path, 'w') as file:
        file.write("memory_initialization_radix=16;\n")
        file.write("memory_initialization_vector=\n")

        for i, line in enumerate(lines):
            hex_val = line.strip().zfill(4)
            if i == len(lines) - 1:
                file.write(hex_val + ';\n')
            else:
                file.write(hex_val + ',\n')


# txt_to_coe('ROM_sparse.txt', 'ROM_sparse_COE.coe')
save_array_as_8bit_hex_to_txt(ifmap, 'ifmap.txt')
txt_to_coe('ifmap.txt', 'ifmap.coe')




class App(tk.Tk):
    def __init__(self):
        super().__init__()
        self.canvas = tk.Canvas(self, width=280, height=280, bg='black')
        self.canvas.pack(padx=10, pady=10)

        # build PIL view, background = black
        self.image = Image.new('L', (280, 280), 'black')
        self.draw = ImageDraw.Draw(self.image)

        # brush color = white
        self.brush_size = 10
        self.brush_color = 'white'
        self.setup()

        # add prediction button
        self.predict_button = Button(self, text='Predict', command=self.predict)
        self.predict_button.pack(side=tk.LEFT, padx=10, pady=10)

        # add clear button
        self.clear_button = Button(self, text='Clear', command=self.clear_canvas)
        self.clear_button.pack(side=tk.RIGHT, padx=10, pady=10)
        
        # add save image button
        self.save_button = Button(self, text='Save Image', command=self.save_image)
        self.save_button.pack(side=tk.RIGHT, padx=10, pady=10)
    
        
        # Dropdown menu for COM port selection
        self.com_ports = self.scan_com_ports()
        self.com_var = tk.StringVar(self)
        self.com_dropdown = ttk.Combobox(self, textvariable=self.com_var, values=self.com_ports, state='readonly')
        self.com_dropdown.pack(side=tk.LEFT, padx=10, pady=10)

        # Button to connect to selected COM port
        self.connect_button = Button(self, text='Connect', command=self.connect_to_com_port)
        self.connect_button.pack(side=tk.LEFT, padx=10, pady=10)
        
        

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
        img = self.image.resize((28, 28), Image.ANTIALIAS)
        img = ImageOps.invert(img)  
        img = img.convert("L")

        img_np = np.array(img, dtype=np.uint8)
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
        img_np = self.preprocess()
        
        print(img_np)

        start_time = time.time()

        ifmap_matrix = im2col(img_np, 5)
        prediction = softmax(LeNet_with_GEMM(ifmap_matrix))

        end_time = time.time()
        inference_time = end_time - start_time
        print(f'Inference time: {inference_time:.4f} seconds')

        print(f'Predicted digit: {prediction}\n')
    
    
    
    def scan_com_ports(self):
        # List available COM ports
        ports = serial.tools.list_ports.comports()
        return [port.device for port in ports]

    def connect_to_com_port(self):
        selected_port = self.com_var.get()
        if selected_port:
            try:
                self.serial_port = serial.Serial(selected_port, 9600, timeout=1)
                self.serial_port.flush()
                print(f"Connected to {selected_port}")
            except serial.SerialException as e:
                print(f"Failed to connect to {selected_port}: {e}")
                
    
    def send_to_fpga(self, img_data):
        # Convert the image data to a format suitable for UART transmission
        serialized_data = img_data.tobytes()
        self.serial_port.write(serialized_data)

        # Wait for FPGA to process and respond 
        if self.serial_port.in_waiting > 0:
            response = self.serial_port.readline().decode('utf-8').rstrip()
            print("Response from FPGA: ", response)
    


app = App()
app.mainloop()


