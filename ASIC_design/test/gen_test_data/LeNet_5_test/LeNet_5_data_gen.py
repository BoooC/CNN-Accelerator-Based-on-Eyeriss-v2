import numpy as np


def threshold_array_by_mean_abs(arr, factor=0.8):
    threshold = np.mean(np.abs(arr)) * factor
    arr[np.abs(arr) < threshold] = 0
    return arr


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
        if max(currentCol) == 0:  # if zero column
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


def toBinary(i, digits):
    return format(int(i), f'0{digits}b')


def combineDataAndCount(theData, theCount, cscDataWidth=8, cscCountWidth=4):
    theDataWithCount = list(zip(theData, theCount))
    theDataCountBinary = [toBinary(x, cscDataWidth) + toBinary(y, cscCountWidth) for x, y in theDataWithCount]
    theDataCountDec = [int(binary_str, 2) for binary_str in theDataCountBinary]
    return theDataCountDec


def save_1D_list_as_hex_to_txt(input_list, filename, mode):
    hex_list = [hex(item)[2:] for item in input_list]
    
    with open(filename, mode) as file:
        for hex_val in hex_list:
            file.write(hex_val + "\n")
            
def save_2D_list_as_hex_to_txt(input_list, filename, mode):
    hex_list = [hex(item)[2:] for sublist in input_list for item in sublist]
    
    with open(filename, mode) as file:
        for hex_val in hex_list:
            file.write(hex_val + "\n")

def save_2d_array_to_txt(matrix, filename, mode):
    with open(filename, mode) as f:
        for row in matrix:
            # Convert each item in the row to a string and join them with a space
            line = ' '.join(map(str, row))
            f.write(line + '\n')
        f.write('\n')


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


def ndarray_to_list(ndarray):
    return ndarray.tolist()


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


def flatten_2d_array(arr):
    return arr.flatten()


def transpose_2d_array(arr):
    return arr.T


def matrix_multiply(arr1, arr2):
    return np.dot(arr1, arr2)


def reshape_to_square_matrix(arr, side_length):
    if arr.size != side_length ** 2:
        raise ValueError("Array size is not compatible with the given square matrix side length.")

    return arr.reshape(side_length, side_length)


def save_1D_list_as_hex_to_txt(input_list, filename, mode):
    hex_list = [hex(item)[2:] for item in input_list]
    
    with open(filename, mode) as file:
        for hex_val in hex_list:
            file.write(hex_val + "\n")
            
            
def stack_and_transpose(arrays):
    stacked_array = np.vstack(arrays)
    return np.transpose(stacked_array)            



ifmap_path = '5.txt' 

conv1_weight_path = 'kernel1.txt' 
conv2_weight_path = 'kernel2.txt' 

fc1_weight_path = 'kernel3.txt' 
fc2_weight_path = 'kernel4.txt' 
fc3_weight_path = 'kernel5.txt' 


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


ifmap = read_matrices_from_file(ifmap_path, 28, 1)
ifmap = np.squeeze(ifmap, axis=0)
ifmap = np.squeeze(ifmap)
conv1_weight = np.squeeze(conv1_weight)

ifmap        = im2col(ifmap, 5)
ifmap        = ifmap[152:158, ]
 
conv1_weight_0 = flatten_2d_array(conv1_weight[0])
conv1_weight_1 = flatten_2d_array(conv1_weight[1])
conv1_weight_2 = flatten_2d_array(conv1_weight[2])
conv1_weight_3 = flatten_2d_array(conv1_weight[3])
conv1_weight = stack_and_transpose([conv1_weight_0, conv1_weight_1, conv1_weight_2, conv1_weight_3])

conv1_weight[conv1_weight < 0] = 0

result = matrix_multiply(ifmap, conv1_weight)
result = result.flatten().tolist()
result = [int(item) for item in result]

'''
result_0 = reshape_to_square_matrix(result[:, 0], 24)
result_1 = reshape_to_square_matrix(result[:, 1], 24)
result_2 = reshape_to_square_matrix(result[:, 2], 24)
result_3 = reshape_to_square_matrix(result[:, 3], 24)
'''

'''
ifmap        = transpose_2d_array(ifmap)
conv1_weight = transpose_2d_array(conv1_weight)
'''

iact_0_addr, iact_0_count, iact_0_data = genAdrCountData(ifmap, True)

weight_0_addr, weight_0_count, weight_0_data = genAdrCountData(conv1_weight, False)


iact_0_data_count = combineDataAndCount(iact_0_data, iact_0_count, cscDataWidth=8, cscCountWidth=4)

weight_0_data_count = combineDataAndCount(weight_0_data, weight_0_count, cscDataWidth=8, cscCountWidth=5)

save_1D_list_as_hex_to_txt(iact_0_addr, './PE_test/iact_addr.txt', 'w')
save_1D_list_as_hex_to_txt(iact_0_data_count, './PE_test/iact_data_count.txt', 'w')

save_1D_list_as_hex_to_txt(weight_0_addr, './PE_test/weight_addr.txt', 'w')
save_1D_list_as_hex_to_txt(weight_0_data_count, './PE_test/weight_data_count.txt', 'w')

save_1D_list_as_hex_to_txt(result, './PE_test/result.txt', 'w')
