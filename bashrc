function nonzero_return() {
	RETVAL=$? ; [ $RETVAL -ne 0 ] && echo "$RETVAL "
}
export PS1="\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[31m\]\`nonzero_return\`\[\e[m\]\$ "

alias gdb='gdb --eval-command="source /tmp/peda/peda.py"'
alias g='gdb --eval-command="source /tmp/peda/peda.py"'
alias gmain='gdb --eval-command="source /tmp/peda/peda.py" --eval-command="pd main"'

export LC_ALL="en_US.UTF-8"
