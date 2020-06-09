; -- main ----------------------------------------------------------------------
0x080485f4 <+0>:	push   %ebp
0x080485f5 <+1>:	mov    %esp, %ebp
0x080485f7 <+3>:	push   %ebx
0x080485f8 <+4>:	and    $0xfffffff0, %esp

0x080485fb <+7>:	sub    $0x20, %esp  ; allocate 32 bytes for locals vars
0x080485fe <+10>:	cmpl   $0x1, 0x8(%ebp)
0x08048602 <+14>:	jg     0x8048610 <main+28>  ; jump if av[1] < 1

0x08048604 <+16>:	movl   $0x1, (%esp)  ; esp = 1
0x0804860b <+23>:	call   0x80484f0 <_exit@plt>  ; exit(1)

0x08048610 <+28>:	movl   $0x6c, (%esp)  ; 1st arg to 108
0x08048617 <+35>:	call   0x8048530 <_Znwj@plt>  ; call _Znwj(108)

0x0804861c <+40>:	mov    %eax, %ebx  ; ebx = _Znwj res
0x0804861e <+42>:	movl   $0x5, 0x4(%esp)  ; 2nd arg to 5
0x08048626 <+50>:	mov    %ebx, (%esp)  ; 1st arg to _Znwj res
0x08048629 <+53>:	call   0x80486f6 <_ZN1NC2Ei>  ; call obj1->i(5)


0x0804862e <+58>:	mov    %ebx, 0x1c(%esp)  ; obj1 = _Znwj res
0x08048632 <+62>:	movl   $0x6c, (%esp)  ; 1st arg to 108
0x08048639 <+69>:	call   0x8048530 <_Znwj@plt>  ; call _Znwj(108, 5)
0x0804863e <+74>:	mov    %eax, %ebx  ; ebx = eax

0x08048640 <+76>:	movl   $0x6, 0x4(%esp)  ; 2nd arg to 6
0x08048648 <+84>:	mov    %ebx, (%esp)  ; 1st arg to _Znwj res
0x0804864b <+87>:	call   0x80486f6 <_ZN1NC2Ei>  ; call onj2->i(6)
0x08048650 <+92>:	mov    %ebx, 0x18(%esp)  ; obj2 =  _Znwj res
0x08048654 <+96>:	mov    0x1c(%esp), %eax  ; eax = obj1
0x08048658 <+100>:	mov    %eax, 0x14(%esp)  ; obj3 = obj1
0x0804865c <+104>:	mov    0x18(%esp), %eax  ; eax = obj2
0x08048660 <+108>:	mov    %eax, 0x10(%esp)  ; obj4 = obj2

0x08048664 <+112>:	mov    0xc(%ebp), %eax  ; eax = av[0]
0x08048667 <+115>:	add    $0x4, %eax  ; eax = &(av[1])
0x0804866a <+118>:	mov    (%eax), %eax  ; eax = av[1]
0x0804866c <+120>:	mov    %eax, 0x4(%esp)  ; 2nd arg to av[1]
0x08048670 <+124>:	mov    0x14(%esp), %eax  ; eax = obj3
0x08048674 <+128>:	mov    %eax, (%esp)  ; 1st arg to obj3
0x08048677 <+131>:	call   0x804870e <_ZN1N13setAnnotationEPc>  ; call obj3->setAnnotation(av[1]);

0x0804867c <+136>:	mov    0x10(%esp), %eax  ; eax = obj4
0x08048680 <+140>:	mov    (%eax), %eax  ; eax = *obj4
0x08048682 <+142>:	mov    (%eax), %edx  ; edx = *eax
0x08048684 <+144>:	mov    0x14(%esp), %eax  ; eax = obj3
0x08048688 <+148>:	mov    %eax, 0x4(%esp)  ; set 2nd arg to obj3
0x0804868c <+152>:	mov    0x10(%esp), %eax  ; eax = obj4
0x08048690 <+156>:	mov    %eax, (%esp)  ; set 1st arg to obj4
0x08048693 <+159>:	call   *%edx  ; obj4 + obj3

0x08048695 <+161>:	mov    -0x4(%ebp), %ebx
0x08048698 <+164>:	leave
0x08048699 <+165>:	ret

; -- N::N(int n) ---------------------------------------------------------------
0x080486f6 <_ZN1NC2Ei+0>:	push   %ebp
0x080486f7 <_ZN1NC2Ei+1>:	mov    %esp,%ebp

