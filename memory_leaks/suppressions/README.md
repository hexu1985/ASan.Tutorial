### Suppressions

You can instruct LeakSanitizer to ignore certain leaks by passing in a suppressions file. The file must contain one suppression rule per line, each rule being of the form `leak:<pattern>`. The pattern will be substring-matched against the symbolized stack trace of the leak. If either function name, source file name or binary file name matches, the leak report will be suppressed.

```
$ cat suppr.txt
# This is a known leak.
leak:FooBar
$ cat lsan-suppressed.cc
#include <stdlib.h>

void FooBar() {
  malloc(7);
}

void Baz() {
  malloc(5);
}

int main() {
  FooBar();
  Baz();
  return 0;
}
$ clang++ lsan-suppressed.cc -fsanitize=address
$ ASAN_OPTIONS=detect_leaks=1 LSAN_OPTIONS=suppressions=suppr.txt ./a.out

=================================================================
==26475==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 5 byte(s) in 1 object(s) allocated from:
    #0 0x44f2de in malloc /usr/home/hacker/llvm/projects/compiler-rt/lib/asan/asan_malloc_linux.cc:74
    #1 0x464e86 in Baz() (/usr/home/hacker/a.out+0x464e86)
    #2 0x464fb4 in main (/usr/home/hacker/a.out+0x464fb4)
    #3 0x7f7e760b476c in __libc_start_main /build/buildd/eglibc-2.15/csu/libc-start.c:226

-----------------------------------------------------
Suppressions used:[design document](AddressSanitizerLeakSanitizerDesignDocument)
  count      bytes template
      1          7 FooBar
-----------------------------------------------------

SUMMARY: AddressSanitizer: 5 byte(s) leaked in 1 allocation(s).
```

The special symbols`^`and`$`match the beginning and the end of string.
