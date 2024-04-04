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
	dotfiles pull
else
	echo "Before we begin; Let's make sure you have your email set"

	read -t 3 -n 1 -p "Is your email set in git global config (Y/n)?" answer
	[ -z "$answer" ] && answer="N"
	if [[ $answer == [Nn] ]]
		then
			git config --global --edit	
	fi

	echo "Setting up dotfiles repository..."

	# Initialize a bare Git repository for the dotfiles
	git init --bare $HOME/.cfg

	# Create an alias for the Git command
	alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

	# Set local Git configuration to not show untracked files
	dotfiles config --local status.showUntrackedFiles no

	dotfiles config --local clean.requireForce true

	dotfiles config --local alias.clean '!echo "Clean is disabled for dotfile configuration"'

	# Set sparse checkout
	dotfiles config --local core.sparseCheckout true

	dotfiles config --local alias.config "config --local"


	# Add the alias to the bashrc file
	echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> $HOME/.bashrc

	# Change master to main
	dotfiles branch -m main
	
	# start an empty commit
	# README.md and setup.sh script go on the main branch
	dotfiles commit --allow-empty -m "Initial commit"

	# Create a new branch
	read -t 5 -p "What branchname do you want to use [${HOME##*/}]?" branch
	
	dotfiles checkout HEAD -b $branch
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
