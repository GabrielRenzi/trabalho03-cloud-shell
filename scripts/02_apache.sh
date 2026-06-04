#!/bin/bash

# Script: 02_apache.sh
# Descrição: Instalação do servidor web Apache e pacotes de codec de vídeo (FFmpeg)

LOG_FILE="/app/logs/streaming_apache_install.log"

instalar_apache() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Ativando repositórios estendidos (Non-Interactive)..." | tee -a "$LOG_FILE"
    
    # Força o apt e o add-apt-repository a rodar sem travar pedindo alguma confirmação
    export DEBIAN_FRONTEND=noninteractive
    
    apt-get update -y >> "$LOG_FILE" 2>&1
    apt-get install -y software-properties-common >> "$LOG_FILE" 2>&1
    
    # O parâmetro -y aqui, junto com a variável acima, garante a automação limpa
    add-apt-repository universe -y >> "$LOG_FILE" 2>&1
    add-apt-repository multiverse -y >> "$LOG_FILE" 2>&1
    
    apt-get update -y >> "$LOG_FILE" 2>&1

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Instalando infraestrutura web e codecs multimídia..." | tee -a "$LOG_FILE"
    apt-get install -y apache2 ffmpeg >> "$LOG_FILE" 2>&1
}

verificar_apache() {
    if command -v apache2 >/dev/null 2>&1; then
        echo -e "\033[0;32m[OK] Servidor Apache2 está devidamente instalado.\033[0m" | tee -a "$LOG_FILE"
        return 0
    else
        echo -e "\033[0;31m[ALERTA] Apache2 não foi encontrado no sistema.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi
}

versao_apache() {
    echo "--------------------------------------------------"
    echo "Evidência de Versões Instaladas:"
    apache2 -v | head -n 1
    
    if command -v ffmpeg >/dev/null 2>&1; then
        ffmpeg -version | head -n 1
    else
        echo "[ALERTA] FFmpeg não respondeu ao comando de versão."
    fi
    echo "--------------------------------------------------"
}

mkdir -p /app/logs
instalar_apache
verificar_apache

if [ $? -eq 0 ]; then
    versao_apache
fi