import random

def genSparse(rows, cols, max_val, ratio):
    if not (0 <= ratio <= 1):
        raise ValueError("the range of ratio should be [0, 1]")

    resultList = []

    # Generate the initial matrix
    for _ in range(rows):
        temRowList = []
        for _ in range(cols):
            if random.random() >= ratio:
                temRowList.append(random.randint(1, max_val - 1))
            else:
                temRowList.append(0)
        resultList.append(temRowList)

    # Ensure the first two columns and the last column are not all zeros
    for j in [0, 1, -1]:
        if all(row[j] == 0 for row in resultList):
            row_to_change = random.randint(0, rows - 1)
            resultList[row_to_change][j] = random.randint(1, max_val - 1)

    # Ensure no two consecutive columns are all zeros
    for j in range(0, cols - 1):
        if all(row[j] == 0 for row in resultList) and all(row[j + 1] == 0 for row in resultList):
            row_to_change = random.randint(0, rows - 1)
            col_to_change = j if random.random() < 0.5 else j + 1
            resultList[row_to_change][col_to_change] = random.randint(1, max_val - 1)

    return resultList

'''
def genSparse(rows, cols, max_val, ratio):
    if not (0 <= ratio <= 1):
        raise ValueError("the range of ratio should be [0, 1]")

    resultList = []

    for _ in range(rows):
        temRowList = []
        for _ in range(cols):
            if random.random() >= ratio:
                temRowList.append(random.randint(1, max_val - 1))
            else:
                temRowList.append(0)
        resultList.append(temRowList)

    return resultList
'''

# matrix multiply
def golden_result(listA, listB):
    assert len(listB) == len(listA[0]), "listA's column number should equal to listB's row number"
    rowNum = len(listA)
    colNum = len(listB[0])
    addTimes = len(listB)
    
    resultList = []
    
    for i in range(rowNum):
        tempRowList = []
        for j in range(colNum):
            tempResult = 0
            for k in range(addTimes):
                tempResult += listA[i][k] * listB[k][j]
            tempRowList.append(tempResult)
        resultList.append(tempRowList)
        
    return resultList

# matrix flatten
def goldenFlatResult(listA, listB):
    tempResult = golden_result(listA, listB)
    resultList = []
    
    for j in range(len(tempResult[0])):
        currentCol = [row[j] for row in tempResult]
        resultList.extend(currentCol)
        
    return resultList


def elementwise_addition(list1, list2, list3):
    result = [a + b + c for a, b, c in zip(list1, list2, list3)]
    '''
    if not (len(mat1) == len(mat2) == len(mat3) and len(mat1[0]) == len(mat2[0]) == len(mat3[0])):
        raise ValueError("所有的矩陣必須具有相同的維度")
    
    result = []
    for i in range(len(mat1)):
        row = []
        for j in range(len(mat1[0])):
            row.append(mat1[i][j] + mat2[i][j] + mat3[i][j])
        result.append(row)
    '''
    return result

def genAdrCountData(listA, inActOrWeight):
    if inActOrWeight:
        zeroCode = 15
        max_val = 15
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
    
    violation = False
    if max(adrList) > max_val:
        # print(f"{max(adrList)} <= {max_val}?\n{adrList}\n\n{dataList}\n")
        violation = True
        
    return adrList, countList, dataList # , violation

def toBinary(i, digits):
    return format(i, f'0{digits}b')

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


