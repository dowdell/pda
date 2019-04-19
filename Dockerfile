FROM alpine

RUN apk add --no-cache \
  fish \
  fzf \
  git \
  groff \
  httpie \
  ipcalc \
  jq \
  less \
  neovim \
# language runtimes: \
  nodejs \
  npm \
  python2 \
  python3 \
  terraform \
  \
# python pkg compilation: \
  gcc \
  musl-dev \
  py2-pip \
  python2-dev \
  python3-dev \
  \
  && pip2 install --no-cache-dir \
  neovim \
  \
  && pip3 install --no-cache-dir \
  awscli \
  awslogs \
  icdiff \
  neovim \
  \
  && apk del -r --purge --no-cache \
  gcc \
  musl-dev \
  \
  && npm install -g \
  neovim \
  tern

WORKDIR /tmp

# install ripgrep
RUN wget -q https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz \
  && tar xzf ripgrep* \
  && mv ripgrep*/rg /usr/local/bin/ \
  && rm -r /tmp/ripgrep*

# install lazygit
RUN wget -q https://github.com/jesseduffield/lazygit/releases/download/v0.6/lazygit_0.6_Linux_x86_64.tar.gz \
  && tar xzf lazygit* \
  && mv lazygit /usr/local/bin \
  && rm /tmp/*

# install exa (pre-compiled for musl)
COPY ./bin/* /usr/local/bin/

# install dotfiles
COPY ./home /home

# create user
RUN adduser pda -h /home -D \
  && chown -R pda ~pda

# initialize
USER pda
WORKDIR /home
RUN nvim --noplugin +PlugInstall +qall \
  && nvim +UpdateRemotePlugins +qall
WORKDIR /home/src
CMD [ "fish" ]

VOLUME /home/src
