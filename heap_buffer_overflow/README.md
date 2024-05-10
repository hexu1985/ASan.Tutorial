### heap buffer overflow 堆缓存访问溢出

如下代码中，访问的位置超出堆上数组array的边界。

```cpp
1 #include <stdlib.h>
2
3 int main(int argc, char **argv) {
4     int *array = new int[100];
5     array[0] = 0;
6     int res = array[argc + 100];  // BOOM
7     delete [] array;
8     return res;
9 }
```

下面的错误信息指出：

- 错误类型是heap-buffer-overflow
- 不合法操作READ发生在线程T0, heap_buffer_overflow.cpp:6
- heap块分配发生在heap_buffer_overflow.cpp

```
=================================================================
==14447==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6140000001d4 at pc 0x55c4f275e988 bp 0x7ffd1e4c0ed0 sp 0x7ffd1e4c0ec0
READ of size 4 at 0x6140000001d4 thread T0
    #0 0x55c4f275e987 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/heap_buffer_overflow/cxx/heap_buffer_overflow.cpp:6
    #1 0x7f70170f3bf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)
    #2 0x55c4f275e7f9 in _start (/home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/heap_buffer_overflow/cxx/heap_buffer_overflow+0x7f9)

0x6140000001d4 is located 4 bytes to the right of 400-byte region [0x614000000040,0x6140000001d0)
allocated by thread T0 here:
    #0 0x7f70175a3608 in operator new[](unsigned long) (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xe0608)
    #1 0x55c4f275e8f2 in main /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/heap_buffer_overflow/cxx/heap_buffer_overflow.cpp:4
    #2 0x7f70170f3bf6 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x21bf6)

SUMMARY: AddressSanitizer: heap-buffer-overflow /home/mackhe/git/C.And.Cpp.Compiling.Tutorial/asan/heap_buffer_overflow/cxx/heap_buffer_overflow.cpp:6 in main
Shadow bytes around the buggy address:
  0x0c287fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff8000: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c287fff8010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff8020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0c287fff8030: 00 00 00 00 00 00 00 00 00 00[fa]fa fa fa fa fa
  0x0c287fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8060: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8070: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
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
==14447==ABORTING
```

