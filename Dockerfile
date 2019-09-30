#
#
FROM alpine:edge as base
RUN apk add --no-cache \
  bash \
  cargo \
  git \
  groff \
  mdocml-apropos \
  nodejs \
  npm \
  openjdk8 \
  python3 \
  rust \
  zip

#
#
FROM base as dev
RUN apk add --no-cache gcc musl-dev
WORKDIR /tmp
RUN wget -q https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep-0.10.0-x86_64-unknown-linux-musl.tar.gz
RUN tar xzf ripgrep*
RUN mv ripgrep*/rg /opt/rg
RUN rm -r /tmp/ripgrep*

#
#
FROM dev as golang
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
RUN apk add --no-cache go
RUN go get -u github.com/fiatjaf/jiq/cmd/jiq

#
#
FROM dev as python
RUN apk add --no-cache neovim python3-dev
RUN pip3 install --prefix /py --no-cache-dir \
  awscli \
  awslogs \
  httpie-aws-authv4 \
  httpie-jwt-auth \
  icdiff \
  neovim

#
#
FROM dev as scala
ARG SCALA_VERSION
ARG SBT_VERSION
ENV SCALA_VERSION ${SCALA_VERSION:-2.12.8}
ENV SBT_VERSION ${SBT_VERSION:-1.2.8}
RUN apk add --no-cache ncurses
RUN wget -qO - http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /usr/local
RUN wget -qO - https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local
RUN wget -qO /usr/local/bin/coursier https://git.io/coursier \
  && chmod +x /usr/local/bin/coursier \
  && coursier bootstrap \
    --java-opt -XX:+UseG1GC \
    --java-opt -XX:+UseStringDeduplication  \
    --java-opt -Xss4m \
    --java-opt -Xms1G \
    --java-opt -Xmx4G  \
    --java-opt -Dmetals.client=coc.vim \
    org.scalameta:metals_2.12:0.7.0 \
    -r bintray:scalacenter/releases \
    -r sonatype:snapshots \
    -o /usr/local/bin/metals-vim -f

#
#
FROM base as pda
RUN npm install -g neovim
RUN apk add --no-cache \
  fish \
  fzf \
  httpie \
  ipcalc \
  jq \
  less \
  moreutils \
  neovim \
  terraform \
  tig

COPY              ./home              /home/
COPY              ./bin/exa           /usr/local/bin/
COPY --from=dev    /opt/rg            /usr/local/bin/
COPY --from=golang /go/bin/jiq        /usr/local/bin/
COPY --from=scala  /usr/local/bin/*   /usr/local/bin/
COPY --from=scala  /usr/local/sbt     /usr/local/
COPY --from=scala  /usr/local/scala-* /usr/local/
COPY --from=python /py                /py

ENV EDITOR nvim
ENV JWT_AUTH_TOKEN ""
ENV PYTHONPATH $PYTHONPATH:/py/lib/python3.7/site-packages
ENV PATH $PATH:./node_modules/.bin:/py/bin:/usr/lib/jvm/java-1.8-openjdk/bin
RUN adduser pda -h /home -D && chown -R pda ~pda

USER pda
WORKDIR /home
VOLUME /home/.cache
CMD [ "fish" ]

RUN nvim --noplugin +PlugInstall +qall \
  && nvim +UpdateRemotePlugins +qall \
  && rm /home/.bashrc /home/.fzf.bash
