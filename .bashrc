txtgrn='\e[0;32m'
bldred='\e[1;31m'
PS1="[\d \t \u@\h:\[$txtgrn\]\w\[\e[m\] ] \[$bldred\]\$(__git_ps1)\[\e[m\] $ "

# strap:straprc:begin
[ -r "$HOME/.strap/etc/straprc" ] && . "$HOME/.strap/etc/straprc"
# strap:straprc:end
