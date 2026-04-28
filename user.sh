#!/bin/bash

#user create
# root privilegios - validação 
if [[ $EUID -ne 0 ]]; then
    echo "Script necessário ser executado como root"
    exit 1
fi


read -p "Digite seu usuário  " USERNAME
if id "$USERNAME" &>/dev/null; then
   echo "ERRO - O USUÁRIO $USERNAME já existe no sistema"
   exit 1
fi

read -p "Digite seu nome completo:  " FULL_NAME

read -s -p "Senha - mínimo 8 caracteres " PASSWORD
echo ""

#Validação de senha
if [${#PASSWORD} -lt 8]; then
   echo "ERRO - SENHA MUITO CURTA - USE PELO MENOS 8 CARACTERES"
   exit 1
fi


useradd -m -c "$FULL_NAME" -s /bin/bash "$USERNAME"

if [ $? -eq 0]; then
 echo "$USERNAME:$PASSWORD" | chpasswd
 passwd --expire "$USERNAME"
 # forçar inicializaçãocom senha resetada
 # impede acesso de outros integrante da equipe de TI


 echo "USUÁRIO $USERNAME CRIADO"
 echo "NOTA --- SERÁ NECESSÁRIO A ALTERAÇÃO DE SENHA NO PRIMEIRO ACESSO"   
else
   echo "ERRO FALHA CRÍTICA AO CRIAR O SISTEMA"
   exit 1 
fi



