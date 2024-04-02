# User specific aliases and functions
alias ls='ls --color=always'
alias ll='ls -l'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias rm='rm -iv --preserve-root'
alias mv='mv -iv'
alias cp='cp -v'
alias chmod='command chmod -c'
alias cpr='command cp -rpv'
alias df='command df -kTh'
alias df1='command df -iTa'
alias diff='diff -up'
alias dsiz='du -sk * | sort -n --'
alias du='command du -kh'
alias du1='echo *|tr " " "\n" |xargs -iFF command du -hs FF|sort'
alias env='command env | sort'
alias h='history'
alias inice='ionice -c3 -n7 nice'
alias j='jobs -l'
alias la='command ls -Al --color=auto'
alias lc='command ls -lAcr --color=auto'
alias lk='command ls -lASr --color=auto'
alias llh='ll -h'
alias lll='stat -c %a\ %N\ %G\ %U ${PWD}/*|sort'
alias lr='command ls -lAR --color=auto'
alias lt='command ls -lAtr --color=auto'
alias lu='command ls -lAur --color=auto'
alias lx='command ls -lAXB --color=auto'
alias mann='command man -H'
alias p='command ps -HAcl -F S -A f|uniq -w3'
alias path='echo -e ${PATH//:/\\n}'
alias pp='command ps -HAcl -F S -A f'
alias ps1='command ps -lFA'
alias ps2='command ps -H'
alias resetw='echo $'\''\33[H\33[2J'\'''
alias subash='sudo sh -c '\''export HOME=/root; cd /root; exec bash -l'\'''
alias top='top -c'
#alias tree='command tree -Csuflapi'
alias who='command who -ar -pld'
alias wtf='watch -n 1 w -hs'
# dotfiles https://www.atlassian.com/git/tutorials/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'



alias "lsperm=ls -al|awk '{k=0;s=0;for(i=0;i<=8;i++){;k+=((substr(\$1,i+2,1)~/[rwxst]/)*2^(8-i));};j=4;for(i=4;i<=10;i+=3){;s+=((substr(\$1,i,1)~/[stST]/)*j);j/=2;};if(k){;printf(\"%0o%0o \",s,k);};print;}'"
alias digdomain='dig +short -x'
alias digipaddress='dig +short @8.8.8.8'
alias busy='my_file=$(find /usr/include -type f | sort -r | head -n 1); my_len=$(wc -l $my_file | awk "{print \$1}"); let "r = $RANDOM % $my_len" 2>/dev/null; vim +$r $my_file'
alias number_connections="netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n"
alias listening_ports="sudo lsof -i -P | grep -i 'listen' | awk '{print \$3, \$1, \$9}' | sort | uniq | sed 's/ [a-z0-9\.\*]*:/ /' | sort -k 3 -n"
alias rosa='ssh rosa'
alias grace='ssh grace'
alias harry='ssh harry'
alias ben='ssh ben'
alias jerry='ssh jerry'
alias vtstalk='ldapsearch -H ldap://directory.vt.edu -Y EXTERNAL -ZZb ou=People,dc=vt,dc=edu'
alias eclimd="$ECLIPSE_HOME/eclimd"
alias mirror="wget --mirror --no-parent --convert-links  --page-requisites --no-host-directories"
#alias php-ctags='ctags-exuberant -f TAGS -h \".php.phtml\" -R  --exclude=\"\.svn\" --totals=yes --tag-relative=yes --PHP-kinds=+cf --regex-PHP="/abstract class ([^ ]*)/\1/c/" --regex-PHP="/interface ([^ ]*)/\1/c/" --regex-PHP="/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/"'
alias php-ctags='ctags -R -f TAGS --languages=php --fields=+laimS -h \".php.phtml\"'
alias gvim='gvim --servername `set_gvim_servername` --remote-tab-silent'
alias urldecode='sed -e"s/%\([0-9A-F][0-9A-F]\)/\\\\\x\1/g" | xargs echo -e'
alias combinepdf='gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combinedpdf.pdf -dBATCH'
alias apt-search='apt-cache search'
alias gource-screensaver='gource -a 3 -s 1 -c 4 -f --title "`cat ./.git/description`" --key --loop --user-image-dir ./.git/avatar/ && gnome-screensaver-command -l'
alias git-gource='gource -a 3 -s 1 -c 4 --title "`cat ./.git/description`" --key --loop --user-image-dir ./.git/avatar/'
alias java-debug='java -Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,suspend=y,server=y,address=localhost:8888'
alias mvn-debug='mvn -Dmaven.surefire.debug="-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,suspend=y,server=y,address=localhost:8888"'
alias haml="haml -q --cdata --unix-newlines"
alias term-title-dir="set_term_title ${PWD##*/}"
alias password-generate="dd if=/dev/urandom bs=6 count=1 2> /dev/null | base64"



# php_beautifier -r -l "ArrayNested() IndentStyles(style=k&r) Lowercase()" -t "*.php*" ./b/

#
# Returns the working directory of a git or mercurial repository
set_gvim_servername() {
	SVRNAME=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
	if [ -z $SVRNAME ]
	then
		SVRNAME=$(basename `hg root 2> /dev/null` 2> /dev/null)
	fi
	if [ -z $SVRNAME ]
	then
		SVRNAME=${PWD##*/}
	fi
	echo $SVRNAME;
}

# This shell function grabs the weather forecast for the next 24 to 48 hours 
# from weatherunderground.com. Replace <YOURZIPORLOCATION> with your zip code
# or your "city, state" or "city, country", then calling the function without
# any arguments returns the weather for that location. Calling the function
# with a zip code or place name as an argument returns the weather for that
# location Instead of your default.
# see: http://www.reddit.com/r/bashtricks/comments/b1j5y/get_the_weather_forecast_for_the_next_24_to_48/
weather(){
         curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOCATION>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"';
}

# map() function
# The map function should be familiar to anyone that's had any experience with
# functional programming languages. This map function takes a command with any
# number of arguments and applies it to each item in a list. It's basically a
# shorthand way of writing a for loop.
# see: http://www.reddit.com/r/bashtricks/comments/aks3u/a_functional_programming_style_map_function_for/
#
# Syntax
# ------
# The syntax is map COMMAND: ITEM1 ITEM2 ITEM3 ...
# The space following the colon is required. Space preceding it is optional.
map(){
    local command
    if [ $# -lt 2 ] || [[ ! "$@" =~ :[[:space:]] ]];then
        echo "Invalid syntax." >&2; return 1
    fi
    until [[ $1 =~ : ]]; do
        command="$command $1"; shift
    done
    command="$command ${1%:}"; shift
    for i in "$@"; do
        eval "${command//\\/\\\\} \"${i//\\/\\\\}\""
    done
}   

# calc() function
# Syntax
# ------
# calc 10+2*3
calc () { echo "scale=100; $*" | bc -l; }

# vt-liaison()
# Usage
# ------------
# To find out the liason for www.vtti.vt.edu
# vt-liaison vtti
vt-liaison () {
  dig "nsdata.$1.vt.edu" +noall +answer +short TXT | grep 'admin-c';
}


# which()
# Usage
# -----
# use type if it is a function
# which arg
which() {
	/usr/bin/which $@ || type $@;
}

#
# Set the terminal title
#
set_term_title(){
   echo -en "\033]0;$1\a"
}

if [ -f /usr/share/doc/git/contrib/completion/git-completion.bash ]; then
	source /usr/share/doc/git/contrib/completion/git-completion.bash
fi

if [ -f /usr/share/doc/git/contrib/completion/git-prompt.sh ]; then
	source /usr/share/doc/git/contrib/completion/git-prompt.sh
fi

git_terminal_title() {
	[[ $(__gitdir) == ".git" ]] && is_git=$PWD || is_git=$(dirname $(__gitdir) 2>/dev/null);
	is_hg=`hg root 2>/dev/null`;
	[[ $is_git ]] && is_scm_dir=$is_git || is_scm_dir=$is_hg;
	if [[ $is_scm_dir ]]; then
		set_term_title $(basename $is_scm_dir )
	else
		set_term_title $(basename $PWD)
	fi
}

parse_branch() {
	hg_root=`hg root 2>/dev/null`
	if [[ "$hg_root" ]]; then
		branch=`hg branch 2> /dev/null`
		[[ -f $hg_root/.hg/bookmarks.current ]] && bookmark=`cat "$hg_root/.hg/bookmarks.current"`
		if [[ "$bookmark" ]]; then
			bookmark=":$bookmark";
		fi
		echo "($branch$bookmark)";
	fi
	__git_ps1 "(%s)";
	# use the second line instead if you have bash autocompletion for git enabled
}

#PS1='\[\033[G\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
PS1="\$(parse_branch)$PS1"
PS1="\A $PS1"

PROMPT_COMMAND=git_terminal_title

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/jonavon/.gvm/bin/gvm-init.sh" ]] && source "/home/jonavon/.gvm/bin/gvm-init.sh"
