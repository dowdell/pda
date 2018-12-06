FROM alpine

VOLUME /home/src

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
  neovim

COPY ./init.sh /init.sh
COPY ./home /home

RUN chmod +x /init.sh && \
  adduser dev -h /home -D && \
  chown -R dev ~dev && \
  su -l -c 'nvim --noplugin +PlugInstall +qall' dev && \
  su -l -c 'nvim +UpdateRemotePlugins +qall' dev

RUN cd /tmp && wget -q \
  https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz \
&& tar xzf ripgrep* && mv ripgrep*/rg /usr/bin/ && rm -r /tmp/ripgrep*

ENTRYPOINT [ "/init.sh" ]
CMD [ "fish" ]
