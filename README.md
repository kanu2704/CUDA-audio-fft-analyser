#  CUDA Audio FFT Analyzer

This project implements a **Fast Fourier Transform (FFT)** pipeline using **NVIDIA CUDA** to accelerate frequency analysis of audio signals.  
It processes audio data, performs FFT computations on the GPU, and outputs frequency-domain results for further analysis or visualization.

---

##  Features

- GPU-accelerated FFT computation using **cuFFT**
- Automatic input data generation (sine waves, mixed signals, etc.)
- Modular design (`main.cpp`, `kernel.cu`, `kernel.h`)
- Organized output with frequency spectra saved to `output_data/`
- Portable build using `Makefile`
- Simple one-command execution via `run_analysis.sh`

---

##  Project Structure

cuda-audio-fft-analyzer
├── main.cpp # Entry point, loads data and calls CUDA FFT wrapper
├── kernel.cu # CUDA implementation of FFT logic
├── kernel.h # Header declaring CUDA interface
├── generate_audio.py # Generates synthetic audio samples
├── Makefile # Handles compilation and linking
├── run_analysis.sh # Automates build, data generation, and execution
├── input_data/ # Contains generated audio input files
└── output_data/ # Stores FFT output files


---

## Requirements

### Software
- **CUDA Toolkit** ≥ 11.0  
- **g++ / nvcc compiler**
- **Python 3.8+**
- **Python packages:** `numpy`, `scipy`

### Hardware
- NVIDIA GPU with CUDA Compute Capability ≥ 3.0

---

## Setup and Execution

### 1. Clone the Repository
##bash
git clone https://github.com/Yatin23614/gpu-audio-fft-analyzer.git
cd cuda-audio-fft-analyzer

2. Make the Script Executable
chmod +x run_analysis.sh

3. Run the Analysis
./run_analysis.sh

## This script:

Cleans and builds the project.

Generates synthetic audio input data (if missing).

Executes the GPU-based FFT analyzer.

Outputs frequency-domain results to the output_data/ folder.

## Output Details

Each output file (e.g., fft_output.txt) contains the frequency magnitude spectrum of the processed audio signal.

You can visualize the data using Python or MATLAB:

import numpy as np
import matplotlib.pyplot as plt

data = np.loadtxt("output_data/fft_output.txt")
plt.plot(data)
plt.title("FFT Magnitude Spectrum")
plt.xlabel("Frequency Bin")
plt.ylabel("Magnitude")
plt.show()

## Key Concepts

FFT (Fast Fourier Transform): Converts a time-domain signal into its frequency components.

CUDA (Compute Unified Device Architecture): Enables parallel computation on NVIDIA GPUs.

cuFFT: NVIDIA’s high-performance FFT library.

## File Descriptions
File	Description
main.cpp	Handles audio input and calls the GPU FFT function.
kernel.cu	Implements CUDA-based FFT using cuFFT APIs.
kernel.h	Declares the CUDA FFT wrapper function.
generate_audio.py	Produces sample .wav or raw audio data.
Makefile	Compiles all CUDA and C++ components.
run_analysis.sh	Automates build, data generation, and execution.

## Example

Example output plot for a generated sine wave (1 kHz):

Input Signal: 1 kHz Sine Wave
FFT Peak Detected at: ~1000 Hz

##  Troubleshooting
Issue	Possible Fix
nvcc: command not found	Ensure CUDA Toolkit is installed and nvcc is in PATH.
cufft.h: No such file or directory	Verify CUDA Toolkit include path.
Segmentation fault (core dumped)	Check array sizes and GPU memory limits.
Permission denied on .sh script	Run chmod +x run_analysis.sh.

## Author

Yatin Singh
B.Tech, IIIT Delhi
 Contact: yatin23614@iiitd.ac.in]
 GitHub: Yatin23614

## License

MIT License (educational / academic use)

