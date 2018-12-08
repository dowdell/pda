set fish_greeting

if not set -q abbrs_initialized
  abbr ls   'exa -l'
  abbr vi   'nvim'
  abbr vim  'nvim'
  set -U abbrs_initialized
end

function get --wraps http
  http GET $argv Authorization:$JWT
end
function GET --wraps http
  http -v GET $argv Authorization:$JWT
end
function put --wraps http
  http PUT $argv Authorization:$JWT
end
function PUT --wraps http
  http -v PUT $argv Authorization:$JWT
end
function post --wraps http
  http POST $argv Authorization:$JWT
end
function POST --wraps http
  http -v POST $argv Authorization:$JWT
end
function delete --wraps http
  http DELETE $argv Authorization:$JWT
end
function DELETE --wraps http
  http -v DELETE $argv Authorization:$JWT
end
