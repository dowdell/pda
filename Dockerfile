FROM alpine

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
  terraform \
  tmux \
&& pip3 install --no-cache-dir \
  awscli \
  icdiff \
  neovim \
&& npm install -g \
  neovim \
  tern

# install ripgrep
RUN cd /tmp \
&& wget -q https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz \
&& tar xzf ripgrep* \
&& mv ripgrep*/rg /usr/bin/ \
&& rm -r /tmp/ripgrep*

# install exa
COPY ./bin/* /usr/bin/

# install config
COPY ./home /home

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
