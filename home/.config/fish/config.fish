set fish_greeting

if not set -q abbrs_initialized
  abbr diff 'icdiff'
  abbr glog 'git log --graph --pretty=format:\'%C(red)%h%Creset -%Creset %s%C(bold blue)%d %Cgreen(%ar)%Creset\' --decorate-refs-exclude="refs/remotes/origin/*"'
  abbr jwt  'http -A jwt'
  abbr ls   'exa -l'
  abbr vi   'nvim'
  abbr vim  'nvim'
  set -U abbrs_initialized
end
