### memory leaks 内存泄露

检测内存的LeakSanitizer是集成在AddressSanitizer中的一个相对独立的工具，它工作在检查过程的最后阶段。

下面代码中，p指向的内存没有释放。

```cpp
1 #include <stdlib.h>
2
3 void *p;
4
5 int main() {
6     p = malloc(7);
7     p = 0; // The memory is leaked here.
8     return 0;
9 }
```

下面的错误信息指出 detected memory leaks

内存在memory_leaks.c:6分配

```
=================================================================
==31903==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 7 byte(s) in 1 object(s) allocated from:
    #0 0x7f8311989b40 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb40)
    #1 0x55d96647a7f7 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/address_sanitizer/memory_leaks/c/memory_leaks.c:6
    #2 0x7f83114dbbf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)

SUMMARY: AddressSanitizer: 7 byte(s) leaked in 1 allocation(s).
```


