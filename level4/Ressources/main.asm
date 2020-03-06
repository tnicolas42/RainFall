; -- main ----------------------------------------------------------------------
0x080484a7 <+0>:	push   %ebp
0x080484a8 <+1>:	mov    %esp,%ebp
0x080484aa <+3>:	and    $0xfffffff0, %esp  ; to keep 16-byte stack alignment

0x080484ad <+6>:	call   0x8048457 <n>  ; call n function

0x080484b2 <+11>:	leave
0x080484b3 <+12>:	ret

; -- n function ----------------------------------------------------------------
0x08048457 <+0>:	push   %ebp
0x08048458 <+1>:	mov    %esp, %ebp

0x0804845a <+3>:	sub    $0x218, %esp  ; allocate 0x218(536)bytes for locals vars
0x08048460 <+9>:	mov    0x8049804, %eax  ; %eax = 0x8049804
0x08048465 <+14>:	mov    %eax, 0x8(%esp)  ; esp+0x8 = eax  ; == 0x8049804
0x08048469 <+18>:	movl   $0x200, 0x4(%esp)  ; esp+0x4 = 0x200  ; == 512
0x08048471 <+26>:	lea    -0x208(%ebp), %eax  ; declare a 520 bytes var
; 0x208 -> 520 bytes
0x08048477 <+32>:	mov    %eax, (%esp)  ; set fgets buffer param
0x0804847a <+35>:	call   0x8048350 <fgets@plt>

0x0804847f <+40>:	lea    -0x208(%ebp), %eax
0x08048485 <+46>:	mov    %eax, (%esp) ; set the buffer as p param
0x08048488 <+49>:	call   0x8048444 <p>  ; call p function

0x0804848d <+54>:	mov    0x8049810, %eax  ; eax = 0x8049810
0x08048492 <+59>:	cmp    $0x1025544, %eax
0x08048497 <+64>:	jne    0x80484a5 <n+78>  ; if *eax != 0x1025544

0x08048499 <+66>:	movl   $0x8048590, (%esp)  ; set 0x8048590 as arg
; x/s 0x8048590  ; 0x8048590:  "/bin/cat /home/user/level5/.pass"
0x080484a0 <+73>:	call   0x8048360 <system@plt>  ; call system func

0x080484a5 <+78>:	leave
0x080484a6 <+79>:	ret


; -- p function ----------------------------------------------------------------
0x08048444 <+0>:	push   %ebp
0x08048445 <+1>:	mov    %esp,%ebp

0x08048447 <+3>:	sub    $0x18, %esp  ; allocate 0x18(24)bytes for locals vars
0x0804844a <+6>:	mov    0x8(%ebp), %eax  ; retrieve buff
0x0804844d <+9>:	mov    %eax, (%esp)  ; set buff as printf arg
0x08048450 <+12>:	call   0x8048340 <printf@plt>

0x08048455 <+17>:	leave
0x08048456 <+18>:	ret
