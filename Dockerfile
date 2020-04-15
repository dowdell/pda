FROM alpine:3.11 as base
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  bash \
  curl \
  git \
  groff \
  mdocml-apropos \
  less \
  make \
  ncurses \
  nodejs \
  npm \
  openjdk8 \
  python3 \
  zip \
&& apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
  sbt

# ephemeral builder
FROM python:3.8-alpine3.11 as python
ENV PATH $PATH:/py/bin
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community \
  gcc \
  musl-dev
RUN pip3 install --prefix /py --no-cache-dir \
  awscli \
  httpie-aws-authv4 \
  httpie-jwt-auth \
  icdiff \
  neovim \
  ydiff

# ephemeral builder
FROM base as scala
RUN apk add --no-cache ncurses
RUN curl -sSLo /usr/local/bin/cs https://git.io/coursier-cli-linux \
  && chmod +x /usr/local/bin/cs

 # bootstrap \
 #   --java-opt -XX:+UseG1GC \
 #   --java-opt -XX:+UseStringDeduplication  \
 #   --java-opt -Xss4m \
 #   --java-opt -Xms1G \
 #   --java-opt -Xmx4G  \
 #   --java-opt -Dmetals.client=coc.vim \
 #   org.scalameta:metals_2.12:0.7.0 \
 #   -r bintray:scalacenter/releases \
 #   -r sonatype:snapshots \
 #   -o /usr/local/bin/metals-vim -f

#
FROM base as pda
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community \
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
RUN ln -s /usr/bin/python3 /usr/local/bin/python # for `icdiff`

COPY              ./home              /home/
COPY              ./bin/entrypoint.sh /entrypoint.sh
COPY              ./bin/exa           /usr/local/bin/
COPY --from=python /py                /py
COPY --from=scala  /usr/local/bin/*   /usr/local/bin/

ENV PYTHONPATH /py/lib/python3.8/site-packages
ENV PATH $PATH:./node_modules/.bin:/py/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JWT_AUTH_TOKEN ""
ENV EDITOR nvim

RUN adduser pda -h /home -D && chown -R pda ~pda

USER pda
WORKDIR /home
VOLUME /home/.cache
CMD [ "fish" ]

RUN curl -sSL git.io/pure-fish --output /tmp/pure_installer.fish
RUN fish -c 'source /tmp/pure_installer.fish; and install_pure'

RUN nvim -n --noplugin +'PlugInstall --sync' +qa \
  && nvim -n +'UpdateRemotePlugins --sync' +qa \
  && rm /home/.bashrc /home/.fzf.bash

USER root
ENTRYPOINT [ "/entrypoint.sh" ]