def gen_all_data(iter_sets):
	for i in range(iter_sets):
		iact_0_violation = True
		iact_1_violation = True
		iact_2_violation = True
		iact_3_violation = True
		iact_4_violation = True
		iact_5_violation = True
		while iact_0_violation:
			iact0   = genSparse(8, 6, 10, 0.8)
			iact_0_addr, iact_0_count, iact_0_data, iact_0_violation = genAdrCountData(iact0, True)
		while iact_1_violation:
			iact1   = genSparse(8, 6, 10, 0.8)
			iact_1_addr, iact_1_count, iact_1_data, iact_1_violation = genAdrCountData(iact1, True)
		while iact_2_violation:
			iact2   = genSparse(8, 6, 10, 0.8)
			iact_2_addr, iact_2_count, iact_2_data, iact_2_violation = genAdrCountData(iact2, True)
		while iact_3_violation: 
			iact3   = genSparse(8, 6, 10, 0.8)
			iact_3_addr, iact_3_count, iact_3_data, iact_3_violation = genAdrCountData(iact3, True)
		while iact_4_violation:
			iact4   = genSparse(8, 6, 10, 0.8)
			iact_4_addr, iact_4_count, iact_4_data, iact_4_violation = genAdrCountData(iact4, True)
		while iact_5_violation:
			iact5   = genSparse(8, 6, 10, 0.8)
			iact_5_addr, iact_5_count, iact_5_data, iact_5_violation = genAdrCountData(iact5, True)
			
		weight_0_violation = True
		weight_1_violation = True
		weight_2_violation = True
		while weight_0_violation:
			weight0 = genSparse(4, 8, 10, 0.6)
			weight_0_addr, weight_0_count, weight_0_data, weight_0_violation = genAdrCountData(weight0, False)
		while weight_1_violation:
			weight1 = genSparse(4, 8, 10, 0.6)
			weight_1_addr, weight_1_count, weight_1_data, weight_1_violation = genAdrCountData(weight1, False)
		while weight_2_violation:
			weight2 = genSparse(4, 8, 10, 0.6)
			weight_2_addr, weight_2_count, weight_2_data, weight_2_violation = genAdrCountData(weight2, False)
		
		psum_00_matrix = golden_result(weight0, iact0)
		psum_10_matrix = golden_result(weight1, iact1)
		psum_20_matrix = golden_result(weight2, iact2)
		
		psum_01_matrix = golden_result(weight0, iact1)
		psum_11_matrix = golden_result(weight1, iact2)
		psum_21_matrix = golden_result(weight2, iact3)
					
		psum_02_matrix = golden_result(weight0, iact2)
		psum_12_matrix = golden_result(weight1, iact3)
		psum_22_matrix = golden_result(weight2, iact4)
				
		psum_03_matrix = golden_result(weight0, iact3)
		psum_13_matrix = golden_result(weight1, iact4)
		psum_23_matrix = golden_result(weight2, iact5)
		
		psum_00 = goldenFlatResult(weight0, iact0)
		psum_10 = goldenFlatResult(weight1, iact1)
		psum_20 = goldenFlatResult(weight2, iact2)
		
		psum_01 = goldenFlatResult(weight0, iact1)
		psum_11 = goldenFlatResult(weight1, iact2)
		psum_21 = goldenFlatResult(weight2, iact3)
		
		psum_02 = goldenFlatResult(weight0, iact2)
		psum_12 = goldenFlatResult(weight1, iact3)
		psum_22 = goldenFlatResult(weight2, iact4)
		
		psum_03 = goldenFlatResult(weight0, iact3)
		psum_13 = goldenFlatResult(weight1, iact4)
		psum_23 = goldenFlatResult(weight2, iact5)
		
		psum_0_out = elementwise_addition(psum_00, psum_10, psum_20)
		psum_1_out = elementwise_addition(psum_01, psum_11, psum_21)
		psum_2_out = elementwise_addition(psum_02, psum_12, psum_22)
		psum_3_out = elementwise_addition(psum_03, psum_13, psum_23)
			
		iact_0_data_count = combineDataAndCount(iact_0_data, iact_0_count, cscDataWidth=8, cscCountWidth=4)
		iact_1_data_count = combineDataAndCount(iact_1_data, iact_1_count, cscDataWidth=8, cscCountWidth=4)
		iact_2_data_count = combineDataAndCount(iact_2_data, iact_2_count, cscDataWidth=8, cscCountWidth=4)
		iact_3_data_count = combineDataAndCount(iact_3_data, iact_3_count, cscDataWidth=8, cscCountWidth=4)
		iact_4_data_count = combineDataAndCount(iact_4_data, iact_4_count, cscDataWidth=8, cscCountWidth=4)
		iact_5_data_count = combineDataAndCount(iact_5_data, iact_5_count, cscDataWidth=8, cscCountWidth=4)
		
		weight_0_data_count = combineDataAndCount(weight_0_data, weight_0_count, cscDataWidth=8, cscCountWidth=4)
		weight_1_data_count = combineDataAndCount(weight_1_data, weight_1_count, cscDataWidth=8, cscCountWidth=4)
		weight_2_data_count = combineDataAndCount(weight_2_data, weight_2_count, cscDataWidth=8, cscCountWidth=4)
		
		if i == 1:
			mode = 'w'
		else:
			mode = 'a'
		
		save_1D_list_as_hex_to_txt(iact_0_addr + iact_3_addr, './PE_cluster_test/iact_0_addr.txt', mode)
		save_1D_list_as_hex_to_txt(iact_1_addr + iact_4_addr, './PE_cluster_test/iact_1_addr.txt', mode)
		save_1D_list_as_hex_to_txt(iact_2_addr + iact_5_addr, './PE_cluster_test/iact_2_addr.txt', mode)
		
		save_1D_list_as_hex_to_txt(iact_0_data_count + iact_3_data_count, './PE_cluster_test/iact_0_data_count.txt', mode)
		save_1D_list_as_hex_to_txt(iact_1_data_count + iact_4_data_count, './PE_cluster_test/iact_1_data_count.txt', mode)
		save_1D_list_as_hex_to_txt(iact_2_data_count + iact_5_data_count, './PE_cluster_test/iact_2_data_count.txt', mode)
		
		save_1D_list_as_hex_to_txt(weight_0_addr, './PE_cluster_test/weight_0_addr.txt', mode)
		save_1D_list_as_hex_to_txt(weight_1_addr, './PE_cluster_test/weight_1_addr.txt', mode)
		save_1D_list_as_hex_to_txt(weight_2_addr, './PE_cluster_test/weight_2_addr.txt', mode)
							
		save_1D_list_as_hex_to_txt(weight_0_data_count, './PE_cluster_test/weight_0_data_count.txt', mode)
		save_1D_list_as_hex_to_txt(weight_1_data_count, './PE_cluster_test/weight_1_data_count.txt', mode)
		save_1D_list_as_hex_to_txt(weight_2_data_count, './PE_cluster_test/weight_2_data_count.txt', mode)
		
		save_1D_list_as_hex_to_txt(psum_0_out, './PE_cluster_test/psum_0_out.txt', mode)
		save_1D_list_as_hex_to_txt(psum_1_out, './PE_cluster_test/psum_1_out.txt', mode)
		save_1D_list_as_hex_to_txt(psum_2_out, './PE_cluster_test/psum_2_out.txt', mode)
		save_1D_list_as_hex_to_txt(psum_3_out, './PE_cluster_test/psum_3_out.txt', mode)
		
		save_2d_array_to_txt(iact0, './PE_cluster_test/iact0.txt', mode)
		save_2d_array_to_txt(iact1, './PE_cluster_test/iact1.txt', mode)
		save_2d_array_to_txt(iact2, './PE_cluster_test/iact2.txt', mode)
		save_2d_array_to_txt(iact3, './PE_cluster_test/iact3.txt', mode)
		save_2d_array_to_txt(iact4, './PE_cluster_test/iact4.txt', mode)
		save_2d_array_to_txt(iact5, './PE_cluster_test/iact5.txt', mode)
		
		save_2d_array_to_txt(weight0, './PE_cluster_test/weight0.txt', mode)
		save_2d_array_to_txt(weight1, './PE_cluster_test/weight1.txt', mode)
		save_2d_array_to_txt(weight2, './PE_cluster_test/weight2.txt', mode)
		
		save_2d_array_to_txt(psum_00_matrix, './PE_cluster_test/psum_00.txt', mode)
		save_2d_array_to_txt(psum_10_matrix, './PE_cluster_test/psum_10.txt', mode)
		save_2d_array_to_txt(psum_20_matrix, './PE_cluster_test/psum_20.txt', mode)
		save_2d_array_to_txt(psum_01_matrix, './PE_cluster_test/psum_01.txt', mode)
		save_2d_array_to_txt(psum_11_matrix, './PE_cluster_test/psum_11.txt', mode)
		save_2d_array_to_txt(psum_21_matrix, './PE_cluster_test/psum_21.txt', mode)
		save_2d_array_to_txt(psum_02_matrix, './PE_cluster_test/psum_02.txt', mode)
		save_2d_array_to_txt(psum_12_matrix, './PE_cluster_test/psum_12.txt', mode)
		save_2d_array_to_txt(psum_22_matrix, './PE_cluster_test/psum_22.txt', mode)
		save_2d_array_to_txt(psum_03_matrix, './PE_cluster_test/psum_03.txt', mode)
		save_2d_array_to_txt(psum_13_matrix, './PE_cluster_test/psum_13.txt', mode)
		save_2d_array_to_txt(psum_23_matrix, './PE_cluster_test/psum_23.txt', mode)

        
    # return iact0, iact1, iact2, iact3, iact4, iact5, weight0, weight1, weight2, psum_01, psum_02, psum_03, psum_11, psum_12, psum_13, psum_21, psum_22, psum_23, psum_0_out, psum_1_out, psum_2_out, psum_3_out

