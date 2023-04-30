FROM ubuntu:23.04

run apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y git nodejs zsh npm \
    ninja-build gettext cmake unzip curl

# FNM
RUN curl -fsSL https://fnm.vercel.app/install | bash \
    && export PATH="/root/.local/share/fnm:$PATH" \
    && eval "`fnm env`" \
    && fnm install 16

# NEOVIM
RUN git clone https://github.com/neovim/neovim \
    && cd neovim \
    && git checkout stable \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install

RUN git clone https://github.com/joalcava/dotfiles \
    && mkdir -p ~/.config/nvim \
    && cp -r dotfiles/.config/nvim ~/.config


workdir /code
