#!/bin/bash

# -------------------------------------------------------------------------
# Script: 01_update.sh
# Descrição: Atualização de pacotes do sistema para o ambiente VPC-Streaming-Edu
# -------------------------------------------------------------------------

# Caminho do arquivo de log centralizado do tema
LOG_FILE="/app/logs/streaming_system_update.log"

# Função obrigatória para atualizar o sistema de pacotes
atualizar_sistema() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando atualização do ecossistema de streaming..." | tee -a "$LOG_FILE"
    
    # Atualiza a lista de repositórios
    apt-get update -y >> "$LOG_FILE" 2>&1
    
    # Executa o upgrade dos pacotes instalados
    apt-get upgrade -y >> "$LOG_FILE" 2>&1
    
    # Valida se o último comando rodou com sucesso ($? igual a 0)
    if [ $? -eq 0 ]; then
        echo -e "\033[0;32m[SUCESSO] Sistema operacional atualizado com êxito!\033[0m" | tee -a "$LOG_FILE"
        return 0
    else
        echo -e "\033[0;31m[FALHA] Ocorreu um erro crítico na atualização dos pacotes.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi
}

# Cria a pasta de logs caso ela ainda não exista antes de rodar a função
mkdir -p /app/logs

# Invoca a função principal
atualizar_sistema