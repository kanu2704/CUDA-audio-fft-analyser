// kernel.cu
#include <iostream>
#include <fstream>
#include <vector>
#include <cufft.h>
#include "kernel.h"

void perform_fft_on_gpu(double* audio_data, int num_samples, const char* output_filename) {
    // Step 1: Allocate device memory for complex audio samples
    cufftDoubleComplex* d_signal = nullptr;
    cudaMalloc(reinterpret_cast<void**>(&d_signal), sizeof(cufftDoubleComplex) * num_samples);

    // Step 2: Transfer input samples from host to device
    // Note: Assuming input is real; thus directly casting to complex type.
    cudaMemcpy(d_signal, audio_data, sizeof(cufftDoubleComplex) * num_samples, cudaMemcpyHostToDevice);

    // Step 3: Create a 1D FFT plan
    cufftHandle fft_plan;
    cufftPlan1d(&fft_plan, num_samples, CUFFT_Z2Z, 1); // Complex-to-Complex FFT

    // Step 4: Perform the forward FFT on the GPU
    cufftExecZ2Z(fft_plan, d_signal, d_signal, CUFFT_FORWARD);

    // Step 5: Retrieve FFT output back to the host
    std::vector<cufftDoubleComplex> h_result(num_samples);
    cudaMemcpy(h_result.data(), d_signal, sizeof(cufftDoubleComplex) * num_samples, cudaMemcpyDeviceToHost);

    // Step 6: Write the magnitude of FFT results to an output CSV
    std::ofstream out_file(output_filename);
    for (int i = 0; i < num_samples; ++i) {
        double mag = sqrt(h_result[i].x * h_result[i].x + h_result[i].y * h_result[i].y);
        out_file << mag << '\n';
    }
    out_file.close();

    // Step 7: Free GPU resources and destroy FFT plan
    cufftDestroy(fft_plan);
    cudaFree(d_signal);
}
