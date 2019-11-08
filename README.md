# Portable Development Assistant

[![Build Status](https://drone.nwd.me/api/badges/dowdell/pda/status.svg)](https://drone.nwd.me/dowdell/pda)

  - awscli
  - awslogs - because the web UI is horrible
  - [exa][exa] - a modern version of `ls`
  - [fish][fish] - user-friendly command line shell
  - [fzf][fzf] - general purpose fuzzy finder
  - [git][git] & [tig][tig] (text-mode interface)
  - [httpie][http] - HTTP client
    - pipe JSON responses to [jq][jq]
  - icdiff
  - [ipcalc][calc] - simple manipulation of IP addresses
  - less
  - [neovim][nvim] - text editor
  - [node 10][node] & [npm][npm]
  - [python 3][py3]
  - [ripgrep][rg] - line oriented search tool
  - [terraform][terra] - infrastructure management

[calc]:  https://linux.die.net/man/1/ipcalc
[exa]:   https://the.exa.website/
[fish]:  https://fishshell.com/docs/current/tutorial.html
[fzf]:   https://github.com/junegunn/fzf#-
[git]:   https://git-scm.com/docs
[http]:  https://httpie.org/doc#usage
[jq]:    https://stedolan.github.io/jq/manual/
[node]:  https://nodejs.org/dist/latest-v10.x/docs/api/
[npm]:   https://docs.npmjs.com/cli-documentation/
[py3]:   https://docs.python.org/3/library/
[nvim]:  https://neovim.io/doc/user/
[rg]:    https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#user-guide
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
