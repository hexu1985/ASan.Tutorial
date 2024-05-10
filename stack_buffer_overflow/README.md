### stack buffer overflow 栈缓存访问溢出

如下代码中，访问的位置超出栈上数组array的边界。

```c
1 #include <stdlib.h>
2 
3 int main(int argc, char **argv) {
4     int stack_array[100];
5     stack_array[1] = 0;
6     return stack_array[argc + 100];  // BOOM
7 }
```

下面的错误信息指出：

- 错误类型是stack-buffer-overflow
- 不合法操作READ发生在线程T0, stack_buf_overflow.c:6
- 栈块在线程T0的栈上432偏移位置上。

```
=================================================================
==14558==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffd615ade04 at pc 0x55c398cadaad bp 0x7ffd615adc30 sp 0x7ffd615adc20
READ of size 4 at 0x7ffd615ade04 thread T0
    #0 0x55c398cadaac in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:6
    #1 0x7f287a6d1bf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)
    #2 0x55c398cad899 in _start (/home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow+0x899)

Address 0x7ffd615ade04 is located in stack of thread T0 at offset 436 in frame
    #0 0x55c398cad989 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:3

  This frame has 1 object(s):
    [32, 432) 'stack_array' <== Memory access at offset 436 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/stack_buffer_overflow/c/stack_buffer_overflow.c:6 in main
Shadow bytes around the buggy address:
  0x10002c2adb70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adb80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
  0x10002c2adb90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adbb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x10002c2adbc0:[f2]f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adbd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adbe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adbf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x10002c2adc10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
==14558==ABORTING
```
