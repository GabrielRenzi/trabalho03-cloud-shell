# Trabalho 03 - Linux, Shell Script e Automação Operacional

## 📋 Informações do Aluno
- **Instituição:** UNIDAVI  
- **Curso:** Sistemas de Informação  
- **Disciplina:** Cloud Computing  
- **Professor:** Esp. Ademar Perfoll Junior  
- **Tema Customizado:** VPC-Streaming-Edu (Infraestrutura de Automação para Plataforma de Streaming Educacional e Vídeo-Aulas)

---

## 🚀 Descrição do Projeto
Este projeto consiste na simulação e automação de um ambiente de servidor Linux baseado em containers (**Docker**). Toda a arquitetura foi desenvolvida sob uma perspectiva temática focada em **Streaming de Vídeos Educacionais**, incluindo a instalação automatizada do servidor Web Apache, codificadores de mídia (**FFmpeg**), políticas de segurança restritas para os arquivos de vídeo, rotinas de backups agendadas e geração de logs operacionais.

---

## 🛠️ Tecnologias Utilizadas
- **Ubuntu Linux (22.04 LTS)** como sistema operativo base do container.
- **Docker & Docker Compose** para isolamento e portabilidade do ecossistema.
- **Shell Script (Bash)** para a automação de rotinas críticas.
- **Apache2** como servidor de entrega de páginas e mídias estáticas.
- **FFmpeg** para manipulação e metadados de transmissões de vídeo.

---

## 📂 Estrutura de Diretórios do Projeto
```text
trabalho03-cloud-shell/
├── Dockerfile
├── docker-compose.yml
├── README.md
├── source/
│   ├── index.html
│   └── sobre.html
└── scripts/
    ├── menu.sh
    ├── 01_update.sh
    ├── 02_apache.sh
    ├── 03_estrutura.sh
    ├── 04_backup.sh
    ├── 05_deploy.sh
    ├── 06_processos.sh
    ├── 07_monitoramento.sh
    ├── 08_usuarios_permissoes.sh
    └── 09_relatorio.sh