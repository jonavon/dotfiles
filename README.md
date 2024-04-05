# Dotfiles Management

A dotfiles repository based on an [Atlassian Blog
Post](https://www.atlassian.com/git/tutorials/dotfiles).

This repository has a few differences.

* The `config` alias has been replaced with `dotfiles` alias to avoid an alias
  name collision.
* The main branch is effectively an empty branch containing this README.md and
  a setup script, `.dotfiles/setup.sh`.
* Some git commands are disabled to prevent users from deleting their home
  directory.

## Getting setup

Users should be able to just run the setup script to get start. You accept the
risk if you don't understand what's happening.

### Manual steps

To understand the setup you can follow this guide.

#### 1. Configure git globally

You should configure git to have your email setup globally.

```
git config --global --edit
```

This will open your `~/.gitconfig` file in your default editor. Create a block
that looks like this.

```
[user]
    name = Papa Smurf
    email = papa@smurfvillage.com
```

#### 2. Setting up the dotfiles repository

We create a bare repository in your home directory under a different name
`.cfg`.

```
git init --bare $HOME/.cfg
```

#### 3. Create an alias for management

Because the bare repository is named `.cfg`, git will throw an error if you try
to use `git` commands. Here we create an alias to git that knows about the bare
repository.

```
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo "alias dotfiles='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> $HOME/.bashrc
```

#### 4. Set local configuration

Use our new `dotfiles` alias to set a local configuration.

```
# Set local Git configuration to not show untracked files
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local clean.requireForce true
dotfiles config --local alias.clean '!echo "Clean is disabled for dotfile configuration"'

# Set sparse checkout (experimental)
dotfiles config --local core.sparseCheckout true

# config should always be local
dotfiles config --local alias.config "config --local"
```

#### 5. Setup your configuration branch

The main branch should not have any personal dotfiles. Dotfiles are yours.


##### Change master to main

```
dotfiles branch -m main
```

##### Create an empty branch

```
dotfiles commit --allow-empty -m "Initial commit"
```

##### Create a new branch for your dotfiles

```
dotfiles checkout HEAD -b ${HOME##*/}
```

#### 6. Ignore sensitive files

Ignore your sensitive resources Ignore sensitive files and directories in
.cfg/info/exclude

```
echo "/.gnupg" >> $HOME/.cfg/info/exclude
echo "/.ssh" >> $HOME/.cfg/info/exclude
```

## Usage

When you are setup, you can then use your `dotfiles` alias to manage your configuration like a git repository. It is recommended that you be intentional about what you add.

```
dotfiles add .bashrc .bash_profile
dotfiles commit -m "Add bash configuration"
```

### Push

To push your local commits to a remote repository

```
dotfiles push
```

### Set up on a new machine

If you are past the stage of setting up on a previous machine and you already have a repository just create the same setup here.

```
git clone --bare git@git@github.com:smurfpapa/dotfiles.git $HOME/.cfg
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

### Backup current directory

Let's backup what is about to be replaced. First we will create our backup directory and mirror what will be replace into that directory.

```
DOTFILES_BRANCH="smurfpapa" # match your branch name
$DOTFILES_BACKUP="$HOME/.dotfiles/backup/$DOTFILES_BRANCH"

mkdir -pv $DOTFILES_BACKUP
dotfiles ls-tree -r --name-only $DOTFILES_BRANCH | rsync -aivcP --files-from=- $HOME $DOTFILES_BACKUP/
```

This does not delete the files currently in your directory.

### Archive your dotfiles

Archive your dotfiles for transport

```
dotfiles archive --format=tar.gz -o dotfiles.tar.gz --prefix=$(dotfiles rev-parse --abbrev-ref HEAD)/ HEAD
```

### Pull

When you ready sync your changes, just pull them together.

```
dotfiles pull
```

### Branching

When you want to have separate configurations you can create a branch

```
dotfiles branch fancy
dotfiles checkout fancy
```

### Getting Help

The `dotfiles` alias is just git so you can get help for any command using
`git` or the alias

```
dotfiles help <comand>
```

********

These are just a few examples of how the `dotfiles` alias can be used. Feel
free to fork and contribute.
