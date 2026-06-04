FROM ubuntu:22.04

# Evita prompts interativos durante a instalação de pacotes
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza e instala utilitários básicos necessários para o ambiente
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    systemctl \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Comando padrão para manter o container vivo e permitir acesso interativo
CMD ["bash"]+,