FROM ubuntu:latest

# Install required packages
RUN apt update && apt install -y sudo \
  wget \
  gnupg

# Create a new user
# RUN useradd -m -s /bin/bash chirpstack

# Set the password for the new user
# RUN echo 'chirpstack:chirpstack' | chpasswd

# Switch to the new user
# USER chirpstack

# Set the working directory
# WORKDIR /home/chirpstack
WORKDIR ~

RUN apt update && apt install -y  \
  vim \
  git


# Clonamos el repositorio
RUN git clone https://github.com/RodrigoNazar/RAK_ChirpStack_Docker.git

# Se agregan elementos al path y aliases
RUN echo 'PATH=$PATH:/usr/lib/postgresql/14/bin' >> ~/.bashrc
RUN echo 'alias chirpstack-network-server=/etc/init.d/chirpstack-network-server' >> ~/.bashrc
RUN echo 'alias chirpstack-application-server=/etc/init.d/chirpstack-application-server' >> ~/.bashrc
RUN echo 'alias chirpstack-gateway-bridge=/etc/init.d/chirpstack-gateway-bridge' >> ~/.bashrc

RUN chmod +x RAK_ChirpStack_Docker/ubuntu_install.sh
RUN sudo RAK_ChirpStack_Docker/ubuntu_install.sh

# # Install ChirpStack Gateway Bridge
# RUN wget -qO - https://artifacts.chirpstack.io/packages/3.x/deb/public.key | apt-key add -
# RUN echo "deb https://artifacts.chirpstack.io/packages/3.x/deb stable main" | tee /etc/apt/sources.list.d/chirpstack.list
# RUN apt-get update && apt-get install -y chirpstack-gateway-bridge

# # Install ChirpStack Network Server
# RUN wget -qO - https://artifacts.chirpstack.io/packages/3.x/deb/public.key | apt-key add -
# RUN echo "deb https://artifacts.chirpstack.io/packages/3.x/deb stable main" | tee /etc/apt/sources.list.d/chirpstack.list
# RUN apt-get update && apt-get install -y chirpstack-network-server

# # Copy configuration files
# COPY gateway-bridge.toml /etc/chirpstack-gateway-bridge/chirpstack-gateway-bridge.toml
# COPY network-server.toml /etc/chirpstack-network-server/chirpstack-network-server.toml

# # Expose ports
# EXPOSE 1700/udp
# EXPOSE 8000/tcp

# # Run the applications
# CMD ["chirpstack-gateway-bridge", "--config", "/etc/chirpstack-gateway-bridge/chirpstack-gateway-bridge.toml"]
# CMD ["chirpstack-network-server", "--config", "/etc/chirpstack-network-server/chirpstack-network-server.toml"]
