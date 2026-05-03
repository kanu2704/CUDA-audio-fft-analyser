# input_generator.py
import numpy as np
from scipy.io.wavfile import write
import os
import shutil

# === Configuration ===
# Directory where generated audio samples will be stored
OUTPUT_FOLDER = "input_data"

# Sampling rate in Hz (44.1 kHz = CD quality)
SAMPLE_RATE = 44100

# Duration of each tone in seconds
DURATION = 1.0

# Total number of tones to create
NUM_FILES = 100

# === Setup ===

# If an existing folder is found, delete it for a clean workspace
if os.path.exists(OUTPUT_FOLDER):
    shutil.rmtree(OUTPUT_FOLDER)
    print(f"Old directory removed: {OUTPUT_FOLDER}")

# Create a fresh directory for the new audio files
os.makedirs(OUTPUT_FOLDER)
print(f"New directory created: {OUTPUT_FOLDER}")

# === Generate Audio Files ===
for i in range(NUM_FILES):
    # Assign each tone a unique frequency (starting from 220 Hz)
    freq = 220 * (i + 1)
    
    # Generate the time axis for the waveform
    t = np.linspace(0, DURATION, int(SAMPLE_RATE * DURATION), endpoint=False)
    
    # Define amplitude (half of 16-bit maximum to prevent clipping)
    amp = 0.5 * np.iinfo(np.int16).max
    
    # Create a sine wave of the given frequency
    waveform = amp * np.sin(2 * np.pi * freq * t)
    
    # Build full path for saving the file
    filepath = os.path.join(OUTPUT_FOLDER, f"tone_{i + 1}.wav")
    
    # Write data to a WAV file (convert to 16-bit PCM format)
    write(filepath, SAMPLE_RATE, waveform.astype(np.int16))
    
    print(f"Saved {filepath}  |  Frequency: {freq} Hz")

print("\n✅ Audio generation completed successfully.")
