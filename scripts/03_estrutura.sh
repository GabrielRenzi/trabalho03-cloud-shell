#!/bin/bash
# -------------------------------------------------------------------------
# Script: 03_estrutura.sh
# Descrição: Criação do esqueleto de diretórios customizado para Streaming de Vídeo
# -------------------------------------------------------------------------

LOG_FILE="/app/logs/streaming_estrutura.log"
BASE_DIR="/app/vpc_streaming_edu"

gerenciar_estrutura() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Configurando diretórios da aplicação..." | tee -a "$LOG_FILE"
    
    # Remoção segura de estruturas legadas se existirem
    if [ -d "$BASE_DIR" ]; then
        echo "Limpando versões antigas do diretório do app..." >> "$LOG_FILE"
        rm -rf "$BASE_DIR"
    fi
    
    # Criação das subpastas temáticas (Aulas gravadas, transmissões, e logs de streaming)
    mkdir -p "$BASE_DIR/video_aulas"
    mkdir -p "$BASE_DIR/lives_gravadas"
    mkdir -p "$BASE_DIR/metadados_cursos"
    mkdir -p "$BASE_DIR/logs_transmissao"
    mkdir -p "/app/backups"
    mkdir -p "/app/evidencias"
    
    # Criação de um arquivo indicador inicial
    echo "VPC-Streaming-Edu Cluster Ativo" > "$BASE_DIR/status.txt"
    
    if [ -d "$BASE_DIR/video_aulas" ]; then
        echo -e "\033[0;32m[SUCESSO] Estrutura de pastas para streaming criada com sucesso em $BASE_DIR!\033[0m" | tee -a "$LOG_FILE"
        ls -l "$BASE_DIR" >> "$LOG_FILE"
    else
        echo -e "\033[0;31m[ERRO] Falha ao criar os diretórios de mídia.\033[0m" | tee -a "$LOG_FILE"
    fi
}

mkdir -p /app/logs
gerenciar_estrutura