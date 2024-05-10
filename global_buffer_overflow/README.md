### global buffer overflow 全局缓冲访问溢出

如下代码中，访问的位置超出全局数组array的边界。

```cpp
1 int global_array[100] = {-1};
2
3 int main(int argc, char **argv) {
4   return global_array[argc + 100];  // BOOM
5 }
```

下面的错误信息指出：

- 错误类型是global-buffer-overflow
- 不合法操作READ发生在线程T0, global_buffer_overflow.c:4
- 缓存块在global_buffer_overflow.c:1 定义。

```
=================================================================
==16803==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55e41538e1b4 at pc 0x55e41518d9b8 bp 0x7ffe977e3350 sp 0x7ffe977e3340
READ of size 4 at 0x55e41538e1b4 thread T0
    #0 0x55e41518d9b7 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/global_buffer_overflow/c/global_buffer_overflow.c:4
    #1 0x7f40b50c3bf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)
    #2 0x55e41518d879 in _start (/home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/global_buffer_overflow/c/global_buffer_overflow+0x879)

0x55e41538e1b4 is located 4 bytes to the right of global variable 'global_array' defined in 'global_buffer_overflow.c:1:5' (0x55e41538e020) of size 400
SUMMARY: AddressSanitizer: global-buffer-overflow /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/global_buffer_overflow/c/global_buffer_overflow.c:4 in main
Shadow bytes around the buggy address:
  0x0abd02a69be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0abd02a69c30: 00 00 00 00 00 00[f9]f9 f9 f9 f9 f9 00 00 00 00
  0x0abd02a69c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0abd02a69c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==16803==ABORTING
```

