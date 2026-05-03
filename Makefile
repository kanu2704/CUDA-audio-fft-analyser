# Makefile — CUDA-Based Audio Spectrum Analyzer (Linux)

# === Compiler Definitions ===
CXX       = g++
NVCC      = nvcc

# === Executable Name ===
TARGET    = audio_analyzer

# === Compiler Options ===
CXXFLAGS  = -std=c++17
NVCCFLAGS = -std=c++17

# === Libraries for Linking ===
# Links libsndfile (for WAV I/O) and cuFFT (for GPU FFT operations)
LIBS      = -lsndfile -lcufft

# === Build Rules ===
all: $(TARGET)

# Link object files to create the final binary
$(TARGET): main.o kernel.o
	$(NVCC) $(NVCCFLAGS) main.o kernel.o -o $(TARGET) $(LIBS)

# Compile C++ source file
main.o: main.cpp kernel.h
	$(CXX) $(CXXFLAGS) -c main.cpp -o main.o

# Compile CUDA source file
kernel.o: kernel.cu kernel.h
	$(NVCC) $(NVCCFLAGS) -c kernel.cu -o kernel.o

# === Clean Rule ===
# Removes all generated object files, executable, and output CSVs
clean:
	rm -f *.o $(TARGET) output_data/*.csv
