; -- main ----------------------------------------------------------------------
0x08048521 <+0>:	push   %ebp
0x08048522 <+1>:	mov    %esp, %ebp
0x08048524 <+3>:	and    $0xfffffff0, %esp


0x08048527 <+6>:	sub    $0x20, %esp  ; allocate 0x20(32)bytes for locals vars
0x0804852a <+9>:	movl   $0x8, (%esp)  ; set malloc arg to 8
0x08048531 <+16>:	call   0x80483f0 <malloc@plt>  ; call malloc(8)
0x08048536 <+21>:	mov    %eax, 0x1c(%esp)  ; a = malloc result
0x0804853a <+25>:	mov    0x1c(%esp), %eax  ; a = a ???
0x0804853e <+29>:	movl   $0x1, (%eax)  ; a = (long)0x1

0x08048544 <+35>:	movl   $0x8, (%esp)  ; set malloc arg to 8
0x0804854b <+42>:	call   0x80483f0 <malloc@plt>  ; call malloc(8)
0x08048550 <+47>:	mov    %eax, %edx  ; edx = malloc result
0x08048552 <+49>:	mov    0x1c(%esp), %eax  ; eax = a
0x08048556 <+53>:	mov    %edx, 0x4(%eax)  ; a + 4 = malloc result   (a[1])


0x08048559 <+56>:	movl   $0x8, (%esp)  ; set malloc arg to 8
0x08048560 <+63>:	call   0x80483f0 <malloc@plt>  ; call malloc(8)
0x08048565 <+68>:	mov    %eax, 0x18(%esp)  ; b = malloc result
0x08048569 <+72>:	mov    0x18(%esp), %eax  ; b = b ???
0x0804856d <+76>:	movl   $0x2, (%eax)  ; b = (long)0x2

0x08048573 <+82>:	movl   $0x8, (%esp)  ; set malloc arg to 8
0x0804857a <+89>:	call   0x80483f0 <malloc@plt>  ; call malloc(8)
0x0804857f <+94>:	mov    %eax, %edx  ; edx = malloc result
0x08048581 <+96>:	mov    0x18(%esp), %eax  ; eax = b
0x08048585 <+100>:	mov    %edx, 0x4(%eax)  ; b + 4 = malloc result  (b[1])


0x08048588 <+103>:	mov    0xc(%ebp), %eax  ; eax = ebp + 0xc    & av[0]
0x0804858b <+106>:	add    $0x4, %eax ; eax += 4    & av[1]
0x0804858e <+109>:	mov    (%eax), %eax  ; eax = *eax    av[1]
0x08048590 <+111>:	mov    %eax, %edx  ; edx = eax    av[1]

0x08048592 <+113>:	mov    0x1c(%esp), %eax  ; eax = a
0x08048596 <+117>:	mov    0x4(%eax), %eax  ; eax += 4     (a[1])

0x08048599 <+120>:	mov    %edx, 0x4(%esp)  ; set strcpy src arg to av[1]
0x0804859d <+124>:	mov    %eax, (%esp)  ; set strcpy dest arg to str a[1]
0x080485a0 <+127>:	call   0x80483e0 <strcpy@plt>  ; strcpy(a[1], av[1])
; a[1] = av[1] copy


0x080485a5 <+132>:	mov    0xc(%ebp), %eax  ; eax = ebp + 0xc    & av[0]
0x080485a8 <+135>:	add    $0x8, %eax  ; eax += 8    & av[2]
0x080485ab <+138>:	mov    (%eax), %eax  ; eax = *eax    av[2]
0x080485ad <+140>:	mov    %eax, %edx  ; edx = eax    av[2]

0x080485af <+142>:	mov    0x18(%esp), %eax  ; eax = b
0x080485b3 <+146>:	mov    0x4(%eax), %eax  ; eax += 4    (b[1])
0x080485b6 <+149>:	mov    %edx, 0x4(%esp)  ; set strcpy src arg to av[2]
0x080485ba <+153>:	mov    %eax, (%esp)  ; set strcpy dest arg to str b[1]
0x080485bd <+156>:	call   0x80483e0 <strcpy@plt>  ; strcpy(b[1], av[2])
; b[1] = av[2] copy

0x080485c2 <+161>:	mov    $0x80486e9, %edx  ; edx = "r"
; 0x80486e9:	 "r"
0x080485c7 <+166>:	mov    $0x80486eb, %eax  ; eax = "/home/user/level8/.pass"
; 0x80486eb:	 "/home/user/level8/.pass"
0x080485cc <+171>:	mov    %edx, 0x4(%esp)  ; set fopen 2nd arg to "r"
0x080485d0 <+175>:	mov    %eax, (%esp)  ; set fopen 1st arg to "/home/user/level8/.pass"
0x080485d3 <+178>:	call   0x8048430 <fopen@plt>  ; fopen("/home/user/level8/.pass", "r")

0x080485d8 <+183>:	mov    %eax, 0x8(%esp)  ; fgetd 3rd arg to fopen res
0x080485dc <+187>:	movl   $0x44, 0x4(%esp)  ; fgets 2nd arg to 68
0x080485e4 <+195>:	movl   $0x8049960, (%esp)  ; fgets 1st arg to 0x8049960
0x8049960 <c>:	0x00000000
0x080485eb <+202>:	call   0x80483c0 <fgets@plt>  ; fgets(0x8049960, 68, fp)

0x080485f0 <+207>:	movl   $0x8048703, (%esp)  ; puts 1st arg to "~~"
; 0x8048703:	 "~~"
0x080485f7 <+214>:	call   0x8048400 <puts@plt>  ; puts("~~", 68)
0x080485fc <+219>:	mov    $0x0, %eax  ; eax = 0

0x08048601 <+224>:	leave
0x08048602 <+225>:	ret

; -- m function ----------------------------------------------------------------
80484f4:	55                   	push   %ebp
80484f5:	89 e5                	mov    %esp, %ebp


8048517:	89 14 24             	mov    %edx, (%esp)
804851a:	e8 91 fe ff ff       	call   80483b0 <printf@plt>


0x080484f7 <+3>:	sub    $0x18, %esp  ; allocate 0x18(24)bytes for locals vars
0x080484fa <+6>:	movl   $0x0, (%esp)  ; set time arg to NULL
0x08048501 <+13>:	call   0x80483d0 <time@plt>  ; call time(NULL)

0x08048506 <+18>:	mov    $0x80486e0, %edx  ; edx = "%s - %d\n"
; x/s 0x80486e0  ->  0x80486e0:	 "%s - %d\n"
0x0804850b <+23>:	mov    %eax, 0x8(%esp)  ; set printf third arg to time() return value
0x0804850f <+27>:	movl   $0x8049960, 0x4(%esp)  ; set printf second arg to c
; x/s 0x8049960  ->  0x8049960 <c>:	 ""
0x08048517 <+35>:	mov    %edx, (%esp)  ; set printf first arg to "%s - %d\n"
0x0804851a <+38>:	call   0x80483b0 <printf@plt>  ; call printf("%s - %d\n", "", time(NULL))


804851f:	c9                   	leave
8048520:	c3                   	ret
