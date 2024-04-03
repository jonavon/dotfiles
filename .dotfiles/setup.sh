#!/bin/bash

# Function to check if the dotfiles repository is already set up
is_repo_setup() {
	if [ -d "$HOME/.cfg" ]; then
		return 0
	else
		return 1
	fi
}


# Check if the dotfiles repository is already set up
if is_repo_setup; then
	echo "Dotfiles repository is already set up. Updating files..."

	# Pull the latest changes from the dotfiles repository
	config pull
else
	echo "Setting up dotfiles repository..."

	# Initialize a bare Git repository for the dotfiles
	git init --bare $HOME/.cfg

	# Create an alias for the Git command
	alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

	# Set local Git configuration to not show untracked files
	config config --local status.showUntrackedFiles no

	config config --local clean.requireForce true

	config config --local alias.clean '!echo "Clean is disabled for dotfile configuration"'

	config config --local alias.config "config --local"



	# Add the alias to the bashrc file
	echo "alias config='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> $HOME/.bashrc

	# Clone your dotfiles repository
	git clone --bare https://github.com/yourusername/dotfiles.git $HOME/.cfg
fi

# Create a backup directory and move existing files
mkdir -pv $HOME/.dotfiles/backup
config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $HOME/.dotfiles/backup/{}

# Checkout the dotfiles repository
config checkout


# Create empty folders for Vim
mkdir -pv $HOME/.vim/{bundle,backup,swap,undo}

# Ignore the Vim folders in .cfg/info/exclude
if ! grep -q "/.vim/bundle" "$HOME/.cfg/info/exclude"; then
	echo "/.vim/bundle" >> $HOME/.cfg/info/exclude
fi
if ! grep -q "/.vim/backup" "$HOME/.cfg/info/exclude"; then
	echo "/.vim/backup" >> $HOME/.cfg/info/exclude
fi
if ! grep -q "/.vim/swap" "$HOME/.cfg/info/exclude"; then
	echo "/.vim/swap" >> $HOME/.cfg/info/exclude
fi
if ! grep -q "/.vim/undo" "$HOME/.cfg/info/exclude"; then
	echo "/.vim/undo" >> $HOME/.cfg/info/exclude
fi

# Ignore sensitive files and directories in .cfg/info/exclude
if ! grep -q "/.gnupg" "$HOME/.cfg/info/exclude"; then
	echo "/.gnupg" >> $HOME/.cfg/info/exclude
fi
if ! grep -q "/.ssh" "$HOME/.cfg/info/exclude"; then
	echo "/.ssh" >> $HOME/.cfg/info/exclude
fi

if ! grep -q "/.dotfiles/backup" "$HOME/.cfg/info/exclude"; then
	echo "/.dotfiles/backup" >> $HOME/.cfg/info/exclude
fi

# Source the updated bashrc
source $HOME/.bashrc

# Additional setup steps
# Add any other setup commands or configurations you need
