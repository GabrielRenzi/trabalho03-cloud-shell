#!/bin/bash

# Script: 07_monitoramento.sh
# Descrição: Coleta de métricas de hardware da infraestrutura de vídeo

LOG_FILE="/app/logs/streaming_monitoramento.log"
EVIDENCIA_DIR="/app/evidencias"
EVIDENCIA_FILE="${EVIDENCIA_DIR}/status_hardware.txt"

coletar_metricas() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Executando varredura de hardware..." | tee -a "$LOG_FILE"
    
    mkdir -p "$EVIDENCIA_DIR"
    
    {
        echo "=================================================="
        echo "   MÉTRICAS DE HARDWARE - VPC-STREAMING-EDU"
        echo "   Gerado em: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "=================================================="
        echo ""
        echo "--- Armazenamento de Vídeos (Uso do Disco) ---"
        df -h /app
        echo ""
        echo "--- Consumo de Memória RAM ---"
        free -m
        echo ""
        echo "--- Top Processos Consumidores ---"
        ps aux --sort=-%cpu | head -n 5
        echo "=================================================="
    } > "$EVIDENCIA_FILE"
    
    if [ -f "$EVIDENCIA_FILE" ]; then
        echo -e "\033[0;32m[SUCESSO] Métricas de consumo gravadas em: ${EVIDENCIA_FILE}\033[0m" | tee -a "$LOG_FILE"
    else
        echo -e "\033[0;31m[ERRO] Não foi possível gerar o arquivo de métricas.\033[0m" | tee -a "$LOG_FILE"
    fi
}

mkdir -p /app/logs
coletar_metricas