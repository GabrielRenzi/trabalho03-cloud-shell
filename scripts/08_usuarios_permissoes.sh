#!/bin/bash
# -------------------------------------------------------------------------
# Script: 08_usuarios_permissoes.sh
# Descrição: Criação de usuário operacional e isolamento de privilégios de mídia
# -------------------------------------------------------------------------

LOG_FILE="/app/logs/streaming_permissoes.log"
USUARIO_TEMATICO="admin_stream"
DIR_DADOS="/app/vpc_streaming_edu"

configurar_seguranca() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando auditoria de acessos e permissões..." | tee -a "$LOG_FILE"
    
    # Criação do usuário temático se não existir
    if id "$USUARIO_TEMATICO" >/dev/null 2>&1; then
        echo "Usuário '${USUARIO_TEMATICO}' já mapeado no Linux." >> "$LOG_FILE"
    else
        echo "Registrando novo operador de streaming (${USUARIO_TEMATICO})..." >> "$LOG_FILE"
        useradd -m -s /bin/bash "$USUARIO_TEMATICO" >> "$LOG_FILE" 2>&1
    fi
    
    # Garante que a pasta de mídia existe antes de aplicar as permissões
    if [ -d "$DIR_DADOS" ]; then
        echo "Aplicando política de segurança Chmod 755 e Chown em ${DIR_DADOS}..." >> "$LOG_FILE"
        
        # Define o dono e o grupo do diretório
        chown -R "${USUARIO_TEMATICO}:${USUARIO_TEMATICO}" "$DIR_DADOS" >> "$LOG_FILE" 2>&1
        
        # Garante leitura/escrita pro dono, leitura/execução para os demais
        chmod -R 755 "$DIR_DADOS" >> "$LOG_FILE" 2>&1
        
        echo -e "\033[0;32m[SUCESSO] Permissões aplicadas e amarradas ao usuário ${USUARIO_TEMATICO}!\033[0m" | tee -a "$LOG_FILE"
    else
        echo -e "\033[0;31m[FALHA] Diretório de dados ${DIR_DADOS} não foi localizado para alteração.\033[0m" | tee -a "$LOG_FILE"
    fi
}

mkdir -p /app/logs
configurar_seguranca