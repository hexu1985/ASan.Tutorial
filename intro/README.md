### ASan简介

Address Sanitizer（ASan）是一个快速的内存错误检测工具。它非常快，只拖慢程序两倍左右（比起Valgrind快多了）。它包括一个编译器instrumentation模块和一个提供malloc()/free()替代项的运行时库。

从gcc 4.8开始，AddressSanitizer成为gcc的一部分。当然，要获得更好的体验，最好使用4.9及以上版本，因为gcc 4.8的AddressSanitizer还不完善，最大的缺点是没有符号信息。

### 使用步骤

- 用-fsanitize=address选项编译和链接你的程序。
- 用-fno-omit-frame-pointer编译，以得到更容易理解stack trace。
- 可选择-O1或者更高的优化级别编译

```
$ gcc -fsanitize=address -fno-omit-frame-pointer -O1 -g use-after-free.c -o use-after-free
```

运行use-after-fee。如果发现了错误，就会打印出类似下面的信息：
```
=================================================================
==13453==ERROR: AddressSanitizer: heap-use-after-free on address 0x614000000044 at pc 0x55b9dfe76231 bp 0x7fff3e52f4a0 sp 0x7fff3e52f490
READ of size 4 at 0x614000000044 thread T0
    #0 0x55b9dfe76230 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:7
    #1 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)
    #2 0x55b9dfe7610d in _start (/home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free+0x110d)

0x614000000044 is located 4 bytes inside of 400-byte region [0x614000000040,0x6140000001d0)
freed by thread T0 here:
    #0 0x7f2c3ffbd7cf in __interceptor_free (/lib/x86_64-linux-gnu/libasan.so.5+0x10d7cf)
    #1 0x55b9dfe761f5 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:6
    #2 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

previously allocated by thread T0 here:
    #0 0x7f2c3ffbdbc8 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x10dbc8)
    #1 0x55b9dfe761e5 in main /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:5
    #2 0x7f2c3fce50b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)

SUMMARY: AddressSanitizer: heap-use-after-free /home/hexu/git/C.And.Cpp.Compiling.Tutorial/asan/use_after_free/c/use_after_free.c:7 in main
Shadow bytes around the buggy address:
  0x0c287fff7fb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c287fff7ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0c287fff8000: fa fa fa fa fa fa fa fa[fd]fd fd fd fd fd fd fd
  0x0c287fff8010: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c287fff8020: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c287fff8030: fd fd fd fd fd fd fd fd fd fd fa fa fa fa fa fa
  0x0c287fff8040: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c287fff8050: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
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
  Shadow gap:              cc
==13453==ABORTING
```

- 第一部分（ERROR）指出错误类型是heap-use-after-free；
- 第二部分（READ）, 指出线程名thread T0，操作为READ，发生的位置是use-after-free.c:7。
    + 该heapk块之前已经在use-after-free.c:6被释放了；
    + 该heap块是在use-fater-free.c:5分配

- 第三部分 (SUMMARY) 前面输出的概要说明。

### 编译选项

#### Gcc编译选项

```
# -fsanitize=address：开启内存越界检测

# -fsanitize-recover=address：一般后台程序为保证稳定性，不能遇到错误就简单退出，而是继续运行，采用该选项支持内存出错之后程序继续运行，需要叠加设置ASAN_OPTIONS=halt_on_error=0才会生效；若未设置此选项，则内存出错即报错退出

ASAN_CFLAGS += -fsanitize=address -fsanitize-recover=address
```

```
# -fno-stack-protector：去使能栈溢出保护

# -fno-omit-frame-pointer：去使能栈溢出保护

# -fno-var-tracking：默认选项为-fvar-tracking，会导致运行非常慢

# -g1：表示最小调试信息，通常debug版本用-g即-g2

ASAN_CFLAGS += -fno-stack-protector -fno-omit-frame-pointer -fno-var-tracking -g1
```

#### Ld链接选项

```
ASAN_LDFLAGS += -fsanitize=address -g1
```

如果使用gcc链接，此处可忽略。

### ASAN运行选项

#### ASAN_OPTIONS设置

ASAN_OPTIONS是Address-Sanitizier的运行选项环境变量。

```
# halt_on_error=0：检测内存错误后继续运行

# detect_leaks=1:使能内存泄露检测

# malloc_context_size=15：内存错误发生时，显示的调用栈层数为15

# log_path=/home/xos/asan.log:内存检查问题日志存放文件路径

# suppressions=$SUPP_FILE:屏蔽打印某些内存错误

export ASAN_OPTIONS=halt_on_error=0:use_sigaltstack=0:detect_leaks=1:malloc_context_size=15:log_path=/home/xos/asan.log:suppressions=$SUPP_FILE
```

除了上述常用选项，以下还有一些选项可根据实际需要添加：

```
# detect_stack_use_after_return=1：检查访问指向已被释放的栈空间

# handle_segv=1：处理段错误；也可以添加handle_sigill=1处理SIGILL信号

# quarantine_size=4194304:内存cache可缓存free内存大小4M

ASAN_OPTIONS=${ASAN_OPTIONS}:verbosity=0:handle_segv=1:allow_user_segv_handler=1:detect_stack_use_after_return=1:fast_unwind_on_fatal=1:fast_unwind_on_check=1:fast_unwind_on_malloc=1:quarantine_size=4194304
```

#### LSAN_OPTIONS设置

LSAN_OPTIONS是LeakSanitizier运行选项的环境变量，而LeakSanitizier是ASAN的内存泄漏检测模块，常用运行选项有：

```
# exitcode=0：设置内存泄露退出码为0，默认情况内存泄露退出码0x16

# use_unaligned=4：4字节对齐

export LSAN_OPTIONS=exitcode=0:use_unaligned=4
```

### 其他

实际开发环境中，可能存在gcc版本低，使用asan做内存检查时，需要链接libasan.so库的情况。其次，平台软件通常都会内部实现一套内存操作接口，为使用asan工具，需要替换成glibc提供的接口。此时，可以通过LD_PRELOAD环境变量解决这类问题。

```
export LD_PRELOAD=libasan.so.2:libprelib.so   #vos_malloc --> malloc
```

### 相关连接

[Valgrind memcheck 用法](https://www.jianshu.com/p/78adaba826c3)

[Address Sanitizer 用法](https://www.jianshu.com/p/3a2df9b7c353)

[Linux下内存检测工具：asan](https://blog.csdn.net/hanlizhong85/article/details/78076668)

[AddressSanitizer Introduction](https://github.com/google/sanitizers/wiki/AddressSanitizer)

[AddressSanitizer Build](https://github.com/google/sanitizers/wiki/AddressSanitizerHowToBuild)

[AddressSanitizer 错误示例](https://learn.microsoft.com/zh-cn/cpp/sanitizers/asan-error-examples?view=msvc-170)
