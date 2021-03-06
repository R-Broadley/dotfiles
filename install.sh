#!/bin/bash

# Get path of repo directory (the one containing this script)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


# Update submodules
( cd $DIR && git submodule update --init --recursive )


# Functions
ensure_line_in_file () {
	grep -qF "$1" "$2" || ( echo "$1" >> "$2" && return 10 )
}


# General settings
# Ensure .profile exists
touch ~/.profile
# Editor
ensure_line_in_file "export VISUAL=nvim" ~/.profile
status=$?
if [[ $status -eq 10 ]]; then
	# if added VISUAL=nvim also add EDITOR=VISUAL after
	echo "export EDITOR=\$VISUAL" >> ~/.profile
else
	# check VISUAL=EDITOR set
	ensure_line_in_file "export EDITOR=\$VISUAL" ~/.profile
fi
# .profile sourced in .bash_profile if it exists
if [ -f ~/.bash_profile ]; then
	grep -qF "source ~/.profile" ~/.bash_profile || cat >> ~/.bash_profile <<-"EOF"

		# Get shell independant variables, aliases and functions
		if [ -f ~/.profile ]; then
		    source ~/.profile
		fi
	EOF
fi


# Set up gnome-terminal (if dconf installed)
command -v dconf >/dev/null 2>&1
status=$?
if [[ $status -eq 0 ]]; then
	$DIR/gnome-terminal/gnome-terminal-install.sh
fi


# Set up tmux
ln -s -f $DIR/tmux/.tmux.conf ~
ln -s -f $DIR/tmux/.tmux.conf.local ~
TMUXX='alias tmuxx="tmux new-session -A -s"'
ensure_line_in_file "$TMUX" ~/.bashrc


# Set up neovim
mkdir -p ~/.config/nvim
ln -s -f $DIR/neovim/init.vim ~/.config/nvim/
DEIN_DIR=~/.local/share/nvim/dein/repos/github.com/Shougo
rm -rf $DEIN_DIR/dein.vim || true
mkdir -p $DEIN_DIR
ln -s $DIR/neovim/dein.vim $DEIN_DIR
echo "To get neovim up and running open it and run :call dein#install()"


# Set up zsh
$DIR/zsh/zsh_install.py


# Fonts
mkdir -p ~/.fonts
rm -rf ~/.fonts/nerd-fonts || true
ln -s $DIR/fonts/nerd-fonts ~/.fonts/


# Default editorconfig (for any files below users home)
ln -s -f $DIR/.editorconfig ~
