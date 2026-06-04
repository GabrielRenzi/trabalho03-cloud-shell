#!/bin/bash
# -------------------------------------------------------------------------
# Script: 04_backup.sh
# Descrição: Compactação e backup seguro do acervo de vídeo-aulas (VPC-Streaming-Edu)
# -------------------------------------------------------------------------

# Definição de variáveis obrigatórias
DIR_ORIGEM="/app/vpc_streaming_edu"
DIR_DESTINO="/app/backups"
LOG_FILE="/app/logs/streaming_backup.log"
DATA_HORA=$(date '+%Y-%m-%d_%H-%M')
NOME_ARQUIVO="backup_streaming_${DATA_HORA}.tar.gz"

realizar_backup() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando rotina de backup dos arquivos de mídia..." | tee -a "$LOG_FILE"
    
    # Valida se o diretório de origem existe e contém dados
    if [ ! -d "$DIR_ORIGEM" ]; then
        echo -e "\033[0;31m[ERRO] Diretório de origem $DIR_ORIGEM não encontrado. Abortando.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi

    # Garante que o diretório de destino existe
    mkdir -p "$DIR_DESTINO"

    # Cria o arquivo compactado .tar.gz silenciando saídas padrão e pegando erros
    tar -czf "${DIR_DESTINO}/${NOME_ARQUIVO}" -C "$(dirname "$DIR_ORIGEM")" "$(basename "$DIR_ORIGEM")" >> "$LOG_FILE" 2>&1

    # Validação pós-execução do backup
    if [ $? -eq 0 ] && [ -f "${DIR_DESTINO}/${NOME_ARQUIVO}" ]; then
        echo -e "\033[0;32m[SUCESSO] Backup gerado com êxito: ${NOME_ARQUIVO}\033[0m" | tee -a "$LOG_FILE"
        echo "Tamanho do arquivo: $(du -sh "${DIR_DESTINO}/${NOME_ARQUIVO}" | cut -f1)" | tee -a "$LOG_FILE"
        return 0
    else
        echo -e "\033[0;31m[FALHA] Não foi possível estruturar o arquivo de backup compactado.\033[0m" | tee -a "$LOG_FILE"
        return 1
    fi
}

mkdir -p /app/logs
realizar_backup