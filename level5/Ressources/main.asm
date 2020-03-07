; -- main ----------------------------------------------------------------------
0x08048504 <+0>:	push   %ebp
0x08048505 <+1>:	mov    %esp, %ebp

0x08048507 <+3>:	and    $0xfffffff0, %esp  ; to keep 16-byte stack alignment
0x0804850a <+6>:	call   0x80484c2 <n>  ; call n

0x0804850f <+11>:	leave
0x08048510 <+12>:	ret

; -- n function ----------------------------------------------------------------
0x080484c2 <+0>:	push   %ebp
0x080484c3 <+1>:	mov    %esp, %ebp

0x080484c5 <+3>:	sub    $0x218, %esp  ; allocate 0x218(536)bytes for locals vars
0x080484cb <+9>:	mov    0x8049848, %eax  ; %eax = 0x8049848
0x080484d0 <+14>:	mov    %eax, 0x8(%esp)  ; esp+0x8 = eax  ; == 0x8049848
0x080484d4 <+18>:	movl   $0x200, 0x4(%esp)  ; esp+0x4 = 0x200  ; == 512
0x080484dc <+26>:	lea    -0x208(%ebp), %eax  ; declare a 520 bytes var
; 0x208 -> 520 bytes
0x080484e2 <+32>:	mov    %eax, (%esp)  ; set fgets buffer param
0x080484e5 <+35>:	call   0x80483a0 <fgets@plt>

0x080484ea <+40>:	lea    -0x208(%ebp), %eax
0x080484f0 <+46>:	mov    %eax, (%esp)  ; set buff as printf arg
0x080484f3 <+49>:	call   0x8048380 <printf@plt>

0x080484f8 <+54>:	movl   $0x1, (%esp)  ; set exit argument
0x080484ff <+61>:	call   0x80483d0 <exit@plt>  ; call exit

; -- o function ----------------------------------------------------------------
0x080484a4 <+0>:	push   %ebp
0x080484a5 <+1>:	mov    %esp, %ebp

0x080484a7 <+3>:	sub    $0x18, %esp  ; allocate 0x18(24)bytes for locals vars
0x080484aa <+6>:	movl   $0x80485f0, (%esp)  ; set 0x80485f0 arg to system
; x/s 0x80485f0
; 0x80485f0:	 "/bin/sh"
0x080484b1 <+13>:	call   0x80483b0 <system@plt>  ; call system

0x080484b6 <+18>:	movl   $0x1, (%esp)  ; set exit argument
0x080484bd <+25>:	call   0x8048390 <_exit@plt>  ; call exit
