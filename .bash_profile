source ~/.git-prompt.sh
source ~/.bashrc

# strap:strapenv:begin
[ -r "$HOME/.strap/etc/strapenv" ] && . "$HOME/.strap/etc/strapenv"
# strap:strapenv:end

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH=${PATH}:/Users/kelvinzhu/okta/release-tools/resources/shortcuts

GPG_TTY=$(tty)
export GPG_TTY
