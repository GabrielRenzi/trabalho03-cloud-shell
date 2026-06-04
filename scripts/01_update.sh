#!/bin/bash

# Script: 01_update.sh
# Descrição: Atualização de pacotes do sistema para o ambiente VPC-Streaming-Edu

LOG_FILE="/app/logs/streaming_system_update.log"

atualizar_sistema() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando atualização do ecossistema de streaming..." | tee -a "$LOG_FILE"
    
    # Aqui ele força o apt-get a aceitar o modo não interativo e as escolhas padrão
    export DEBIAN_FRONTEND=noninteractive
    
    # Atualiza a lista de repositórios
    apt-get update -y >> "$LOG_FILE" 2>&1
    
    # Executa o comando do upgrade e força o sim, aplicando a opção de manter as configs antigas sem perguntar nada
    apt-get upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" >> "$LOG_FILE" 2>&1
    
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m[SUCESSO] Sistema operacional atualizado com êxito!\033[0m" | tee -a "$LOG_FILE"
        return 0
    else
        echo -e "\033[0;31m[FALHA] Ocorreu um erro crítico na atualização dos pacotes. Verifique o arquivo /app/logs/streaming_system_update.log\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi
}

mkdir -p /app/logs
atualizar_sistema