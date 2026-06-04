#!/bin/bash
# -------------------------------------------------------------------------
# Script: 09_relatorio.sh
# Descrição: Consolidador do status operacional e logs gerados
# -------------------------------------------------------------------------

RELATORIO_OUTPUT="/app/evidencias/relatorio_geral_streaming.txt"

gerar_relatorio_final() {
    echo -e "\033[0;34mCompilando Relatório Operacional Final...\033[0m"
    mkdir -p "/app/evidencias"
    
    {
        echo "=========================================================="
        echo "  RELATÓRIO CONSOLIDADO DE OPERAÇÕES - VPC-STREAMING-EDU"
        echo "  Emissão: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "=========================================================="
        echo ""
        echo "1. VERIFICAÇÃO DE DIRETÓRIOS CRÍTICOS:"
        echo "----------------------------------------------------------"
        [ -d "/app/vpc_streaming_edu" ] && echo "[OK] Pasta de dados de mídia ativa." || echo "[ERRO] Pasta de mídias ausente."
        [ -d "/app/backups" ] && echo "[OK] Repositório de backups disponível." || echo "[ERRO] Repositório de backups ausente."
        echo ""
        echo "2. ARQUIVOS DE BACKUP DISPONÍVEIS:"
        echo "----------------------------------------------------------"
        ls -lh /app/backups/ 2>/dev/null || echo "Nenhum backup encontrado."
        echo ""
        echo "3. ÚLTIMAS 5 ENTRADAS DE ATUALIZAÇÃO DO SISTEMA:"
        echo "----------------------------------------------------------"
        if [ -f "/app/logs/streaming_system_update.log" ]; then
            tail -n 5 "/app/logs/streaming_system_update.log"
        else
            echo "Ainda sem logs de atualização gravados."
        fi
        echo "=========================================================="
    } > "$RELATORIO_OUTPUT"
    
    echo -e "\033[0;32m[CONCLUÍDO] Relatório unificado publicado com sucesso em ${RELATORIO_OUTPUT}!\033[0m"
}

gerar_relatorio_final