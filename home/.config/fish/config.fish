set fish_greeting

if not set -q abbrs_initialized
  abbr ls   'exa -l'
  abbr vi   'nvim'
  abbr vim  'nvim'
  set -U abbrs_initialized
end
