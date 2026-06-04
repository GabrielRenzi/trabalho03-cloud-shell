#!/bin/bash
# -------------------------------------------------------------------------
# Script: 05_deploy.sh
# Descrição: Deploy automatizado do portal web da plataforma VPC-Streaming-Edu
# -------------------------------------------------------------------------

DIR_SOURCE="/app/source"
DIR_TARGET="/var/www/html"
LOG_FILE="/app/logs/streaming_deploy.log"

executar_deploy() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando pipeline de deploy de produção..." | tee -a "$LOG_FILE"

    # Valida se a pasta source com os arquivos HTML existe
    if [ ! -d "$DIR_SOURCE" ]; then
        echo -e "\033[0;31m[ERRO] Diretório de origem ($DIR_SOURCE) não existe. Crie a pasta primeiro.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi

    # Limpeza segura do diretório de destino (remover páginas antigas ou index.html padrão)
    echo "Limpando diretório do servidor web ($DIR_TARGET)..." >> "$LOG_FILE"
    rm -rf "${DIR_TARGET:?}/*"

    # Copia os arquivos estáticos para a pasta do Apache
    cp -r "$DIR_SOURCE"/* "$DIR_TARGET/" >> "$LOG_FILE" 2>&1

    # Validação obrigatória da existência do arquivo index.html no destino
    if [ -f "$DIR_TARGET/index.html" ]; then
        echo -e "\033[0;32m[SUCESSO] Deploy realizado com sucesso no Apache!\033[0m" | tee -a "$LOG_FILE"
        echo "Arquivos publicados atualmente:" | tee -a "$LOG_FILE"
        ls -la "$DIR_TARGET" >> "$LOG_FILE"
        return 0
    else
        echo -e "\033[0;31m[FALHA] O deploy falhou. O arquivo index.html não foi encontrado no destino.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi
}

mkdir -p /app/logs
executar_deploy