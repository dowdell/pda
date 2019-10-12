#
#
FROM alpine:edge as base
RUN apk add --no-cache \
  git \
  groff \
  mdocml-apropos \
  nodejs \
  npm \
  python3 \
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
COPY --from=python /py                /py

ENV EDITOR nvim
ENV JWT_AUTH_TOKEN ""
ENV PYTHONPATH $PYTHONPATH:/py/lib/python3.7/site-packages
ENV PATH $PATH:./node_modules/.bin:/py/bin
RUN adduser pda -h /home -D && chown -R pda ~pda

USER pda
WORKDIR /home
VOLUME /home/.cache
CMD [ "fish" ]

RUN nvim -n --noplugin +PlugInstall +qall \
  && nvim -n +UpdateRemotePlugins +qall
