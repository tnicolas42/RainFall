; -- main ----------------------------------------------------------------------
0x08048424 <+0>:	push   %ebp
0x08048425 <+1>:	mov    %esp, %ebp
0x08048427 <+3>:	and    $0xfffffff0, %esp

0x0804842a <+6>:	sub    $0x40, %esp  ; allocate 64bits for locals vars
0x0804842d <+9>:	mov    0xc(%ebp), %eax  ; eax = &(av[0])
0x08048430 <+12>:	add    $0x4, %eax  ; eax = &(av[1])
0x08048433 <+15>:	mov    (%eax), %eax  ; eax = av[1]
0x08048435 <+17>:	mov    %eax, (%esp)  ; 1st arg = av[1]
0x08048438 <+20>:	call   0x8048360 <atoi@plt>  ; atoi(av[1])
0x0804843d <+25>:	mov    %eax, 0x3c(%esp)  ; nb = atoi res
0x08048441 <+29>:	cmpl   $0x9, 0x3c(%esp)  ; compare nb with 9
0x08048446 <+34>:	jle    0x804844f <main+43>  ; if nb <= 9 jump

0x08048448 <+36>:	mov    $0x1, %eax  ; eax = 1
0x0804844d <+41>:	jmp    0x80484a3 <main+127>  ; jump main+127

0x0804844f <+43>:	mov    0x3c(%esp), %eax  ; eax = nb
0x08048453 <+47>:	lea    0x0(, %eax, 4), %ecx  ; ecx = nb * 4
0x0804845a <+54>:	mov    0xc(%ebp), %eax  ; eax = &(av[0])
0x0804845d <+57>:	add    $0x8, %eax  ; eax = &(av[2])
0x08048460 <+60>:	mov    (%eax), %eax  ; eax = av[2]
0x08048462 <+62>:	mov    %eax, %edx  ; edx = av[2]
0x08048464 <+64>:	lea    0x14(%esp), %eax  ; eax = str
0x08048468 <+68>:	mov    %ecx, 0x8(%esp)  ; 3rd arg = nb * 4
0x0804846c <+72>:	mov    %edx, 0x4(%esp)  ; 2nd arg = av[2]
0x08048470 <+76>:	mov    %eax, (%esp)  ; 1st arg = str
0x08048473 <+79>:	call   0x8048320 <memcpy@plt>  ; memcpy(str, av[2], nb*4)

0x08048478 <+84>:	cmpl   $0x574f4c46, 0x3c(%esp)  ; compare nb with 1464814662
0x08048480 <+92>:	jne    0x804849e <main+122>  ; leave if nb != 1464814662

0x08048482 <+94>:	movl   $0x0, 0x8(%esp)  ; 3rd arg = 0
0x0804848a <+102>:	movl   $0x8048580, 0x4(%esp)  ; 2nd arg = "sh"
0x08048492 <+110>:	movl   $0x8048583, (%esp)  ; 1st arg = "/bin/sh"
0x08048499 <+117>:	call   0x8048350 <execl@plt>  ; execl("/bin/sh", "sh")
0x0804849e <+122>:	mov    $0x0, %eax  ; return 0

0x080484a3 <+127>:	leave
0x080484a4 <+128>:	ret
