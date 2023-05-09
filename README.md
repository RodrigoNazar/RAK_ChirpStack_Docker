
Este repositorio viene del Fork del repositorio de RAK:

[RAKWireless/ChirpStack_on_Ubuntu](https://github.com/RAKWireless/ChirpStack_on_Ubuntu)


# Crear un nuevo Contenedor de Ubuntu en Docker 

```
# Hace el armado del dockerfile en una imagen de Docker
docker build -t ubuntu.chirpstack .

# Crea el contenedor a partir de la imagen previamente armada
docker run --name "ubuntu.chirpstack" -it "ubuntu.chirpstack"


# 
docker start -i ubuntu.chirpstack

```

# Scripts Base para Configurar el Cuevo Contenedor

Después de correr todos estos script, basta ejecutar:

```

```


# Instalar directamente

sudo apt install gd  
git clone https://github.com/RAKWireless/ChirpStack_on_Ubuntu  
cd ChirpStack_on_Ubuntu  
sudo ./install.sh


