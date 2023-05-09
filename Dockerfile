# FROM ubuntu:latest
FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Santiago

# Install required packages
RUN apt update && apt install -y \
  sudo \
  wget \
  gnupg \
  vim \
  git

# Create a new user
# RUN useradd -m -s /bin/bash chirpstack

# Set the password for the new user
# RUN echo 'chirpstack:chirpstack' | chpasswd

# Switch to the new user
# USER chirpstack

# Set the working directory
WORKDIR ~

# Clonamos el repositorio
RUN git clone https://github.com/RodrigoNazar/RAK_ChirpStack_Docker.git

RUN chmod +x RAK_ChirpStack_Docker/install.sh
RUN sudo RAK_ChirpStack_Docker/install.sh

# Expose ports
EXPOSE 1700/udp
EXPOSE 8000/tcp

# # Run the applications
# CMD ["chirpstack-gateway-bridge", "--config", "/etc/chirpstack-gateway-bridge/chirpstack-gateway-bridge.toml"]
# CMD ["chirpstack-network-server", "--config", "/etc/chirpstack-network-server/chirpstack-network-server.toml"]
