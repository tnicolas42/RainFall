; -- main ----------------------------------------------------------------------
0x0804847c <+0>:	push   %ebp
0x0804847d <+1>:	mov    %esp, %ebp

0x0804847f <+3>:	and    $0xfffffff0, %esp  ; to keep 16-byte stack alignment

0x08048482 <+6>:	sub    $0x20, %esp  ; allocate 0x20(32)bytes for locals vars
0x08048485 <+9>:	movl   $0x40, (%esp)  ; set malloc arg to 64
0x0804848c <+16>:	call   0x8048350 <malloc@plt>  ; call malloc(64)
0x08048491 <+21>:	mov    %eax, 0x1c(%esp)  ; str = malloc result

0x08048495 <+25>:	movl   $0x4, (%esp)  ; set malloc arg to 4
0x0804849c <+32>:	call   0x8048350 <malloc@plt>  ; call malloc(4)
0x080484a1 <+37>:	mov    %eax, 0x18(%esp)  ; fPtr = malloc result
0x080484a5 <+41>:	mov    $0x8048468, %edx  ; edx = $0x8048468
; 0x08048468 is the address of the hidden function `m`
0x080484aa <+46>:	mov    0x18(%esp), %eax  ; eax = fPtr
0x080484ae <+50>:	mov    %edx, (%eax)  ; fPtr = &m

0x080484b0 <+52>:	mov    0xc(%ebp), %eax  ; eax = argv
; EAX: 0xbffff7a4 --> 0xbffff8c6 ("/home/user/level6/level6")
0x080484b3 <+55>:	add    $0x4, %eax  ; eax = argv + 1
; EAX: 0xbffff7a8 --> 0xbffff8df ("aaaa") (-> r aaaa)
0x080484b6 <+58>:	mov    (%eax), %eax  ; eax = argv[1]
0x080484b8 <+60>:	mov    %eax, %edx  ; edx = argv[1]

0x080484ba <+62>:	mov    0x1c(%esp), %eax  ; eax = str
0x080484be <+66>:	mov    %edx, 0x4(%esp)  ; set strcpy src arg to argv[1]
0x080484c2 <+70>:	mov    %eax, (%esp)  ; set strcpy dest arg to str char*
0x080484c5 <+73>:	call   0x8048340 <strcpy@plt>  ; strcpy(str, argv[i])

0x080484ca <+78>:	mov    0x18(%esp), %eax  ; eax = fPtr
0x080484ce <+82>:	mov    (%eax), %eax  ; eax = *fPtr
0x080484d0 <+84>:	call   *%eax  ; call (*fPtr)();

0x080484d2 <+86>:	leave
0x080484d3 <+87>:	ret

; ^_ stack growth
;
; esp					esp-32			esp-0x20
;   ...
; esp+4   argv[1]
;
; ...
; esp+24  fPtr
;
;
;
; esp+28  str
;
;
;
; ebp					esp+32
; return address
; arg 2
; arg 1
; ...

; -- m function ----------------------------------------------------------------
0x08048468 <+0>:	push   %ebp
0x08048469 <+1>:	mov    %esp, %ebp

0x0804846b <+3>:	sub    $0x18, %esp  ; allocate 0x18(24)bytes for locals vars
0x0804846e <+6>:	movl   $0x80485d1, (%esp)  ; set puts arg to 0x80485d1
; 0x80485d1:	 "Nope"
0x08048475 <+13>:	call   0x8048360 <puts@plt>  ; call puts("Nope")

0x0804847a <+18>:	leave
0x0804847b <+19>:	ret

; -- n function ----------------------------------------------------------------
0x08048454 <+0>:	push   %ebp
0x08048455 <+1>:	mov    %esp, %ebp

0x08048457 <+3>:	sub    $0x18, %esp  ; allocate 0x18(24)bytes for locals vars
0x0804845a <+6>:	movl   $0x80485b0, (%esp)  ; set system arg to 0x80485b0
; 0x80485b0:  "/bin/cat /home/user/level7/.pass"
0x08048461 <+13>:	call   0x8048370 <system@plt>  ; call system("/bin/cat /home/user/level7/.pass")

0x08048466 <+18>:	leave
0x08048467 <+19>:	ret
