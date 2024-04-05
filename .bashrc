# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
#

# User specific aliases and functions

BASH_INCLUDES="${HOME}/.bashrc.d/includes"

while read -r file; do
	source "$file"
done < <(find ${BASH_INCLUDES} -type f -exec grep -I -q . \{\} \; -print)
