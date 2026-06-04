#!/bin/bash
# -------------------------------------------------------------------------
# Script: 02_apache.sh
# Descrição: Instalação do servidor web Apache e pacotes de codec de vídeo (FFmpeg)
# -------------------------------------------------------------------------

LOG_FILE="/app/logs/streaming_apache_install.log"

instalar_apache() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Instalando infraestrutura web e codecs..." | tee -a "$LOG_FILE"
    
    # Instala o Apache2 e o FFmpeg (obrigatório para o tema de vídeo/streaming)
    apt-get install -y apache2 ffmpeg >> "$LOG_FILE" 2>&1
}

verificar_apache() {
    # Verifica se o binário ou serviço do apache2 existe no sistema
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
    ffmpeg -version | head -n 1
    echo "--------------------------------------------------"
}

# Execução sequencial das funções solicitadas
mkdir -p /app/logs
instalar_apache
verificar_apache

if [ $? -eq 0 ]; then
    versao_apache
fi