iter_sets = 12
# gen_all_data(iter_sets)




'''
iact0   = genSparse(8, 6, 10, 0.8)
iact1   = genSparse(8, 6, 10, 0.8)
iact2   = genSparse(8, 6, 10, 0.8)
iact3   = genSparse(8, 6, 10, 0.8)
iact4   = genSparse(8, 6, 10, 0.8)
iact5   = genSparse(8, 6, 10, 0.8)

weight0 = genSparse(4, 8, 10, 0.6)
weight1 = genSparse(4, 8, 10, 0.6)
weight2 = genSparse(4, 8, 10, 0.6)

psum_00 = goldenFlatResult(weight0, iact0)
psum_10 = goldenFlatResult(weight1, iact1)
psum_20 = goldenFlatResult(weight2, iact2)

psum_01 = goldenFlatResult(weight0, iact1)
psum_11 = goldenFlatResult(weight1, iact2)
psum_21 = goldenFlatResult(weight2, iact3)

psum_02 = goldenFlatResult(weight0, iact2)
psum_12 = goldenFlatResult(weight1, iact3)
psum_22 = goldenFlatResult(weight2, iact4)

psum_03 = goldenFlatResult(weight0, iact3)
psum_13 = goldenFlatResult(weight1, iact4)
psum_23 = goldenFlatResult(weight2, iact5)

psum_0_out = elementwise_addition(psum_00, psum_10, psum_20)
psum_1_out = elementwise_addition(psum_01, psum_11, psum_21)
psum_2_out = elementwise_addition(psum_02, psum_12, psum_22)
psum_3_out = elementwise_addition(psum_03, psum_13, psum_23)

iact_0_addr, iact_0_count, iact_0_data = genAdrCountData(iact0, True)
iact_1_addr, iact_1_count, iact_1_data = genAdrCountData(iact1, True)
iact_2_addr, iact_2_count, iact_2_data = genAdrCountData(iact2, True)
iact_3_addr, iact_3_count, iact_3_data = genAdrCountData(iact3, True)
iact_4_addr, iact_4_count, iact_4_data = genAdrCountData(iact4, True)
iact_5_addr, iact_5_count, iact_5_data = genAdrCountData(iact5, True)

weight_0_addr, weight_0_count, weight_0_data = genAdrCountData(weight0, False)
weight_1_addr, weight_1_count, weight_1_data = genAdrCountData(weight1, False)
weight_2_addr, weight_2_count, weight_2_data = genAdrCountData(weight2, False)


iact_0_data_count = combineDataAndCount(iact_0_data, iact_0_count, cscDataWidth=8, cscCountWidth=4)
iact_1_data_count = combineDataAndCount(iact_1_data, iact_1_count, cscDataWidth=8, cscCountWidth=4)
iact_2_data_count = combineDataAndCount(iact_2_data, iact_2_count, cscDataWidth=8, cscCountWidth=4)
iact_3_data_count = combineDataAndCount(iact_3_data, iact_3_count, cscDataWidth=8, cscCountWidth=4)
iact_4_data_count = combineDataAndCount(iact_4_data, iact_4_count, cscDataWidth=8, cscCountWidth=4)
iact_5_data_count = combineDataAndCount(iact_5_data, iact_5_count, cscDataWidth=8, cscCountWidth=4)

weight_0_data_count = combineDataAndCount(weight_0_data, weight_0_count, cscDataWidth=8, cscCountWidth=4)
weight_1_data_count = combineDataAndCount(weight_1_data, weight_1_count, cscDataWidth=8, cscCountWidth=4)
weight_2_data_count = combineDataAndCount(weight_2_data, weight_2_count, cscDataWidth=8, cscCountWidth=4)


save_1D_list_as_hex_to_txt(psum_00, './PE_cluster_test/psum_00.txt')
save_1D_list_as_hex_to_txt(psum_01, './PE_cluster_test/psum_01.txt')
save_1D_list_as_hex_to_txt(psum_02, './PE_cluster_test/psum_02.txt')
save_1D_list_as_hex_to_txt(psum_03, './PE_cluster_test/psum_03.txt')

save_1D_list_as_hex_to_txt(psum_10, './PE_cluster_test/psum_10.txt')
save_1D_list_as_hex_to_txt(psum_11, './PE_cluster_test/psum_11.txt')
save_1D_list_as_hex_to_txt(psum_12, './PE_cluster_test/psum_12.txt')
save_1D_list_as_hex_to_txt(psum_13, './PE_cluster_test/psum_13.txt')

save_1D_list_as_hex_to_txt(psum_20, './PE_cluster_test/psum_20.txt')
save_1D_list_as_hex_to_txt(psum_21, './PE_cluster_test/psum_21.txt')
save_1D_list_as_hex_to_txt(psum_22, './PE_cluster_test/psum_22.txt')
save_1D_list_as_hex_to_txt(psum_23, './PE_cluster_test/psum_23.txt')

save_1D_list_as_hex_to_txt(iact_0_addr + iact_3_addr, './PE_cluster_test/iact_0_addr.txt')
save_1D_list_as_hex_to_txt(iact_1_addr + iact_4_addr, './PE_cluster_test/iact_1_addr.txt')
save_1D_list_as_hex_to_txt(iact_2_addr + iact_5_addr, './PE_cluster_test/iact_2_addr.txt')

save_1D_list_as_hex_to_txt(iact_0_data_count + iact_3_data_count, './PE_cluster_test/iact_0_data_count.txt')
save_1D_list_as_hex_to_txt(iact_1_data_count + iact_4_data_count, './PE_cluster_test/iact_1_data_count.txt')
save_1D_list_as_hex_to_txt(iact_2_data_count + iact_5_data_count, './PE_cluster_test/iact_2_data_count.txt')

save_1D_list_as_hex_to_txt(weight_0_addr, './PE_cluster_test/weight_0_addr.txt')
save_1D_list_as_hex_to_txt(weight_1_addr, './PE_cluster_test/weight_1_addr.txt')
save_1D_list_as_hex_to_txt(weight_2_addr, './PE_cluster_test/weight_2_addr.txt')
						 
save_1D_list_as_hex_to_txt(weight_0_data_count, './PE_cluster_test/weight_0_data_count.txt')
save_1D_list_as_hex_to_txt(weight_1_data_count, './PE_cluster_test/weight_1_data_count.txt')
save_1D_list_as_hex_to_txt(weight_2_data_count, './PE_cluster_test/weight_2_data_count.txt')

save_1D_list_as_hex_to_txt(psum_0_out, './PE_cluster_test/psum_0_out.txt')
save_1D_list_as_hex_to_txt(psum_1_out, './PE_cluster_test/psum_1_out.txt')
save_1D_list_as_hex_to_txt(psum_2_out, './PE_cluster_test/psum_2_out.txt')
save_1D_list_as_hex_to_txt(psum_3_out, './PE_cluster_test/psum_3_out.txt')
'''







