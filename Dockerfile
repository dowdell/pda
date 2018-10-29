FROM alpine

ENTRYPOINT [ "/entrypoint.sh" ]
WORKDIR /home

RUN apk add --no-cache \
  # exa \
  fish \ 
  gcc \
  git \
  httpie \
  jq \
  musl-dev \
  neovim \
  npm \
  nodejs \
  python3 \
  python3-dev \
  # ripgrep \
  terraform \
  tmux

RUN pip3 install --no-cache-dir \
  awscli \
  icdiff \
  neovim

COPY ./entrypoint.sh /
COPY ./home /home

RUN nvim --noplugin +PlugInstall +qall
