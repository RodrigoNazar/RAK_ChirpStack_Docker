#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

# script needs to be run with super privilege
if [ $(id -u) -ne 0 ]; then
  printf "Script must be run with superuser privilege. Try 'sudo ./install.sh'\n"
  exit 1
fi

# Se agregan elementos al path y aliases
echo 'PATH=$PATH:/usr/lib/postgresql/14/bin' >> ~/.bashrc
echo 'alias chirpstack-network-server=/etc/init.d/chirpstack-network-server' >> ~/.bashrc
echo 'alias chirpstack-application-server=/etc/init.d/chirpstack-application-server' >> ~/.bashrc
echo 'alias chirpstack-gateway-bridge=/etc/init.d/chirpstack-gateway-bridge' >> ~/.bashrc

cp init_sql.sql /tmp/init_sql.sql -f

# 1. install requirements
apt -f -y install dialog \
  mosquitto \
  mosquitto-clients \
  redis-server \
  redis-tools \
  apt-transport-https \
  dirmngr 

export DEBIAN_FRONTEND=noninteractive apt -f -y install postgresql

# Start the services!
service postgresql restart
/etc/init.d/redis-server restart

# 2. setup PostgreSQL databases and users
sudo -u postgres psql -c "create role chirpstack_as with login password 'dbpassword';"
sudo -u postgres psql -c "create role chirpstack_ns with login password 'dbpassword';"
sudo -u postgres psql -c "create database chirpstack_as with owner chirpstack_as;"
sudo -u postgres psql -c "create database chirpstack_ns with owner chirpstack_ns;"
sudo -u postgres psql chirpstack_as -c "create extension pg_trgm;"
sudo -u postgres psql chirpstack_as -c "create extension hstore;"
sudo -u postgres psql -U postgres -f /tmp/init_sql.sql
rm -f /tmp/init_sql.sql

# 3. install ChirpStack packages
# 3.1 install https requirements
# apt -f -y install apt-transport-https dirmngr
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1CE2AFD36DBCCA00
echo "deb https://artifacts.chirpstack.io/packages/3.x/deb stable main" | sudo tee /etc/apt/sources.list.d/chirpstack.list
apt update

### Chirpstack Network server
apt install chirpstack-network-server
# /etc/init.d/chirpstack-network-server start # Start
# /etc/init.d/chirpstack-network-server restart # Restart
# /etc/init.d/chirpstack-network-server stop # Stop
# sudo tail -f -n 100 /var/log/chirpstack-network-server # Display Logs


### Chirpstack Gateway Bridge
apt install chirpstack-gateway-bridge
# /etc/init.d/chirpstack-gateway-bridge start # Start
# /etc/init.d/chirpstack-gateway-bridge restart # Restart
# /etc/init.d/chirpstack-gateway-bridge stop # Stop
# sudo tail -f -n 100 /var/log/chirpstack-gateway-bridge # Display Logs

### Chirpstack Application Server
apt install chirpstack-application-server
# /etc/init.d/chirpstack-application-server start # Start
# /etc/init.d/chirpstack-application-server restart # Restart
# /etc/init.d/chirpstack-application-server stop # Stop
# sudo tail -f -n 100 /var/log/chirpstack-application-server # Display Logs


# rm *.deb -f
# 3.2 download chirpstack packages
# wget https://artifacts.chirpstack.io/packages/3.x/deb/pool/main/c/chirpstack-application-server/chirpstack-application-server_3.5.1_linux_armv7.deb
# wget https://artifacts.chirpstack.io/packages/3.x/deb/pool/main/c/chirpstack-gateway-bridge/chirpstack-gateway-bridge_3.4.1_linux_armv7.deb
# wget https://artifacts.chirpstack.io/packages/3.x/deb/pool/main/c/chirpstack-network-server/chirpstack-network-server_3.6.0_linux_armv7.deb

# 3.3 install chirpstack packages
# dpkg -i chirpstack-application-server_3.5.1_linux_armv7.deb
# dpkg -i chirpstack-gateway-bridge_3.4.1_linux_armv7.deb
# dpkg -i chirpstack-network-server_3.6.0_linux_armv7.deb

# 4. configure lora
# configure chirpstack Server
# cp -f /etc/chirpstack-network-server/chirpstack-network-server.toml  /etc/chirpstack-network-server/chirpstack-network-server.toml_bak
cp -rf ./chirpstack-network-server_conf/*  /etc/chirpstack-network-server/
chown -R networkserver:networkserver /etc/chirpstack-network-server

# configure chirpstack App Server
# cp -f /etc/chirpstack-application-server/chirpstack-application-server.toml /etc/chirpstack-application-server/chirpstack-application-server.toml_bak
cp -f ./chirpstack-application-server.toml /etc/chirpstack-application-server/chirpstack-application-server.toml
chown -R appserver:appserver /etc/chirpstack-application-server


# start chirpstack-network-server
# systemctl restart chirpstack-network-server
# chirpstack-network-server restart
/etc/init.d/chirpstack-network-server start


# start chirpstack-application-server
# systemctl restart chirpstack-application-server
# chirpstack-application-server restart
/etc/init.d/chirpstack-gateway-bridge start


# start chirpstack-gateway-bridge
# systemctl restart chirpstack-gateway-bridge
# chirpstack-gateway-bridge restart
/etc/init.d/chirpstack-application-server start


# Restart the services!
service postgresql restart
/etc/init.d/redis-server restart
service mosquitto restart

# mkdir /run/mosquitto/