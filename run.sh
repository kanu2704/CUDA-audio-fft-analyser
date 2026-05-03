#!/bin/bash
# run_analyzer.sh — Build and execute the CUDA Audio Spectrum Analyzer

# Stop the script immediately if any command fails
set -e

# === Step 1: Build the project ===
echo "🔧 Compiling project files..."
make clean
make

# === Step 2: Generate test audio data if missing ===
if [ ! -d "input_data" ] || [ -z "$(ls -A input_data 2>/dev/null)" ]; then
    echo "🎵 No input data detected — generating new audio samples..."
    pip install numpy scipy --quiet
    python input_generator.py
else
    echo "✅ Found existing input_data directory — skipping generation."
fi

# === Step 3: Run the CUDA FFT analyzer ===
echo "🚀 Running GPU-based audio analysis..."
./audio_analyzer

# === Step 4: Wrap-up ===
echo "✅ Analysis complete!"
echo "📁 FFT results saved in the 'output_data' folder."
