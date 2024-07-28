# Flexible and Energy-Efficient Accelerator for Sparse Convolution Neural Networks

This project is the first-place winner of the undergraduate project competition at NCHU EE. It features a design that modifies the Eyeriss v2 architecture to create a flexible and energy-efficient accelerator for Sparse Convolutional Neural Networks. Significant improvements include modifying the operational mode of Processing Elements (PEs) to use `im2col` and `GEMM`, overhauling the router logic, and introducing a novel data flow that combines weight stationary, input stationary, and output stationary paradigms.

## Project Abstract
Deep Neural Networks (DNN) have proven their exceptional performance in various domains, especially in tasks like image classification and recognition. However, the high computational demands, power consumption, and memory requirements of DNNs underscore the need for specialized hardware accelerators. This project introduces a hardware accelerator architecture based on the Eyeriss v2 framework, specifically tailored for Sparse Convolutional Neural Networks (SCNN). By incorporating the im2col and GEMM data restructuring schemes and a systolic array design, we optimized data flow and enhanced the flexibility of the hardware architecture. Using the OpenROAD tool, we implemented the complete design-to-GDSII process and achieved high-performance inference capabilities on the NanGate 45nm CMOS process.

## Contributions
- **Improved Eyeriss v2 Architecture:** Innovatively improved upon the existing framework to enhance data reuse and reduce power consumption.
- **Optimized Data Flow Design:** Through the integration of CSC compression with the Im2col+GEMM approach, optimized data transmission and storage strategies significantly reduce memory footprint and enhance computational efficiency.
- **Systolic Array Design in NoC:** Introduced a systolic array at the network level, solving traditional design issues with combinational loops, ensuring high efficiency and stability in data transmission.

## Experimental Results
Implemented the ASIC design on a 45nm CMOS technology and validated on FPGA platforms. The hardware accelerator demonstrated outstanding computational speed and energy efficiency, particularly notable when running the MobileNet model, achieving 1559.7 inferences per second.

## Conclusion
This project successfully implemented a highly efficient and flexible hardware accelerator suitable for sparse convolutional neural networks. Future work will explore broader applications of deep learning models and further optimize the accelerator design to accommodate varying computational demands.

## References
- Chen, Y.-H., Emer, J., & Sze, V. (2019). Eyeriss v2: A Flexible Accelerator for Emerging Deep Neural Networks on Mobile Devices. IEEE Journal on Emerging and Selected Topics in Circuits and Systems, 9(2), 292-308.
- Additional references can be found in the references section of this report.


## Repository Contents

- **Verilog Code**: Circuit design files used for both FPGA and ASIC implementations.
- **Python Code**: Scripts for generating test data.
- **Bitstream Files**: Compiled files for FPGA deployment.
- **Research Paper and Reports**: Comprehensive documentation detailing the research, design, and outcomes of the project.
- **Demo Video Link**: [Watch the project demo here](https://www.youtube.com/watch?v=wLz8Di9vdas&ab_channel=BOCHUNChen)
