######################
# BASE CONFIGURATION #
######################
FROM debian:latest AS base

# install packages
RUN apt-get update && apt-get install -y \
    sudo \
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

# create dev user
ENV USER dev 	
RUN useradd -m -d /home/${USER} ${USER} && \
    chown -R ${USER} /home/${USER} && \
    adduser ${USER} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# RUN useradd -rm -d /home/dev -s /bin/zsh -g root -G sudo -u 1001 dev
USER dev
WORKDIR /home/dev

# install zsh
COPY .zshrc .zshrctemp
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
RUN echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc && \
    echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc && \
    cat .zshrctemp >> ~/.zshrc && \
    rm .zshrctemp

# setup code templates
COPY templates .templates
RUN sudo find .templates -type f -regex '.*\.\(py\|sh\|bash\)$' -exec chmod +x {} +

########################
# CUSTOM CONFIGURATION #
########################
FROM base
USER dev
WORKDIR /home/dev/src

# install custom libs
RUN sudo apt install -y cowsay

# install node
ARG NODE_VERSION
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | sh && \
    export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
    nvm install $NODE_VERSION && \
    npm install -g yarn && \
    npm install -g typescript && \
    npm install -g webpack-cli && \
    npm install -g json