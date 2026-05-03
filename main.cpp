// main.cpp
#include <iostream>
#include <filesystem>
#include <vector>
#include <sndfile.h>
#include "kernel.h"  // Declaration of GPU FFT routine

namespace fs = std::filesystem;

int main() {
    const std::string input_folder = "input_data";
    const std::string output_folder = "output_data";

    // Create output directory if it doesn't exist
    fs::create_directory(output_folder);

    // Iterate through all .wav files in the input directory
    for (const auto& file_entry : fs::directory_iterator(input_folder)) {
        if (file_entry.path().extension() == ".wav") {
            std::cout << "Reading file: " << file_entry.path().filename() << std::endl;

            // --- Read WAV file using libsndfile ---
            SF_INFO file_info{};
            SNDFILE* input_file = sf_open(file_entry.path().string().c_str(), SFM_READ, &file_info);
            if (!input_file) {
                std::cerr << "Failed to open " << file_entry.path().filename() << std::endl;
                continue;
            }

            std::vector<double> audio_data(file_info.frames);
            sf_read_double(input_file, audio_data.data(), file_info.frames);
            sf_close(input_file);

            // --- Construct output filename ---
            std::string output_file = output_folder + "/fft_" + file_entry.path().stem().string() + ".csv";

            // --- Execute GPU FFT ---
            perform_fft_on_gpu(audio_data.data(), file_info.frames, output_file.c_str());
        }
    }

    std::cout << "\n✅ All audio files processed successfully." << std::endl;
    return 0;
}
