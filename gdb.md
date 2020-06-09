# GDB

## commands
- `b main` <- breack point to main
- `r <arg>` <- run avec arguments
- `info registers eax` <- print the actual value of registers
- `n` <- permet d’aller jusqu’à la prochaine étape, exemple jusqu’au prochain breakpoint,  jusqu’à la sortie de la fonction,
- `c` <- va au breakpoint suivant
- `finish` <- va a la fin de la fonction (renvoie la valeur de retour)
- `si` <- jusqu’à la prochaine instruction, (la ligne suivante en asm)
- `set $var=1` permet d’assigner une valeur à une variable, ex: set $esi = 5 pour mettre la valeur 5 à la partie 32bit du registre RSI
- `disass main` <- disassemble le main
- `set {char}0x5555555546e4=42` <- set la valeur a l'adresse
- `print {char[4]}0x5555555547d6` <- print la valeur a l'adresse
- `record` <- enregistre l'etat des registre pendant le run (possible d'inverser le sens d'exec avec `reverse-continue`)
- `pattern create 100` <- create a pattern of 100 chars
- `pattern offset AmAA` <- show what is the offset **of** this pattern
- `bt` <- show trace when segfault
- `r < <(perl -e 'print "A"x5')` <- lancer le binaire, et lui envoyer un flux dans stdin
- `context` <- reload peda

> https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf

## registers
- `EAX` Stores function return values
- `ECX` Counter for string and loop operation
- `EDX` I/O Pointer
- `EIP` Instruction pointer (Pointer to the next instruction to be executed), 😉 change **eip** value to jump where you want

- `EBX` Base pointer to the data section (in DS segment)
- `EDI` Source pointer for string operations
- `ESI` Pointer to data in the sement pointed by the DS register; Destination pointer `for` string operations.
- `ESP` Stack pointer (in the SS Segment) (start argument for function)
- `EBP` Stack frame base pointer (local variables in the function) (in the SS Segment)

`ebx` `ecx` `edx` `esi` `edi` `ebp` functions arguments

---
## shell tools

to print hex values
- `perl -e 'print "A"x12 . "aa"'`
- `echo -ne "\x2a"`

to keep stdin open
- `(echo "hey"; cat) | ./whatever`
- `echo "hey" > /tmp/args && cat /tmp/args - | ./whatever`

dump memory at `0x80486a0` with 1 line before & 3 lines after
- `xxd level0 | grep -B1 -A3 "00006a0"`

---
## x86 and x86_64 Assembly

### mov — Move
The mov instruction copies the data item referred to by its first operand (i.e. register contents, memory contents, or a constant value) into the location referred to by its second operand (i.e. a register or memory).

Syntax
- mov `<reg>`, `<reg>`
- mov `<reg>`, `<mem>`
- mov `<mem>`, `<reg>`
- mov `<con>`, `<reg>`
- mov `<con>`, `<mem>`

Examples
- `mov %ebx, %eax` copy the value in **ebx** into **eax**
- `movb $5, var(,1)` store the value **5** into the byte at location var

---
### push — Push on stack
The push instruction places its operand onto the top of the hardware supported stack in memory. Specifically, push first decrements **esp** by 4, then places its operand into the contents of the 32-bit location at address (%esp).

**esp** (the stack pointer) is decremented by push since the x86 stack grows down — i.e. the stack grows from high addresses to lower addresses.

Syntax
- push `<reg32>`
- push `<mem>`
- push `<con32>`

Examples
- `push %eax` push eax on the stack
- `push var(,1)` push the 4 bytes at address var onto the stack

---
### pop — Pop from stack
The pop instruction removes the 4-byte data element from the top of the hardware-supported stack into the specified operand (i.e. register or memory location). It first moves the 4 bytes located at memory location (%esp) into the specified register or memory location, and then increments **esp** by 4.

Syntax
- pop `<reg32>`
- pop `<mem>`

Examples
- `pop %edi` pop the top element of the stack into **edi**.
- `pop (%ebx)` pop the top element of the stack into memory at the four bytes starting at location **ebx**.

---
### lea — Load effective address
The lea instruction places the address specified by its first operand into the register specified by its second operand. Note, the contents of the memory location are not loaded, only the effective address is computed and placed into the register. This is useful for obtaining a pointer into a memory region or to perform simple arithmetic operations.

Syntax
- lea `<mem>`, `<reg32>`

Examples
- `lea (%ebx, %esi, 8), %edi` the quantity **ebx**+8***esi** is placed in **edi**.
- `lea val(,1), %eax` the value val is placed in **eax**.

---
### add — Integer addition
The add instruction adds together its two operands, storing the result in its second operand. Note, whereas both operands may be registers, at most one operand may be a memory location.

