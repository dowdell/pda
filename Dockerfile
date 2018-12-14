FROM alpine

RUN apk add --no-cache \
  fish \
  fzf \
  git \
  httpie \
  jq \
  less \
  neovim \
# language runtimes: \
  nodejs \
  npm \
  python3 \
  \
# python pkg compilation: \
  gcc \
  musl-dev \
  python3-dev \
  \
  && pip3 install --no-cache-dir \
  awscli \
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

# install dotfiles
COPY ./home /home

# install ripgrep
RUN cd /tmp \
  && wget -q https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz \
  && tar xzf ripgrep* \
  && mv ripgrep*/rg /usr/local/bin/ \
  && rm -r /tmp/ripgrep*

# install exa
COPY ./bin/* /usr/local/bin/

# create user
RUN adduser dev -h /home -D \
  && chown -R dev ~dev

# initialize
USER dev
WORKDIR /home
RUN nvim --noplugin +PlugInstall +qall \
  && nvim +UpdateRemotePlugins +qall
CMD [ "fish" ]

VOLUME /home/src
