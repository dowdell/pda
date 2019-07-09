# Portable Development Assistant

## Usage

```
docker run --rm -it \
  -e TZ=America/Vancouver \
  -v ~/.config/git:/home/.config/git \
  -v ~/src:/home/src \
  nwd.me/pda
```

## Contents

  - [exa][exa] - a modern version of `ls`
  - [fish][fish] - user-friendly command line shell
  - [fzf][fzf] - general purpose fuzzy finder
  - [httpie][pie] - HTTP client
    - pipe JSON responses to [jq][jq] or [jiq][jiq] (interactive)
    - `get`, `post`, etc to send `$JWT` in the `Authorization` header
    - `GET`, `POST`, etc to do so verbosely
  - [java 8][jdk8] & [scala 2.12][scala]
  - [ipcalc][calc] - simple manipulation of IP addresses
  - [neovim][nvim] - text editor
  - [node 10][node] & [npm][npm]
  - [python 3][py3]
  - [ripgrep][rg] - line oriented search tool
  - [terraform][terra] - infrastructure management

[calc]:  https://linux.die.net/man/1/ipcalc
[exa]:   https://the.exa.website/
[fish]:  https://fishshell.com/docs/current/tutorial.html
[fzf]:   https://github.com/junegunn/fzf#-
[jdk8]:  https://openjdk.java.net/projects/jdk8/
[jiq]:   https://github.com/fiatjaf/jiq
[jq]:    https://stedolan.github.io/jq/manual/
[node]:  https://nodejs.org/dist/latest-v10.x/docs/api/
[npm]:   https://docs.npmjs.com/cli-documentation/
[pie]:   https://httpie.org/doc#usage
[py3]:   https://docs.python.org/3/library/
[nvim]:  https://neovim.io/doc/user/
[rg]:    https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#user-guide
[scala]: https://www.scala-lang.org/api/2.12.8/
[terra]: https://www.terraform.io/docs/cli-index.html

### Neovim

  - `<C-k>` - move line up
  - `<C-j>` - move line down
  - `<C-p>` - open file with fuzzy finder (`:GFiles`)
  - N/A - open modified with fuzzy finder (`:GFiles?`)
