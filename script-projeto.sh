#!/bin/bash

echo "Atualizando o servidor..."

sudo apt-get update -y
sudo apt-get upgrade -y

echo "Configurando o repositório docker..."

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

echo "Instalando o docker..."

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo "Instalando o NGINX"

sudo apt install nginx -y

echo "Iniciando e habilitando o serviço NGINX"

sudo systemctl enable --now nginx 

echo "Adicionando docker ao grupo de usuário root..."

useradd -a -G docker marsauxo

