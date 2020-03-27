dotfiles
========
Install brew

brew install tmux
brew install zsh
brew install ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

Run the sync.sh

In a tmux session, run Ctrl-A, I in order to install plugins
