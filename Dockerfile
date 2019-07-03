FROM alpine:edge

ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:/usr/lib/jvm/java-1.8-openjdk/bin/:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin

RUN apk add --no-cache \
  fish \
  fzf \
  git \
  httpie \
  ipcalc \
  jq \
  neovim \
  terraform \
# misc: \
  less \
  groff \
  mdocml-apropos \
# language runtimes: \
  go \
  nodejs \
  npm \
  openjdk8 \
  python2 \
  python3 \
  \
# metals-vim via coursier: \
  bash \
  ncurses \
# go & python pkg compilation: \
  musl-dev \
# python pkg compilation: \
  gcc \
  py2-pip \
  python2-dev \
  python3-dev \
  \
  && go get -u github.com/fiatjaf/jiq/cmd/jiq \
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

# install scala
ARG SCALA_VERSION
ENV SCALA_VERSION ${SCALA_VERSION:-2.12.8}
RUN wget -qO - http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local \
&& ln -s /usr/local/scala-$SCALA_VERSION/bin/* /usr/local/bin/ \
&& scala -version \
&& scalac -version

# install SBT
ARG SBT_VERSION
ENV SBT_VERSION ${SBT_VERSION:-1.2.8}
RUN wget -qO - https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local \
  && ln -s /usr/local/sbt/bin/* /usr/local/bin/

# install metals-vim
RUN wget -qO /usr/local/bin/coursier https://git.io/coursier \
  && chmod +x /usr/local/bin/coursier \
  && coursier bootstrap \
    --java-opt -XX:+UseG1GC \
    --java-opt -XX:+UseStringDeduplication  \
    --java-opt -Xss4m \
    --java-opt -Xms1G \
    --java-opt -Xmx4G  \
    --java-opt -Dmetals.client=coc.vim \
    org.scalameta:metals_2.12:0.3.1 \
    -r bintray:scalacenter/releases \
    -r sonatype:snapshots \
    -o /usr/local/bin/metals-vim -f

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

VOLUME /home/src /home/.cache /home/.ivy2 /home/.sbt
