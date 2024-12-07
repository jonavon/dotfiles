BASH_INCLUDES="${HOME}/.bashrc.d/includes"

while read -r file; do
	source "$file"
done < <(find ${BASH_INCLUDES} -type f -exec grep -I -q . \{\} \; -print)


# Load Angular CLI autocompletion.
#source <(ng completion script)
