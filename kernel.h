// kernel.h
#ifndef KERNEL_H
#define KERNEL_H

// Function declaration for performing FFT on GPU.
// This serves as an interface between main.cpp and CUDA operations.
void perform_fft_on_gpu(double* audio_data, int num_samples, const char* output_filename);

#endif // KERNEL_H
