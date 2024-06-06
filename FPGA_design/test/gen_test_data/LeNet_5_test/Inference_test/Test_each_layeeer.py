import numpy as np

def read_matrix_from_file(file_path):
    matrix = []
    with open(file_path, 'r') as file:
        for line in file:
            cleaned_line = line.strip().replace('[', '').replace(']', '').replace(',', '')
            float_nums = [float(num) for num in cleaned_line.split()]
            matrix.append(float_nums)
    return np.array(matrix)




def write_scaled_matrix_to_file(matrix, scale, file_path):
    with open(file_path, 'w') as file:
        for row in matrix:
            scaled_row = '[' + ' '.join(f'{num * scale:4.1f}' for num in row) + ']\n'
            file.write(scaled_row)

def quantize(value, scale, zero_point):
    return np.round(value / scale + zero_point).astype(np.int8)

def dequantize(value, scale, zero_point):
    return (value - zero_point) * scale



def conv2d(ifmap, filter, stride, padding):
    out_height = int((ifmap.shape[0] - filter.shape[0] + 2 * padding) / stride + 1)
    out_width = int((ifmap.shape[1] - filter.shape[1] + 2 * padding) / stride + 1)

    if padding > 0:
        ifmap_padded = np.pad(ifmap, ((padding, padding), (padding, padding)), mode='constant', constant_values=0)
    else:
        ifmap_padded = ifmap

    output = np.zeros((out_height, out_width))

    for y in range(0, out_height):
        for x in range(0, out_width):
            output[y, x] = np.sum(ifmap_padded[y * stride:y * stride + filter.shape[0],
                                               x * stride:x * stride + filter.shape[1]] * filter)
    return output


def conv3d(ifmap, filters, stride, padding):
    num_filters, filter_height, filter_width, _ = filters.shape
    output_height = int((ifmap.shape[0] - filter_height + 2 * padding) / stride + 1)
    output_width = int((ifmap.shape[1] - filter_width + 2 * padding) / stride + 1)

    output = np.zeros((output_height, output_width, num_filters))

    for i in range(num_filters):
        filter = filters[i]
        for c in range(ifmap.shape[2]):
            ifmap_channel = ifmap[:, :, c]
            filter_channel = filter[:, :, c]
            output_channel = conv2d(ifmap_channel, filter_channel, stride, padding)
            output[:, :, i] += output_channel

    return output




def relu(x):
    return np.maximum(0, x)


def max_pooling(input, kernel_size, stride, padding):
    input_padded = np.pad(input, ((padding, padding), (padding, padding)), mode='constant', constant_values=(0, 0))

    output_height = ((input.shape[0] - kernel_size + 2 * padding) // stride) + 1
    output_width = ((input.shape[1] - kernel_size + 2 * padding) // stride) + 1

    output = np.zeros((output_height, output_width))

    for y in range(0, output_height):
        for x in range(0, output_width):
            output[y, x] = np.max(input_padded[y*stride:y*stride+kernel_size, x*stride:x*stride+kernel_size])

    return output


def fully_connected(input_features, out_features, weights, bias=None):
    output = np.dot(weights, input_features)
    if bias is not None:
        output += bias
    return output



kernel1_path = 'layer1/kernel1.txt' 
kernel2_path = 'layer1/kernel2.txt' 

kernel3_path = 'layer1/kernel3.txt' 
kernel4_path = 'layer1/kernel4.txt' 
kernel5_path = 'layer1/kernel5.txt' 

ifmap_path = 'layer1/ifmap.txt' 
output_path = 'layer1/ofmap.txt'

kernel1 = read_matrix_from_file(kernel1_path)
kernel2 = read_matrix_from_file(kernel2_path)

kernel3 = read_matrix_from_file(kernel3_path)
kernel4 = read_matrix_from_file(kernel4_path)
kernel5 = read_matrix_from_file(kernel5_path)


ifmap = read_matrix_from_file(ifmap_path)

print("Kernel1 shape:", kernel1.shape)
print("Kernel2 shape:", kernel2.shape)
print("Kernel3 shape:", kernel3.shape)
print("Kernel4 shape:", kernel4.shape)
print("Kernel5 shape:", kernel5.shape)
print("IFMap shape:", ifmap.shape)


scaled_input_conv1_ifmap  = ifmap # dequantize(ifmap, scale_ifmap, zero_point_ifmap)
scaled_input_conv1_weight = kernel1 # dequantize(kernel, scale_conv1, zero_point_conv1)

output_conv1 = conv2d(ifmap, kernel1, 1, 0)
output_conv1 = output_conv1
output_relu1 = relu(output_conv1)
#output_pool1 = max_pooling(output_conv1, 2, 2, 0)

# scaled_output_layer1 = dequantize(output_pool1, scale_conv1, zero_point_conv1)
# scaled_input_layer2  = quantize(scaled_output_layer1, scale_conv2, zero_point_conv2)
'''
output_conv2 = conv2d(output_pool1, kernel2, 1, 0)
output_relu2 = relu(output_conv2)
output_pool2 = max_pooling(output_relu2, 2, 2, 0)
'''



print("Output conv1 shape:", output_relu1.shape)

write_scaled_matrix_to_file(output_relu1, 1, output_path)

