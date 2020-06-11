# bonus3

In this level, we can send an int as argument.

A string is filled with the content of `"/home/user/end/.pass"`, we can set a char in this string to 0:
```
str+<int(av[1])>*2 = '\0'
```
Then, we compare av[1] and the string.

To pass the comparison, wee need that the string is empty (so we need to send 0)
```bash
> ./bonus3 0
```
In this config, we compare the string (`""`) with av[1] (`"0"`).

But if we sent `""` as arg, atoi will interpret `""` as 0.
```bash
> ./bonus3 ""
$ cat /home/user/end/.pass
3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c
```

```
3321b6f81659f9a71c76616f606e4b50189cecfea611393d5d649f75e157353c
```
