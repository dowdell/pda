#
#
FROM python:3.7-alpine3.10 as python
ENV PATH $PATH:/py/bin
RUN apk add --no-cache gcc musl-dev
RUN pip3 install --prefix /py --no-cache-dir \
  awscli \
  httpie-aws-authv4 \
  httpie-jwt-auth \
  icdiff \
  neovim
#  awslogs requires botocore-1.13.18 and python-dateutil-2.8.1, breaks httpie

#
#
FROM alpine:3.10
RUN apk add --no-cache \
  bash \
  curl \
  git \
  groff \
  mdocml-apropos \
  less \
  make \
  moreutils \
  neovim \
  nodejs \
  npm \
  python3 \
  zip
RUN apk add --no-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing \
  docker-cli \
  docker-compose \
  fish \
  fzf \
  httpie \
  ipcalc \
  jq \
  openssh-client \
  ripgrep \
  terraform \
  tig
RUN npm install -g neovim
RUN ln -s /usr/bin/python3 /usr/local/bin/python # for `icdiff`

COPY              ./home              /home/
COPY              ./bin/entrypoint.sh /entrypoint.sh
COPY              ./bin/exa           /usr/local/bin/
COPY --from=python /py                /py

ENV PYTHONPATH /py/lib/python3.7/site-packages
ENV PATH $PATH:./node_modules/.bin:/py/bin
ENV JWT_AUTH_TOKEN ""
ENV EDITOR nvim

RUN adduser pda -h /home -D && chown -R pda ~pda

USER pda
WORKDIR /home
VOLUME /home/.cache
CMD [ "fish" ]

RUN nvim -n --noplugin +'PlugInstall --sync' +qa \
  && nvim -n +'UpdateRemotePlugins --sync' +qa

USER root
ENTRYPOINT [ "/entrypoint.sh" ]
