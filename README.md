# RainFall [[42](https://www.42.fr/) project]

## Passwords

```bash
su level0 -> level0

su level1 -> 1fe8a524fa4bec01ca4ea2a869af2a02260d4a7d5fe7e7c24d8617e6dca12d3a
su level2 -> 53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
su level3 -> 492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
su level4 -> b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa
su level5 -> 0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a
su level6 -> d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31
su level7 -> f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d
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