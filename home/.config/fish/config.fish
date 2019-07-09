set fish_greeting

if not set -q abbrs_initialized
  abbr diff 'icdiff'
  abbr glog 'git log --graph --pretty=format:\'%C(red)%h%Creset -%Creset %s%C(bold blue)%d %Cgreen(%ar)%Creset\' --decorate-refs-exclude="refs/remotes/origin/*"'
  abbr ls   'exa -l'
  abbr vi   'nvim'
  abbr vim  'nvim'
  abbr cvim 'nvim ~/src/pda/home/.config/nvim/init.vim'
  set -U abbrs_initialized
  set PATH ./node_modules/.bin $PATH
end

function get --wraps http
  http GET $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function GET --wraps http
  http -v GET $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function put --wraps http
  http PUT $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function PUT --wraps http
  http -v PUT $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function post --wraps http
  http POST $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function POST --wraps http
  http -v POST $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function delete --wraps http
  http DELETE $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
function DELETE --wraps http
  http -v DELETE $argv Authorization:"Bearer $JWT" X-Nike-Authorization:"Bearer $JWT"
end
