import numpy as np
from PIL import Image
import torch
import torchvision.transforms as transforms
from torchvision.datasets import MNIST

def elementwise_addition(list1, list2, list3):
    return [a + b + c for a, b, c in zip(list1, list2, list3)]


def genAdrCountData(listA, inActOrWeight):
    if inActOrWeight:
        zeroCode = 255
        max_val = 255
    else:
        zeroCode = 127
        max_val = 127

    adrList = []
    countList = []
    dataList = []

    for j in range(len(listA[0])):  # for each column
        currentCol = [row[j] for row in listA]
        if max(map(abs, currentCol)) == 0:
            adrList.append(zeroCode)
        else:
            if j != 0:
                adrList.append(len(dataList))
            for i, value in enumerate(currentCol):
                if value != 0:
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
    last_col_all_zero = False

    for j in [0, 1]:
        if j < cols and np.all(matrix[:, j] == 0):
            matrix[-1, j] = 1
            last_col_all_zero = True
        else:
            last_col_all_zero = False

    for j in range(2, cols - 1):
        if np.all(matrix[:, j] == 0):
            if last_col_all_zero:
                matrix[-1, j] = 1
            last_col_all_zero = True
        else:
            last_col_all_zero = False

    if np.all(matrix[:, -1] == 0):
        matrix[-1, -1] = 1

    return matrix


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


