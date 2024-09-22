FROM debian:latest

# Install necessary packages: git and ca-certificates
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    cmake \
    gcc \
    g++ \
    libpcap-dev \
    ninja-build \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Homebrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc && \
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Add Homebrew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

RUN brew install pcapplusplus

# Copy project files into the container
COPY . /app
WORKDIR /app

# Compile the C++ sniffer program
RUN g++ -o sniffer sniffer.cpp -lpcap

# Run the sniffer program
CMD ["./sniffer"]