# Trabalho 03 - Linux, Shell Script e Automação Operacional

## 📋 Informações do Aluno
- **Instituição:** UNIDAVI  
- **Curso:** Sistemas de Informação  
- **Disciplina:** Cloud Computing  
- **Professor:** Esp. Ademar Perfoll Junior  
- **Aluno:** Gabriel Wellington Renzi
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
```
---

## 🧠 Explicação de Cada Script
- **01_update.sh:** Atualiza a lista de pacotes e o sistema operacional (apt-get update e upgrade) de forma totalmente automatizada (modo não-interativo).

- **02_apache.sh:** Instala o servidor web Apache2 e a biblioteca multimídia FFmpeg, essenciais para a plataforma de vídeo.

- **03_estrutura.sh:** Cria toda a árvore customizada de diretórios necessária para o projeto (video_aulas, lives_gravadas, backups, etc).

- **04_backup.sh:** Realiza a compactação (tar -czf) dos arquivos de mídia gerando um arquivo de backup com data e hora.

- **05_deploy.sh:** Transfere (Deploy) os arquivos HTML da pasta source diretamente para a raiz do servidor Apache (/var/www/html).

- **06_processos.sh:** Verifica se o Apache está em execução. Caso tenha caído, ele funciona como "auto-healing" e tenta iniciá-lo novamente nativamente.

- **07_monitoramento.sh:** Coleta métricas vitais de consumo de disco (df), memória (free) e uso de CPU (ps), gerando um laudo em .txt.

- **08_usuarios_permissoes.sh:** Cria o usuário restrito admin_stream e configura permissões rigorosas (chown e chmod 755) para proteger os arquivos de vídeo.

- **09_relatorio.sh:** Vasculha e compila os logs gerados pelos passos anteriores e unifica as informações em um relatório de auditoria final.

- **menu.sh:** Painel interativo (Dashboard textual) que centraliza a execução de todos os outros scripts por meio de opções numéricas.   

## ⚙️ Como Executar o Projeto
```text
git clone https://github.com/GabrielRenzi/trabalho03-cloud-shell.git
cd trabalho03-cloud-shell
docker compose up -d --build
docker ps
docker exec -it trabalho03-streaming-edu bash
cd /app/scripts
chmod +x *.sh
./menu.sh
```

## 🕹️ Como executar o menu principal
```text
cd /app/scripts
chmod +x *.sh
./menu.sh
```

## 🧪 Como executar cada script individualmente
```text
./01_update.sh
./02_apache.sh
./03_estrutura.sh
./04_backup.sh
./05_deploy.sh
./06_processos.sh
./07_monitoramento.sh
./08_usuarios_permissoes.sh
./09_relatorio.sh
```

## 🌐 Como acessar o Apache no navegador
Após executar os scripts de instalação (02_apache.sh) e deploy (05_deploy.sh), o site já estará disponível. Abra o navegador em seu computador e acesse:

http://localhost:8080

## 📸 Evidências de Funcionamento
Os arquivos com os laudos gerados pelo sistema e os backups ficam gravados dentro do container na pasta /app/evidencias (que sincroniza automaticamente com o Windows).
(Nota: Inserir um ou dois prints screen da tela do menu executando e do site aberto no localhost aqui).

## 🐳 Imagem no DockerHub
O ambiente já foi enviado para a nuvem. A imagem Docker deste projeto pode ser baixada e executada diretamente pelo link ou comando abaixo:

Página no DockerHub: https://hub.docker.com/r/gabrielrenzi/trabalho03-streaming-edu

## 🚧 Principais Dificuldades Encontradas
Durante o desenvolvimento aconteceram alguns problemas:

O apt-get upgrade travava o terminal ao pedir confirmações. A solução foi forçar a execução via variáveis de ambiente como DEBIAN_FRONTEND=noninteractive e flags --force-confold.

Quando um script falhava na metade, os arquivos de configuração do Ubuntu corrompiam. Bastou derrubar o container corrompido usando docker compose down -v e recriar o ambiente.

O Apache não iniciava normalmente pela falta do systemd. Foi necessário usar ferramentas nativas como apachectl start e carregar variáveis de ambiente manualmente source /etc/apache2/envvars.

