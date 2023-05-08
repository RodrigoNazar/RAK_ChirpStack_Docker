# Install utility commands

apt update
apt install sudo

sudo adduser chirpstack
su - chirpstack


sudo apt install vim
sudo apt install git

echo 'PATH=$PATH:/usr/lib/postgresql/14/bin'; >> ~/.bashrc
echo 'alias chirpstack-network-server=/etc/init.d/chirpstack-network-server'; >> ~/.bashrc
echo 'alias chirpstack-application-server=/etc/init.d/chirpstack-application-server'; >> ~/.bashrc
echo 'alias chirpstack-gateway-bridge=/etc/init.d/chirpstack-gateway-bridge'; >> ~/.bashrc
source ~/.bashrc