FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
  libcap-dev \
  build-essential

COPY . /app
WORKDIR /app

RUN g++ -o sniffer sniffer.cpp -lpcap

CMD ["./sniffer"]