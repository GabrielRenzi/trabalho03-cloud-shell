#!/bin/bash

# Script: 06_processos.sh
# Descrição: Monitoramento de processos e gerenciamento nativo do Apache2 no Docker

LOG_FILE="/app/logs/streaming_processos.log"

verificar_e_restaurar_servicos() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Verificando integridade dos daemons de streaming..." | tee -a "$LOG_FILE"
    
    # Verifica se o processo do apache2 está rodando
    if pgrep apache2 > /dev/null; then
        echo -e "\033[0;32m[ATIVO] O servidor Apache2 está operando normalmente.\033[0m" | tee -a "$LOG_FILE"
    else
        echo -e "\033[0;33m[AVISO] Apache2 fora do ar! Startando binário nativo de streaming...\033[0m" | tee -a "$LOG_FILE"
        
        # Correção para Docker: Inicia usando as variáveis de ambiente corretas e o controle direto
        . /etc/apache2/envvars
        apachectl start >> "$LOG_FILE" 2>&1
        
        sleep 1
        
        if pgrep apache2 > /dev/null; then
            echo -e "\033[0;32m[SUCESSO] Apache2 iniciado e operacional em background!\033[0m" | tee -a "$LOG_FILE"
        else
            echo -e "\033[0;31m[ERRO CRÍTICO] Falha ao tentar levantar o Apache2 via apachectl.\033[0m" | tee -a "$LOG_FILE"
            return 1
        fi
    fi
}

mkdir -p /app/logs
verificar_e_restaurar_servicos