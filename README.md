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
su level8 -> 5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9
su level9 -> c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a
su bonus0 -> f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728
su bonus1 -> cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9
su bonus2 -> 579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245
su bonus3 -> 71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
su end -> 3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c
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

sendsshInit level0 level0 10.11.200.132 bashrc
```

## connection with ngrok
Install
```bash
[linux]
sudo snap install ngrok
[osx]
brew cask install ngrok
```
Create account on https://ngrok.com/ and `ngrok authtoken <token>`

Launch the VM and connect:
```bash
# ssh -L 4243:0.0.0.0:4242 <user>@<ip> -p4242
> ssh -L 4243:0.0.0.0:4242 level0@192.168.1.89 -p4242
```
In another terminal, launch ngrok:
```bash
> ngrok tcp 4243
```

In any term, connect with:
```bash
# ssh <user>@0.tcp.ngrok.io -p <port>
> ssh level0@0.tcp.ngrok.io -p 11561
```


---

See more on the school [subject](fr.subject.pdf).