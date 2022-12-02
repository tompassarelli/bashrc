#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# _temp reminders
echo "don't upgrade pacman until unpinning libx11 in /etc/pacman.conf !"

# orginal tty prompt for reference
#PS1='[\u@\h \W]\$ '
alias ls='ls --color=auto'


### bashrc prompt
## remove @user@hostname,
## prompt transformation (purple) -> [~]: 
## created with https://bashrcgenerator.com/
## use with tango color scheme
export PS1="\[\033[38;5;105m\][\w]\[$(tput sgr0)\] \[$(tput sgr0)\]"

### python 

## - pipenv don't break virtualenv on path change
export PIPENV_VENV_IN_PROJECT=1 

## - python helpers 
## make package directory
t-py-pack () {
  ## arg1: name of package dir
  mkdir $1 
  touch $1/__init__.py
}

### ydotool, xcape
export YDOTOOL_SOCKET="/tmp/.ydotool.socket"
## ydotool keycodes: "/usr/include/linux/input-event-codes.h"
## xmodmap keycodes "/usr/include/X11/keysymdef.h"

### _PATH 
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin

### _alias
alias sudo='sudo -v; sudo '
alias .b="source $HOME/.bashrc"
alias .be="vim $HOME/.bashrc"

## run without terminal in background
alias doemacs="exec emacs & exit"
alias doff="exec firefox & exit"


### github cli | git helpers
## [ ] gitw1: make this local proj a proj on github and sync
## [ ] gitw2: I'm creating a new proj... one-shot make proj and sync
t-gh-gitw1 () {
	git init
	gh repo create $1 $2 # [name] [flags]
       	touch README.md
	echo "first commit" > README.md
	git remote add origin [<name>] # [name]
	git add --all 
	git commit -m "first commit"
}

### script helper

t-sh () {
	script_name=$1
	if [ -z $1 ]
	then 
	  script_name="testscript"
	fi
	touch $script_name
	chmod +x $script_name
	echo '#!/usr/bin/env bash' >> $script_name
	vim $script_name
}

## symlink scripts to /usr/local/bin for keyboard hotkey
t-sh-ln () {
	## arg 1 : filename 
	##
	## .sh is kept on for formatting, obv when ready, trim it off
	TRIM_EXT=$(sed -i 's/.sh//g' $1)
  	sudo ln -s $PWD/$1 /usr/local/bin/$TRIM_EXT
}

## copy shebang to clipboard
t-sh-bang() {
  	echo '#!/usr/bin/env bash' | xclip -sel clip
}


### symlink helpers
t-gosym () {
    ## cd from symlink to the original file
    cd "$(dirname "$(readlink "$1")")";  
}

### pacman helper, currently just list sizes of installed packages
t-pac () {
	LC_ALL=C.UTF-8 pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}

