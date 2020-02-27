# RainFall [[42](https://www.42.fr/) project]

## Passwords

```bash
su level0 -> level0

su level1 -> 1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a
su level2 -> 53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
su level3 -> 492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
```

To personalize you bash prompt ([more here](http://ezprompt.net/))
```
export PS1="\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \$ "

function nonzero_return() { RETVAL=$? ; [ $RETVAL -ne 0 ] && echo "$RETVAL "; } ; export PS1="\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[31m\]\`nonzero_return\`\[\e[m\]\$ ";
```

Use peda
```bash
git clone https://github.com/longld/peda ~/Desktop/peda
sshpass -p level0  scp -r -P 4242 ~/Desktop/peda level0@10.11.200.132:/tmp/peda
```

Send file to gdb
```bash
function sendssh() {
	# name password ip src dest
	while [ 1 ]; do
		clear
		date
		sshpass -p $2  scp -P 4242 $4 $1@$3:$5
		sleep 1
	done
}

function sendsshInit() {
	# name password ip bashrc
	git clone https://github.com/longld/peda /tmp/peda
	sshpass -p $2  scp -r -P 4242 /tmp/peda $1@$3:/tmp/peda
	sshpass -p $2  scp -P 4242 $4 $1@$3:/tmp/bashrc
}

sendssh level0 level0 10.11.200.132 bashrc
```
---

See more on the school [subject](fr.subject.pdf).