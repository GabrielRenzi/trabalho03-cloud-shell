#!/bin/bash
# 06_processos.sh - Gerenciamento de Processos (Defesa)

LOG_FILE="/app/logs/processos_execucao.log"

mkdir -p /app/logs

listar_processos() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Função listar_processos executada." >> "$LOG_FILE"
    echo "=== Listando os 10 processos que mais consomem CPU ==="
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 10
}

buscar_processo() {
    local termo="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Função buscar_processo executada. Buscando por: $termo" >> "$LOG_FILE"
    echo "=== Resultado da busca por '$termo' ==="
    ps aux | grep -i "$termo" | grep -v "grep"
}

matar_processo() {
    local pid="$1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: Função matar_processo executada. Alvo PID: $pid" >> "$LOG_FILE"
    if kill -9 "$pid" > /dev/null 2>&1; then
        echo "Processo $pid encerrado com sucesso."
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] SUCESSO: Processo $pid morto." >> "$LOG_FILE"
    else
        echo "Falha ao matar o processo $pid (Permissão negada ou PID inexistente)."
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERRO: Falha ao matar processo $pid." >> "$LOG_FILE"
    fi
}

echo "======================================"
echo " GERENCIADOR DE PROCESSOS - STREAMING"
echo "======================================"
echo "1) Listar processos ativos"
echo "2) Buscar um processo pelo nome"
echo "3) Matar processo via PID"
echo "4) Voltar ao menu principal"
read -p "Escolha uma opção: " opcao

case $opcao in
    1) listar_processos ;;
    2) read -p "Digite o nome do processo: " nome_proc; buscar_processo "$nome_proc" ;;
    3) read -p "Digite o PID do processo a encerrar: " pid_proc; matar_processo "$pid_proc" ;;
    4) exit 0 ;;
    *) echo "Opção inválida." ;;
esac