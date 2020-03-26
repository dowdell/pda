#
FROM python:3.8-alpine3.11 as python
ENV PATH $PATH:/py/bin
RUN apk add --no-cache gcc musl-dev \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community
RUN pip3 install --prefix /py --no-cache-dir \
  awscli \
  httpie-aws-authv4 \
  httpie-jwt-auth \
  icdiff \
  neovim \
  ydiff

#
FROM alpine:3.11
RUN apk add --no-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  bash \
  curl \
  git \
  groff \
  mdocml-apropos \
  less \
  make \
  ncurses \
  neovim \
  nodejs \
  npm \
  python3 \
  zip
RUN apk add --no-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  fish \
  fzf \
  httpie \
  ipcalc \
  jq \
  openssh-client \
  ripgrep \
  terraform \
  tig
RUN npm install -g neovim fx
RUN ln -s /usr/bin/python3 /usr/local/bin/python # for `icdiff`

COPY              ./home              /home/
COPY              ./bin/entrypoint.sh /entrypoint.sh
COPY              ./bin/exa           /usr/local/bin/
COPY --from=python /py                /py

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
