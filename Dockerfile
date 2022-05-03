FROM debian:latest AS base

COPY .zshrc .zshrctemp

RUN apt-get update && apt-get install -y \
    zsh \
    git \
    curl \
    wget \
    vim \
    nano \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    net-tools \
    make

RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc && \
cat .zshrctemp >> ~/.zshrc && \
rm .zshrctemp

FROM base

ARG NODE_VERSION

# Install libs
RUN apt install -y cowsay

# Install node
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install $NODE_VERSION && \
    npm install -g yarn