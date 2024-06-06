# Flexible and Energy-Efficient Accelerator for Sparse Convolution Neural Networks

This project is the first-place winner of the undergraduate project competition at NCHU EE. It features a design that modifies the Eyeriss v2 architecture to create a flexible and energy-efficient accelerator for Sparse Convolutional Neural Networks. Significant improvements include modifying the operational mode of Processing Elements (PEs) to use `im2col` and `GEMM`, overhauling the router logic, and introducing a novel data flow that combines weight stationary, input stationary, and output stationary paradigms.

## Project Implementation

The project is divided into two main implementations:

- **FPGA Implementation**: Includes all source code, FPGA synthesis Bitstream files, and related resources.
- **ASIC Implementation**: Contains designs and specifications for ASIC realization.

## Repository Contents

- **Verilog Code**: Circuit design files used for both FPGA and ASIC implementations.
- **Python Code**: Scripts for generating test data.
- **Bitstream Files**: Compiled files for FPGA deployment.
- **Research Paper and Reports**: Comprehensive documentation detailing the research, design, and outcomes of the project.
- **Demo Video Link**: [Watch the project demo here](#https://www.youtube.com/watch?v=wLz8Di9vdas&ab_channel=BOCHUNChen)
