#!/bin/bash

#user create
# precisando rodar com root
# lendo o sudo
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi


read -p "Enter writing an username: " $USERNAME
read -p "Enter writing a full username: " $FULL_USERNAME
read -s -p "Enter writing a good password (recommend 6 carachters): " $PASSWRD
echo

useradd -m -c "$FULL_USERNAME" -s /bin/bash "$USERNAME"

echo "$USERNAME:$PASSWRD" | chpasswd


echo "Usuário $USERNAME criado com sucesso."
