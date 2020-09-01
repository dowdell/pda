# size: ~260MB, discarded
FROM python:alpine3.12 as python
ENV PATH $PATH:/py/bin
RUN apk add --no-cache gcc musl-dev
RUN pip3 install --prefix /py --no-cache-dir \
  awscli \
  aws-shell \
  httpie-aws-authv4 \
  httpie-jwt-auth \
  neovim \
  ydiff

# size: ~436MB
FROM alpine:3.12
RUN apk add --no-cache \
  bash \
  curl \
  git \
  groff \
  less \
  libuv \
  libuv-dev \
  make \
  ncurses \
  nodejs \
  npm \
  python3 \
  zip
RUN apk add --no-cache \
  docker-cli \
  fish \
  fzf \
  httpie \
  ipcalc \
  jq \
  neovim \
  neovim-doc \
  openssh-client \
  ripgrep \
  terraform \
  tig
RUN npm install -g neovim fx

COPY              ./home              /home/
COPY              ./bin/entrypoint.sh /entrypoint.sh
COPY              ./bin/exa           /usr/local/bin/
COPY --from=python /py                /py

# for aws-shell
RUN ln -s /usr/bin/python3 /usr/local/bin/python

ENV PYTHONPATH /py/lib/python3.8/site-packages
ENV PATH $PATH:./node_modules/.bin:/py/bin
ENV JWT_AUTH_TOKEN ""
ENV EDITOR nvim

RUN adduser pda -h /home -D && chown -R pda ~pda

USER pda
WORKDIR /home
VOLUME /home/.cache
CMD [ "fish" ]

RUN curl git.io/pure-fish --output /tmp/pure_installer.fish --location --silent
RUN fish -c 'source /tmp/pure_installer.fish; and install_pure'

RUN nvim -n --noplugin +'PlugInstall --sync' +qa \
  && nvim -n +'UpdateRemotePlugins --sync' +qa

USER root
ENTRYPOINT [ "/entrypoint.sh" ]
