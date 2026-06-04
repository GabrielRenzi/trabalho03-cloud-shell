#!/bin/bash

# Script: menu.sh
# Descrição: Painel de Controle Central - Plataforma VPC-Streaming-Edu

# Função para exibir o cabeçalho personalizado do tema
exibir_cabecalho() {
    clear
    echo "=========================================================="
    echo "       PAINEL DE AUTOMAÇÃO - VPC-STREAMING-EDU            "
    echo "   Ambiente Operacional e Administração de Vídeo-Aulas    "
    echo "=========================================================="
    echo " Operador Atual: $(whoami) | Data: $(date '+%Y-%m-%d')"
    echo "=========================================================="
}

while true; do
    exibir_cabecalho
    echo " [1] Atualizar Sistema (01_update.sh)"
    echo " [2] Instalar Web Apache & FFmpeg (02_apache.sh)"
    echo " [3] Estruturar Pastas de Mídia (03_estrutura.sh)"
    echo " [4] Executar Backup do Acervo (04_backup.sh)"
    echo " [5] Realizar Deploy do Portal (05_deploy.sh)"
    echo " [6] Verificar Processos/Serviços (06_processos.sh)"
    echo " [7] Coletar Métricas de Hardware (07_monitoramento.sh)"
    echo " [8] Aplicar Permissões e Segurança (08_usuarios_permissoes.sh)"
    echo " [9] Gerar Relatório Consolidado (09_relatorio.sh)"
    echo " [0] Sair do Painel"
    echo "=========================================================="
    echo -n "Selecione uma opção operacional: "
    read -r opcao

    case $opcao in
        1) echo "Executando..."; ./01_update.sh ;;
        2) echo "Executando..."; ./02_apache.sh ;;
        3) echo "Executando..."; ./03_estrutura.sh ;;
        4) echo "Executando..."; ./04_backup.sh ;;
        5) echo "Executando..."; ./05_deploy.sh ;;
        6) echo "Executando..."; ./06_processos.sh ;;
        7) echo "Executando..."; ./07_monitoramento.sh ;;
        8) echo "Executando..."; ./08_usuarios_permissoes.sh ;;
        9) echo "Executando..."; ./09_relatorio.sh ;;
        0) 
            echo -e "\n\033[0;32mSessão encerrada no VPC-Streaming-Edu. Até logo!\033[0m"
            exit 0 
            ;;
        *) 
            echo -e "\n\033[0;31mOpção Inválida! Escolha um número de 0 a 9.\033[0m"
            ;;
    esac
    echo -e "\nPressione [ENTER] para regressar ao menu principal..."
    read -r
done