def LeNet_with_GEMM(ifmap_matrix):
	
	layer_1_out_split = []
	for i in range(ifmap_matrix.shape[0] // 4 ):
		# noise
		ifamp_splited = modify_matrix(ifmap_matrix[4 * i: 4 * i + 4])
		
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
	pool1_out = pool1_out // 4096
	
	
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
		ifamp_splited_0 = modify_matrix(layer_1_out_matrix_0_c0[4 * i: 4 * i + 4])
		ifamp_splited_1 = modify_matrix(layer_1_out_matrix_0_c1[4 * i: 4 * i + 4])
		ifamp_splited_2 = modify_matrix(layer_1_out_matrix_0_c2[4 * i: 4 * i + 4])
		ifamp_splited_3 = modify_matrix(layer_1_out_matrix_0_c3[4 * i: 4 * i + 4])
		ifamp_splited_4 = modify_matrix(layer_1_out_matrix_0_c4[4 * i: 4 * i + 4])
		ifamp_splited_5 = modify_matrix(layer_1_out_matrix_0_c5[4 * i: 4 * i + 4])
		
		iact_2_c0_addr, iact_2_c0_count, iact_2_c0_data = genAdrCountData(ifamp_splited_0, True)
		iact_2_c1_addr, iact_2_c1_count, iact_2_c1_data = genAdrCountData(ifamp_splited_1, True)
		iact_2_c2_addr, iact_2_c2_count, iact_2_c2_data = genAdrCountData(ifamp_splited_2, True)
		iact_2_c3_addr, iact_2_c3_count, iact_2_c3_data = genAdrCountData(ifamp_splited_3, True)
		iact_2_c4_addr, iact_2_c4_count, iact_2_c4_data = genAdrCountData(ifamp_splited_4, True)
		iact_2_c5_addr, iact_2_c5_count, iact_2_c5_data = genAdrCountData(ifamp_splited_5, True)
		
		iact_0_data_count = combineDataAndCount([int(item) for item in iact_2_c0_data], iact_2_c0_count, cscDataWidth=8, cscCountWidth=4)
		iact_1_data_count = combineDataAndCount([int(item) for item in iact_2_c1_data], iact_2_c1_count, cscDataWidth=8, cscCountWidth=4)
		iact_2_data_count = combineDataAndCount([int(item) for item in iact_2_c2_data], iact_2_c2_count, cscDataWidth=8, cscCountWidth=4)
		iact_3_data_count = combineDataAndCount([int(item) for item in iact_2_c3_data], iact_2_c3_count, cscDataWidth=8, cscCountWidth=4)
		iact_4_data_count = combineDataAndCount([int(item) for item in iact_2_c4_data], iact_2_c4_count, cscDataWidth=8, cscCountWidth=4)
		iact_5_data_count = combineDataAndCount([int(item) for item in iact_2_c5_data], iact_2_c5_count, cscDataWidth=8, cscCountWidth=4)
		
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
	
	save_array_to_21bit_binary_txt(layer_2_out, 'layer_2_out.txt')
    
	layer_2_out = np.array(reshape_to_squares(layer_2_out, 8))
	
	relu2_out = []
	pool2_out = []
	for i in range(layer_2_out.shape[0]):
		relu2_out.append(relu(layer_2_out[i]))
		pool2_out.append(max_pool2d(relu2_out[i], kernel_size=2, stride=2))
			
	pool2_out = np.array(pool2_out)
	pool2_out = pool2_out // 4096
	
	
	flattened = pool2_out.flatten()
		
	# layer 3
	iact_3_addr_list = []
	iact_3_data_count_list = []
	
	for i in range(16):
		single_col = flattened[i*16:(i+1)*16].reshape(-1, 1)
		iact_3_addr, iact_3_count, iact_3_data = csc_compression_single_col(single_col)
		iact_3_data_count = combineDataAndCount(iact_3_data, iact_3_count, cscDataWidth=8, cscCountWidth=5)
		
		iact_3_addr_list.append(iact_3_addr)
		iact_3_data_count_list.append(iact_3_data_count)
        
		if i == 0:
			mode = 'w'
		else:
			mode = 'a'
			
		for j in range(30):
			save_dec_as_hex_to_txt(iact_3_addr, 'iact_3_addr.txt', mode)
			save_data_to_txt(iact_3_data_count, 'iact_3_data_count.txt', mode) 
			
			mode = 'a'
		
    
	fc1_out_split = []
	fc1_out = [] 
	fc1_weight_rows = 16
	fc1_weight_batch = 4
	for i in range(flattened.shape[0]//fc1_weight_rows):
		fc1_out_split = []
		for j in range(fc1_weight.shape[0]//fc1_weight_batch):
			result = matrix_multiply(flattened[0+i*fc1_weight_rows:fc1_weight_rows+i*fc1_weight_rows], stack_and_transpose(fc1_weight[0+fc1_weight_batch*j:fc1_weight_batch+fc1_weight_batch*j, 0+i*fc1_weight_rows:fc1_weight_rows+i*fc1_weight_rows]))
			
			fc1_out_split = np.concatenate([fc1_out_split, result])
			
		fc1_out.append(fc1_out_split)
		
	fc1_out = np.array(fc1_out).sum(axis=0).reshape(1, 120)
	
	save_array_to_21bit_binary_txt(fc1_out, 'layer_3_out.txt')
    
	# fc1_out = matrix_multiply(fc1_weight, flattened)
	
	relu3_out = relu(fc1_out)
	
	relu3_out = relu3_out // 4096
	
	relu3_out = stack_and_transpose(relu3_out)
	
	
	# layer 4
	fc2_out_split = []
	fc2_out = [] 
	fc2_weight_rows = 24
	fc2_weight_batch = 7
	for i in range(relu3_out.shape[0]//fc2_weight_rows):
		fc2_out_split = []
		for j in range(fc2_weight.shape[0]//fc2_weight_batch):
			result = matrix_multiply(stack_and_transpose(relu3_out[0+i*fc2_weight_rows:fc2_weight_rows+i*fc2_weight_rows]), stack_and_transpose(fc2_weight[0+fc2_weight_batch*j:fc2_weight_batch+fc2_weight_batch*j, 0+i*fc2_weight_rows:fc2_weight_rows+i*fc2_weight_rows]))
			
			fc2_out_split = np.concatenate([fc2_out_split, result.squeeze()])
			
		fc2_out.append(fc2_out_split)
		
	fc2_out = np.array(fc2_out).sum(axis=0).reshape(1, 84)
	
	
	# fc2_out = matrix_multiply(fc2_weight, relu3_out)
	relu4_out = relu(fc2_out)
	relu4_out =relu4_out // 4096
	relu4_out = stack_and_transpose(relu4_out)
		
	
	# layer 5
	fc3_out_split = []
	fc3_out = [] 
	fc3_weight_rows = 21
	fc3_weight_batch = 5
	for i in range(relu4_out.shape[0]//fc3_weight_rows):
		fc3_out_split = []
		for j in range(fc3_weight.shape[0]//fc3_weight_batch):
			result = matrix_multiply(stack_and_transpose(relu4_out[0+i*fc3_weight_rows:fc3_weight_rows+i*fc3_weight_rows]), stack_and_transpose(fc3_weight[0+fc3_weight_batch*j:fc3_weight_batch+fc3_weight_batch*j, 0+i*fc3_weight_rows:fc3_weight_rows+i*fc3_weight_rows]))
			
			fc3_out_split = np.concatenate([fc3_out_split, result.squeeze()])
			
		fc3_out.append(fc3_out_split)
		
	fc3_out = np.array(fc3_out).sum(axis=0).reshape(1, 10)
	
	
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


conv2_weight_merge_c0_former = conv2_weight_merge_c0[:, 0:8]
conv2_weight_merge_c1_former = conv2_weight_merge_c1[:, 0:8]
conv2_weight_merge_c2_former = conv2_weight_merge_c2[:, 0:8]
conv2_weight_merge_c3_former = conv2_weight_merge_c3[:, 0:8]
conv2_weight_merge_c4_former = conv2_weight_merge_c4[:, 0:8]
conv2_weight_merge_c5_former = conv2_weight_merge_c5[:, 0:8]

conv2_weight_merge_c0_later  = conv2_weight_merge_c0[:, 8:16]
conv2_weight_merge_c1_later  = conv2_weight_merge_c1[:, 8:16]
conv2_weight_merge_c2_later  = conv2_weight_merge_c2[:, 8:16]
conv2_weight_merge_c3_later  = conv2_weight_merge_c3[:, 8:16]
conv2_weight_merge_c4_later  = conv2_weight_merge_c4[:, 8:16]
conv2_weight_merge_c5_later  = conv2_weight_merge_c5[:, 8:16]


weight_2_c0_former_addr, weight_2_c0_former_count, weight_2_c0_former_data = genAdrCountData(conv2_weight_merge_c0_former, False)
weight_2_c1_former_addr, weight_2_c1_former_count, weight_2_c1_former_data = genAdrCountData(conv2_weight_merge_c1_former, False)
weight_2_c2_former_addr, weight_2_c2_former_count, weight_2_c2_former_data = genAdrCountData(conv2_weight_merge_c2_former, False)
weight_2_c3_former_addr, weight_2_c3_former_count, weight_2_c3_former_data = genAdrCountData(conv2_weight_merge_c3_former, False)
weight_2_c4_former_addr, weight_2_c4_former_count, weight_2_c4_former_data = genAdrCountData(conv2_weight_merge_c4_former, False)
weight_2_c5_former_addr, weight_2_c5_former_count, weight_2_c5_former_data = genAdrCountData(conv2_weight_merge_c5_former, False)

weight_2_c0_later_addr, weight_2_c0_later_count, weight_2_c0_later_data = genAdrCountData(conv2_weight_merge_c0_later, False)
weight_2_c1_later_addr, weight_2_c1_later_count, weight_2_c1_later_data = genAdrCountData(conv2_weight_merge_c1_later, False)
weight_2_c2_later_addr, weight_2_c2_later_count, weight_2_c2_later_data = genAdrCountData(conv2_weight_merge_c2_later, False)
weight_2_c3_later_addr, weight_2_c3_later_count, weight_2_c3_later_data = genAdrCountData(conv2_weight_merge_c3_later, False)
weight_2_c4_later_addr, weight_2_c4_later_count, weight_2_c4_later_data = genAdrCountData(conv2_weight_merge_c4_later, False)
weight_2_c5_later_addr, weight_2_c5_later_count, weight_2_c5_later_data = genAdrCountData(conv2_weight_merge_c5_later, False)



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


merge_txt_files(['iact_2_c0_addr.txt', 'iact_2_c1_addr.txt', 'iact_2_c2_addr.txt', 'iact_2_c3_addr.txt', 'iact_2_c4_addr.txt', 'iact_2_c5_addr.txt'], [2,2,2,2,2,2,], 'iact_2_addr.txt')
merge_txt_files(['iact_2_c0_data_count.txt', 'iact_2_c1_data_count.txt', 'iact_2_c2_data_count.txt', 'iact_2_c3_data_count.txt', 'iact_2_c4_data_count.txt', 'iact_2_c5_data_count.txt'], [2,2,2,2,2,2,], 'iact_2_data_count.txt')

merge_txt_files(['weight_2_c0_former_addr.txt', 'weight_2_c0_later_addr.txt', 
                 'weight_2_c1_former_addr.txt', 'weight_2_c1_later_addr.txt', 
                 'weight_2_c2_former_addr.txt', 'weight_2_c2_later_addr.txt', 
                 'weight_2_c3_former_addr.txt', 'weight_2_c3_later_addr.txt', 
                 'weight_2_c4_former_addr.txt', 'weight_2_c4_later_addr.txt', 
                 'weight_2_c5_former_addr.txt', 'weight_2_c5_later_addr.txt'], [16,16,16,16,16,16,16,16,16,16,16,16], 'weight_2_addr.txt')

merge_txt_files(['weight_2_c0_former_data_count.txt', 'weight_2_c0_later_data_count.txt', 
                 'weight_2_c1_former_data_count.txt', 'weight_2_c1_later_data_count.txt', 
                 'weight_2_c2_former_data_count.txt', 'weight_2_c2_later_data_count.txt', 
                 'weight_2_c3_former_data_count.txt', 'weight_2_c3_later_data_count.txt', 
                 'weight_2_c4_former_data_count.txt', 'weight_2_c4_later_data_count.txt', 
                 'weight_2_c5_former_data_count.txt', 'weight_2_c5_later_data_count.txt'], [16,16,16,16,16,16,16,16,16,16,16,16], 'weight_2_data_count.txt')



weight_3_addr_list = []
weight_3_data_count_list = []
mode = 'w'
for i in range(16):
	for j in range(30):
		fc1_weight_matrix_temp = fc1_weight[0+4*j:4+4*j, i*16:16+i*16]
		fc1_modify_matrix = modify_matrix(fc1_weight_matrix_temp)
		weight_3_addr, weight_3_count, weight_3_data = genAdrCountData(fc1_modify_matrix, False)
		weight_3_data_count = combineDataAndCount(weight_3_data, weight_3_count, cscDataWidth=8, cscCountWidth=4)
	
		weight_3_addr_list.append(weight_3_addr)
		weight_3_data_count_list.append(weight_3_data_count)
		
		
		save_dec_as_hex_to_txt(weight_3_addr, 'weight_3_addr.txt', mode)
		save_data_to_txt(weight_3_data_count, 'weight_3_data_count.txt', mode) 
        
		mode = 'a'










# layer 0
ifmap = np.squeeze(ifmap)
ifmap_matrix = im2col(ifmap, 5)


# layer 1
# split as a simulation in hardware architecture
layer_1_out_split = []
for i in range(ifmap_matrix.shape[0] // 4 ):
    # noise
    ifamp_splited = modify_matrix(ifmap_matrix[4 * i: 4 * i + 4])
    
    result = matrix_multiply(ifamp_splited, conv1_weight_merge)
    layer_1_out_split.append(result)
    
layer_1_out = np.vstack(layer_1_out_split)

layer_1_out = np.array(reshape_to_squares(layer_1_out,24))

relu1_out = []
pool1_out = []
for i in range(layer_1_out.shape[0]):
	relu1_out.append(relu(layer_1_out[i]))
	pool1_out.append(max_pool2d(relu1_out[i], kernel_size=2, stride=2))
		
pool1_out = np.array(pool1_out)
pool1_out = pool1_out // 4096


layer_1_out_matrix_0_c0 = im2col(pool1_out[0], 5)
layer_1_out_matrix_0_c1 = im2col(pool1_out[1], 5)
layer_1_out_matrix_0_c2 = im2col(pool1_out[2], 5)
layer_1_out_matrix_0_c3 = im2col(pool1_out[3], 5)
layer_1_out_matrix_0_c4 = im2col(pool1_out[4], 5)
layer_1_out_matrix_0_c5 = im2col(pool1_out[5], 5)


# layer 2
layer_2_out_0 = matrix_multiply(layer_1_out_matrix_0_c0, conv2_weight_merge_c0)
layer_2_out_1 = matrix_multiply(layer_1_out_matrix_0_c1, conv2_weight_merge_c1)
layer_2_out_2 = matrix_multiply(layer_1_out_matrix_0_c2, conv2_weight_merge_c2)
layer_2_out_3 = matrix_multiply(layer_1_out_matrix_0_c3, conv2_weight_merge_c3)
layer_2_out_4 = matrix_multiply(layer_1_out_matrix_0_c4, conv2_weight_merge_c4)
layer_2_out_5 = matrix_multiply(layer_1_out_matrix_0_c5, conv2_weight_merge_c5)

layer_2_out = merge_arrays(layer_2_out_0, layer_2_out_1, layer_2_out_2, layer_2_out_3, layer_2_out_4, layer_2_out_5)

layer_2_out = np.array(reshape_to_squares(layer_2_out, 8))

relu2_out = []
pool2_out = []
for i in range(layer_2_out.shape[0]):
	relu2_out.append(relu(layer_2_out[i]))
	pool2_out.append(max_pool2d(relu2_out[i], kernel_size=2, stride=2))
		
pool2_out = np.array(pool2_out)
pool2_out = pool2_out // 4096



flattened = pool2_out.flatten()
	
# layer 3
fc1_out = matrix_multiply(fc1_weight, flattened)
relu3_out = relu(fc1_out)
relu3_out =relu3_out // 4096
	
# layer 4
fc2_out = matrix_multiply(fc2_weight, relu3_out)
relu4_out = relu(fc2_out)
relu4_out =relu4_out // 4096
	
# layer 5
fc3_out = matrix_multiply(fc3_weight, relu4_out)


'''
# layer 0
ifmap = np.squeeze(ifmap)
ifmap_matrix = im2col(ifmap, 5)
'''
#output = LeNet_with_GEMM(ifmap_matrix)
prediction = softmax(LeNet_with_GEMM(ifmap_matrix))



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


accuracy = evaluate_mnist(10)
print(f'Accuracy on MNIST test set: {accuracy:.4f}%')




