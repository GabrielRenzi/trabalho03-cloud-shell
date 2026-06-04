#!/bin/bash
# -------------------------------------------------------------------------
# Script: 06_processos.sh
# Descrição: Monitoramento de processos e gerenciamento do serviço Apache2
# -------------------------------------------------------------------------

LOG_FILE="/app/logs/streaming_processos.log"

verificar_e_restaurar_servicos() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Verificando integridade dos daemons de streaming..." | tee -a "$LOG_FILE"
    
    # Verifica se o apache2 está em execução via pgrep ou ps
    if pgrep apache2 > /dev/null; then
        echo -e "\033[0;32m[ATIVO] O servidor Apache2 está operando normalmente.\033[0m" | tee -a "$LOG_FILE"
    else
        echo -e "\033[0;33m[AVISO] Apache2 fora do ar! Tentando restabelecer o serviço de streaming...\033[0m" | tee -a "$LOG_FILE"
        
        # Como estamos num container simulado, tenta iniciar de forma compatível
        service apache2 start >> "$LOG_FILE" 2>&1
        
        # Re-validação voluntária
        if pgrep apache2 > /dev/null; then
            echo -e "\033[0;32m[SUCESSO] Apache2 reiniciado e operacional!\033[0m" | tee -a "$LOG_FILE"
        else
            echo -e "\033[0;31m[ERRO CRÍTICO] Falha ao tentar levantar o Apache2.\033[0m" | tee -a "$LOG_FILE"
            return 1
        fi
    fi
}

mkdir -p /app/logs
verificar_e_restaurar_servicos