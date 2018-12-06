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
  # ripgrep \
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

ENTRYPOINT [ "/init.sh" ]
CMD [ "fish" ]