0x080486f9 <_ZN1NC2Ei+3>:	mov    0x8(%ebp),%eax
0x080486fc <_ZN1NC2Ei+6>:	movl   $0x8048848,(%eax)
0x08048702 <_ZN1NC2Ei+12>:	mov    0x8(%ebp),%eax
0x08048705 <_ZN1NC2Ei+15>:	mov    0xc(%ebp),%edx
0x08048708 <_ZN1NC2Ei+18>:	mov    %edx,0x68(%eax)

0x0804870b <_ZN1NC2Ei+21>:	pop    %ebp
0x0804870c <_ZN1NC2Ei+22>:	ret

; -- N::setAnnotation ----------------------------------------------------------
0x0804870e <_ZN1N13setAnnotationEPc+0>:	push   %ebp
0x0804870f <_ZN1N13setAnnotationEPc+1>:	mov    %esp, %ebp
0x08048711 <_ZN1N13setAnnotationEPc+3>:	sub    $0x18, %esp
0x08048714 <_ZN1N13setAnnotationEPc+6>:	mov    0xc(%ebp), %eax

0x08048717 <_ZN1N13setAnnotationEPc+9>:	mov    %eax, (%esp)
0x0804871a <_ZN1N13setAnnotationEPc+12>:	call   0x8048520 <strlen@plt>
0x0804871f <_ZN1N13setAnnotationEPc+17>:	mov    0x8(%ebp), %edx

0x08048722 <_ZN1N13setAnnotationEPc+20>:	add    $0x4, %edx
0x08048725 <_ZN1N13setAnnotationEPc+23>:	mov    %eax, 0x8(%esp)  // 3rd arg to strlen
0x08048729 <_ZN1N13setAnnotationEPc+27>:	mov    0xc(%ebp), %eax
0x0804872c <_ZN1N13setAnnotationEPc+30>:	mov    %eax, 0x4(%esp)  // 2nd arg to argv[1]
0x08048730 <_ZN1N13setAnnotationEPc+34>:	mov    %edx, (%esp)  // 1st arg to 0x0804a00c
0x08048733 <_ZN1N13setAnnotationEPc+37>:	call   0x8048510 <memcpy@plt>

0x08048738 <_ZN1N13setAnnotationEPc+42>:	leave
0x08048739 <_ZN1N13setAnnotationEPc+43>:	ret

; -- N::operator+(N&) ----------------------------------------------------------
0x0804873a <_ZN1NplERS_+0>:	push   %ebp
0x0804873b <_ZN1NplERS_+1>:	mov    %esp, %ebp

0x0804873d <_ZN1NplERS_+3>:	mov    0x8(%ebp), %eax
0x08048740 <_ZN1NplERS_+6>:	mov    0x68(%eax), %edx  ; edx = rhs->nVal
0x08048743 <_ZN1NplERS_+9>:	mov    0xc(%ebp), %eax
0x08048746 <_ZN1NplERS_+12>:	mov    0x68(%eax), %eax  ; eax = nVal
0x08048749 <_ZN1NplERS_+15>:	add    %edx, %eax

0x0804874b <_ZN1NplERS_+17>:	pop    %ebp
0x0804874c <_ZN1NplERS_+18>:	ret

; -- N::operator-(N&) ----------------------------------------------------------
0x0804874e <_ZN1NmiERS_+0>:	push   %ebp
0x0804874f <_ZN1NmiERS_+1>:	mov    %esp, %ebp

0x08048751 <_ZN1NmiERS_+3>:	mov    0x8(%ebp), %eax
0x08048754 <_ZN1NmiERS_+6>:	mov    0x68(%eax), %edx
0x08048757 <_ZN1NmiERS_+9>:	mov    0xc(%ebp), %eax
0x0804875a <_ZN1NmiERS_+12>:	mov    0x68(%eax), %eax
0x0804875d <_ZN1NmiERS_+15>:	mov    %edx, %ecx
0x0804875f <_ZN1NmiERS_+17>:	sub    %eax, %ecx
0x08048761 <_ZN1NmiERS_+19>:	mov    %ecx, %eax

0x08048763 <_ZN1NmiERS_+21>:	pop    %ebp
0x08048764 <_ZN1NmiERS_+22>:	ret
