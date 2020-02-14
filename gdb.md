# GDB

## commands
- `b main` <- breack point to main
- `r arg` <- run avec arguments
- `info registers eax` <- print the actual value of registers
- `n` <- permet d’aller jusqu’à la prochaine étape, exemple jusqu’au prochain breakpoint,  jusqu’à la sortie de la fonction,
- `c` <- va au breakpoint suivant
- `finish` <- va a la fin de la fonction (renvoie la valeur de retour)
- `si` <- jusqu’à la prochaine instruction, (la ligne suivante en asm)
- `set $var=1` permet d’assigner une valeur à une variable, ex: set $esi = 5 pour mettre la valeur 5 à la partie 32bit du registre RSI
- `disass main` <- disassemble le main
- `set {char}0x5555555546e4=42` <- set la valeur a l'adresse
- `print {char[4]}0x5555555547d6` <- print la valeur a l'adresse

## registers
`EAX` Stores function return values
`ECX` Counter for string and loop operation
`EDX` I/O Pointer
`EIP` Instruction pointer (Pointer to the next instruction to be executed)
`EBX` Base pointer to the data section (in DS segment)
`EDI` Source pointer for string operations
`ESI` Pointer to data in the sement pointed by the DS register; Destination pointer `for` string operations.
`ESP` Stack pointer (in the SS Segment)
`EBP` Stack frame base pointer (local variables in the function) (in the SS Segment)
`ebx` `ecx` `edx` `esi` `edi` `ebp` functions arguments
