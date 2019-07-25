# Portable Development Assistant

  - awscli
  - awslogs - because the web UI is horrible
  - bash - because `coursier` requires it
  - [exa][exa] - a modern version of `ls`
  - [fish][fish] - user-friendly command line shell
  - [fzf][fzf] - general purpose fuzzy finder
  - [httpie][http] - HTTP client
    - pipe JSON responses to [jq][jq] or [jiq][jiq] (interactive)
  - icdiff
  - [ipcalc][calc] - simple manipulation of IP addresses
  - [java 8][jdk8], [scala 2.12][scala], and `coursier`
  - less
  - [neovim][nvim] - text editor
  - [node 10][node] & [npm][npm]
  - [python 3][py3]
  - [ripgrep][rg] - line oriented search tool
  - rust & cargo
  - [terraform][terra] - infrastructure management
  - [tig][tig] - text-mode interface for git

[calc]:  https://linux.die.net/man/1/ipcalc
[exa]:   https://the.exa.website/
[fish]:  https://fishshell.com/docs/current/tutorial.html
[fzf]:   https://github.com/junegunn/fzf#-
[http]:   https://httpie.org/doc#usage
[jdk8]:  https://openjdk.java.net/projects/jdk8/
[jiq]:   https://github.com/fiatjaf/jiq
[jq]:    https://stedolan.github.io/jq/manual/
[node]:  https://nodejs.org/dist/latest-v10.x/docs/api/
[npm]:   https://docs.npmjs.com/cli-documentation/
[py3]:   https://docs.python.org/3/library/
[nvim]:  https://neovim.io/doc/user/
[rg]:    https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#user-guide
[scala]: https://www.scala-lang.org/api/2.12.8/
[terra]: https://www.terraform.io/docs/cli-index.html
[tig]:   https://jonas.github.io/tig/

## Usage

Home example:
```
docker run -it \
  -e TERM=$TERM \
  -e TZ=America/Vancouver \
  -v ~/.cache:/home/.cache \
  -v ~/.config/git:/home/.config/git \
  -v ~/src:/home/src \
  --hostname home \
  --rm nwd.me/pda
```

Work example:
```
docker run -it \
  -e TERM=$TERM \
  -v /Applications/kitty.app/Contents/Resources/terminfo/78/xterm-kitty:/usr/share/terminfo/x/xterm-kitty \
  -v /var/db/timezone/zoneinfo/America/Vancouver:/etc/localtime \
  -v ~/.cache:/home/.cache \
  -v ~/.config/git:/home/.config/git \
  -v ~/src:/home/src \
  -w /home/src \
  --hostname work \
  --rm nwd.me/pda
```

### Neovim

  - `<C-k>` - move line up
  - `<C-j>` - move line down
  - `<C-p>` - open file with fuzzy finder (`:GFiles`)
  - N/A - open modified with fuzzy finder (`:GFiles?`)