Syntax
- add `<reg>`, `<reg>`
- add `<mem>`, `<reg>`
- add `<reg>`, `<mem>`
- add `<con>`, `<reg>`
- add `<con>`, `<mem>`

Examples
- `add $10, %eax` **eax** is set to **eax** + 10
- `addb $10, (%eax)` add 10 to the single byte stored at memory address stored in **eax**

---
### sub — Integer subtraction
The sub instruction stores in the value of its second operand the result of subtracting the value of its first operand from the value of its second operand. As with add, whereas both operands may be registers, at most one operand may be a memory location.

Syntax
- sub `<reg>`, `<reg>`
- sub `<mem>`, `<reg>`
- sub `<reg>`, `<mem>`
- sub `<con>`, `<reg>`
- sub `<con>`, `<mem>`

Examples
- `sub %ah, %al` AL is set to **al** - **ah**
- `sub $216, %eax` subtract **216** from the value stored in **eax**

---
### inc, dec — Increment, Decrement
The inc instruction increments the contents of its operand by one. The dec instruction decrements the contents of its operand by one.

Syntax
- inc `<reg>`
- inc `<mem>`
- dec `<reg>`
- dec `<mem>`

Examples
- `dec %eax` subtract one from the contents of **eax**
- `incl var(,1)` add one to the 32-bit integer stored at location var

---
### imul — Integer multiplication
The imul instruction has two basic formats: two-operand (first two syntax listings above) and three-operand (last two syntax listings above).
The two-operand form multiplies its two operands together and stores the result in the second operand. The result (i.e. second) operand must be a register.

The three operand form multiplies its second and third operands together and stores the result in its last operand. Again, the result operand must be a register. Furthermore, the first operand is restricted to being a constant value.

Syntax
- imul `<reg32>`, `<reg32>`
- imul `<mem>`, `<reg32>`
- imul `<con>`, `<reg32>`, `<reg32>`
- imul `<con>`, `<mem>`, `<reg32>`

Examples
- `imul (%ebx), %eax` multiply the contents of **eax** by the 32-bit contents of the memory at location **ebx**. Store the result in **eax**.
- `imul $25, %edi, %esi` **esi** is set to **edi** * 25

---
### idiv — Integer division
The idiv instruction divides the contents of the 64 bit integer **edx**:**eax** (constructed by viewing **edx** as the most significant four bytes and **eax** as the least significant four bytes) by the specified operand value. The quotient result of the division is stored into **eax**, while the remainder is placed in **edx**.

Syntax
- idiv `<reg32>`
- idiv `<mem>`

Examples
- `idiv %ebx` divide the contents of **edx**:**eax** by the contents of **ebx**. Place the quotient in **eax** and the remainder in **edx**.
- `idivw (%ebx)` divide the contents of **edx**:EAS by the 32-bit value stored at the memory location in **ebx**. Place the quotient in **eax** and the remainder in **edx**.

---
### and, or, xor — Bitwise logical and, or, and exclusive or
These instructions perform the specified logical operation (logical bitwise and, or, and exclusive or, respectively) on their operands, placing the result in the first operand location.

Syntax
- and `<reg>`, `<reg>`
- and `<mem>`, `<reg>`
- and `<reg>`, `<mem>`
- and `<con>`, `<reg>`
- and `<con>`, `<mem>`
- or `<reg>`, `<reg>`
- or `<mem>`, `<reg>`
- or `<reg>`, `<mem>`
- or `<con>`, `<reg>`
- or `<con>`, `<mem>`
- xor `<reg>`, `<reg>`
- xor `<mem>`, `<reg>`
- xor `<reg>`, `<mem>`
- xor `<con>`, `<reg>`
- xor `<con>`, `<mem>`

Examples
- `and $0x0f, %eax` clear all but the last 4 bits of **eax**.
- `xor %edx, %edx` set the contents of **edx** to zero.

---
### not — Bitwise logical not
Logically negates the operand contents (that is, flips all bit values in the operand).

Syntax
- not `<reg>`
- not `<mem>`

Example
- `not %eax` flip all the bits of **eax**

---
### neg — Negate
Performs the two's complement negation of the operand contents.

Syntax
- neg `<reg>`
- neg `<mem>`

Example
- `neg %eax` **eax** is set to (- **eax**)

---
### shl, shr — Shift left and right
These instructions shift the bits in their first operand's contents left and right, padding the resulting empty bit positions with zeros. The shifted operand can be shifted up to 31 places. The number of bits to shift is specified by the second operand, which can be either an 8-bit constant or the register CL. In either case, shifts counts of greater then 31 are performed modulo 32.

Syntax
- shl `<con8>`, `<reg>`
- shl `<con8>`, `<mem>`
- shl %cl, `<reg>`
- shl %cl, `<mem>`
- shr `<con8>`, `<reg>`
- shr `<con8>`, `<mem>`
- shr %cl, `<reg>`
- shr %cl, `<mem>`

