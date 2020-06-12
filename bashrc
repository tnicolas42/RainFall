function nonzero_return() {
	RETVAL=$? ; [ $RETVAL -ne 0 ] && echo "$RETVAL "
}
export PS1="\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[31m\]\`nonzero_return\`\[\e[m\]\$ "

if [[ -d /tmp/peda ]]; then
	alias gdb='gdb --eval-command="source /tmp/peda/peda.py"'
else
	# display /3i $pc
	alias gdb='gdb --eval-command="set disassembly-flavor intel"'
fi

export LC_ALL="en_US.UTF-8"
