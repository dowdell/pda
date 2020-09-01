# Portable Development Assistant [![Build Status](https://drone.nwd.me/api/badges/dowdell/pda/status.svg)](https://drone.nwd.me/dowdell/pda)

  - [awscli][aws] - AWS Command Line Interface
  - [exa][exa] - a modern version of `ls`
  - [fish][fish] - user-friendly command line shell
  - [fzf][fzf] - general purpose fuzzy finder
  - [go][go]
  - [git][git] & [tig][tig] (text-mode interface)
  - [httpie][http] - HTTP client
    - pipe JSON responses to [jq][jq] or [fx][fx]
  - [ipcalc][calc] - simple manipulation of IP addresses
  - [less][less] - terminal pager
  - make
  - [neovim][nvim] - text editor
  - [node 10][node] & [npm][npm]
  - [python 3][py3]
  - [ripgrep][rg] - line oriented search tool
  - [terraform][terra] - infrastructure management
  - [ydiff][ydiff] - colored, incremental diff
  - [wuzz][wuzz] - interactive tool for HTTP inspection

[aws]: https://aws.amazon.com/cli/
[awssh]: https://github.com/awslabs/aws-shell
[calc]:  https://linux.die.net/man/1/ipcalc
[exa]:   https://the.exa.website/
[fish]:  https://fishshell.com/docs/current/tutorial.html
[fx]:    https://github.com/antonmedv/fx
[fzf]:   https://github.com/junegunn/fzf#-
[git]:   https://git-scm.com/docs
[go]:    https://golang.org/
[http]:  https://httpie.org/doc#usage
[jq]:    https://stedolan.github.io/jq/manual/
[less]:  https://en.wikipedia.org/wiki/Less_(Unix)
[node]:  https://nodejs.org/dist/latest-v10.x/docs/api/
[npm]:   https://docs.npmjs.com/cli-documentation/
[py3]:   https://docs.python.org/3/library/
[nvim]:  https://neovim.io/doc/user/
[rg]:    https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#user-guide
[terra]: https://www.terraform.io/docs/cli-index.html
[tig]:   https://jonas.github.io/tig/
[ydiff]: https://github.com/ymattw/ydiff
[wuzz]:  https://github.com/asciimoo/wuzz

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

* uses [defaults][cfg] everyone can agree on
* supports [_some_][props] [EditorConfig][edit] properties

| key | command | action |
| --- | --- | --- |
| `<C-k>` | | move line(s) up |
| `<C-j>` | | move line(s) down |
| `<C-f>` | `:Rg` | search file contents (fzf) |
| `<C-p>` | `:GFiles` | open file (fzf) |
| | `:GFiles?` | open unstaged file (fzf) |
| `-` | | navigate directories with [dirvish][dirvish] |
| `.` | | [repeat][repeat] last action
| `cs'"` | | change `'` surrounding quotes to `"` |
| `dst` | | remove surrounding tags such as `<q>` and `</q>` |
| `ds"` | | remove `"` that [surround][surround] selection |
| --- | --- | --- |
| `gf` | | open `require()` path under cursor, see [vim-node][node] |
| `[I` | | look for keyword in required files |
| | `:Nedit` | |
| | `:Nopen` | |

[cfg]:      https://github.com/tpope/vim-sensible
[dirvish]:  https://github.com/justinmk/vim-dirvish
[edit]:     https://editorconfig.org
[node]:     https://github.com/moll/vim-node
[props]:    https://github.com/editorconfig/editorconfig-vim#supported-properties
[repeat]:   https://github.com/tpope/vim-repeat
[surround]: https://github.com/tpope/vim-surround
