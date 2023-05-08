
Este repositorio viene del Fork del repositorio de RAK:

[RAKWireless/ChirpStack_on_Ubuntu](https://github.com/RAKWireless/ChirpStack_on_Ubuntu)


# Crear un nuevo Contenedor de Ubuntu en Docker 

```
docker run --name "ubuntu.chirpstack" -it ubuntu
docker start -i ubuntu.chirpstack
```

# Scripts Base para Configurar el Cuevo Contenedor

```
# Instalacion de dependencias
apt update
apt install sudo

# Crea el nuevo usuario
sudo adduser chirpstack
echo 'chirpstack ALL=(ALL:ALL) ALL' >> /etc/sudoers

su - chirpstack

# Instalacion de paquetes utiles
sudo apt install -y vim git

# Clonamos el repositorio
git clone https://github.com/RodrigoNazar/RAK_ChirpStack_Docker.git

cd RAK_ChirpStack_Docker/
```

Después de correr todos estos script, basta ejecutar:

```
sudo ./setup.sh

```


# Instalar directamente

sudo apt install git  
git clone https://github.com/RAKWireless/ChirpStack_on_Ubuntu  
cd ChirpStack_on_Ubuntu  
sudo ./install.sh