Examples
- `shl $1, eax` Multiply the value of **eax** by 2 (if the most significant bit is 0)
- `shr %cl, %ebx` Store in **ebx** the floor of result of dividing the value of **ebx** by 2n where n is the value in CL. Caution: for negative integers, it is different from the C semantics of division!

### jmp — Jump
Transfers program control flow to the instruction at the memory location indicated by the operand.

Syntax
- jmp `<label>`

Example
- jmp `begin` Jump to the instruction labeled begin.

---
### jcondition — Conditional jump
These instructions are conditional jumps that are based on the status of a set of condition codes that are stored in a special register called the machine status word. The contents of the machine status word include information about the last arithmetic operation performed. For example, one bit of this word indicates if the last result was zero. Another indicates if the last result was negative. Based on these condition codes, a number of conditional jumps can be performed. For example, the jz instruction performs a jump to the specified operand label if the result of the last arithmetic operation was zero. Otherwise, control proceeds to the next instruction in sequence.
A number of the conditional branches are given names that are intuitively based on the last operation performed being a special compare instruction, cmp (see below). For example, conditional branches such as jle and jne are based on first performing a cmp operation on the desired operands.

Syntax
- je `<label>` (jump when equal)
- jne `<label>` (jump when not equal)
- jz `<label>` (jump when last result was zero)
- jg `<label>` (jump when greater than)
- jge `<label>` (jump when greater than or equal to)
- jl `<label>` (jump when less than)
- jle `<label>` (jump when less than or equal to)

Example
```
cmp %ebx, %eax`
jle done
```

If the contents of **eax** are less than or equal to the contents of **ebx**, jump to the label done. Otherwise, continue to the next instruction.

---
### cmp — Compare
Compare the values of the two specified operands, setting the condition codes in the machine status word appropriately. This instruction is equivalent to the sub instruction, except the result of the subtraction is discarded instead of replacing the first operand.

Syntax
- cmp `<reg>`, `<reg>`
- cmp `<mem>`, `<reg>`
- cmp `<reg>`, `<mem>`
- cmp `<con>`, `<reg>`

Example
```
cmpb $10, (%ebx)`
jeq loop
```

If the byte stored at the memory location in **ebx** is equal to the integer constant 10, jump to the location labeled loop.

---
### call, ret — Subroutine call and return

These instructions implement a subroutine call and return. The call instruction first pushes the current code location onto the hardware supported stack in memory (see the push instruction for details), and then performs an unconditional jump to the code location indicated by the label operand. Unlike the simple jump instructions, the call instruction saves the location to return to when the subroutine completes.
The ret instruction implements a subroutine return mechanism. This instruction first pops a code location off the hardware supported in-memory stack (see the pop instruction for details). It then performs an unconditional jump to the retrieved code location.

Syntax
- call `<label>`
- ret

---
- ` cmpl $0x0, 0x18(%esp)`
compares the value in memory at address **%esp+0x18**

---
### shellcodes

#### exec /bin/sh

`"\x6a\x0b\x58\x31\xf6\x56\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x31\xc9\x89\xca\xcd\x80"`

```asm
; execve("/bin//sh"00);
;   ^        ^       ^  ^
;  eax      ebx    ecx  edx

6a 0b			push   $0xb			; 0xb => execve (shell-storm.org/shellcode/files/syscalls.html)
58				pop    %eax			; pop stack value (0xb) to eax

31 f6			xor    %esi,%esi
56				push   %esi			; push '\0' to the stack
68 2f 2f 73 68	push   $0x68732f2f	; push "hs//" to the stack
68 2f 62 69 6e	push   $0x6e69622f	; push "hs//" to the stack

89 e3			mov    %esp,%ebx	; put curnt value of stack ptr (esp) into ebx
31 c9			xor    %ecx,%ecx	; clear/zero ecx
89 ca			mov    %ecx,%edx	; clear/zero edx

cd 80			int    $0x80		; system call execve("/bin//sh"00);

; ------------------------------------------------------------------------------
; On unix x86/x86_64 systems you can make a syscall by calling interrupt 0x80
; Parameters are passed by setting the general purpose registers as following:
; Syscall#	arg1  arg2  arg3  arg4  arg5  arg6
; eax       ebx   ecx   edx   esi   edi   ebp


; direction of growth
; |   STACK:
; |   ╔═════════════════╗
; v   ║        0        ║ <-- '/0' end string ?
;     ╠═════════════════╣
;     ║      "hs//"     ║
;     ╠═════════════════╣
;     ║      "nib/"     ║ <-- ebx
;     ╚═════════════════╝
````
