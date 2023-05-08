
Este repositorio viene del Fork del repositorio de RAK:

[RAKWireless/ChirpStack_on_Ubuntu](https://github.com/RAKWireless/ChirpStack_on_Ubuntu)


# Crear un nuevo Contenedor de Ubuntu en Docker 

```

docker run -it ubuntu
docker rename <container-id> "ubuntu.chirpstack"
docker start -i ubuntu.chirpstack

```

# Scripts Base para Configurar el Cuevo Contenedor


```

# Instalacion de dependencias
apt update
apt install sudo

sudo apt install vim
sudo apt install git


# Crea el nuevo usuario
sudo adduser chirpstack
su - chirpstack


# Agrega elementos nuevos al PATH y alias
echo 'PATH=$PATH:/usr/lib/postgresql/14/bin'; >> ~/.bashrc
echo 'alias chirpstack-network-server=/etc/init.d/chirpstack-network-server'; >> ~/.bashrc
echo 'alias chirpstack-application-server=/etc/init.d/chirpstack-application-server'; >> ~/.bashrc
echo 'alias chirpstack-gateway-bridge=/etc/init.d/chirpstack-gateway-bridge'; >> ~/.bashrc

source ~/.bashrc

```


# Instalar directamente

sudo apt install git  
git clone https://github.com/RAKWireless/ChirpStack_on_Ubuntu  
cd ChirpStack_on_Ubuntu  
sudo ./install.sh


