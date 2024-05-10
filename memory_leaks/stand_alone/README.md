#### Stand-alone mode
If you just need leak detection, and don't want to bear the ASan slowdown, you can build with -fsanitize=leak instead of -fsanitize=address. This will link your program against a runtime library containing just the bare necessities required for LeakSanitizer to work. No compile-time instrumentation will be applied.

Be aware that the stand-alone mode is less well tested compared to running LSan on top of ASan.

#### Flags
You can fine-tune LeakSanitizer's behavior through the LSAN_OPTIONS environment variable.

| flag	| default | description |
| ----- | ------- | ----------- |
| exitcode | 23	 | If non-zero, LSan will call _exit(exitcode) upon detecting leaks. This can be different from the exit code used to signal ASan errors. |
| max_leaks	| 0	| If non-zero, report only this many top leaks. |
| suppressions | (none) | Path to file containing suppression rules (see below) |
| print_suppressions | 1 | If 1, print statistics for matched suppressions. |
| report_objects | 0 | If 1, LSan will report the addresses of individual leaked objects. |
| use_unaligned	 | 0 | If 0, LSan will only consider properly aligned 8-byte patterns when looking for pointers. Set to 1 to include unaligned patterns. This refers to the pointer itself, not the memory being pointed at. |

Leak detection is also affected by certain ASan flags. If you're not happy with the stack traces you see, check out `fast_unwind_on_malloc`, `malloc_context_size` and `strip_path_prefix`. Those flags go in `ASAN_OPTIONS` as usual. However, if you built with `-fsanitize=leak`, put them in `LSAN_OPTIONS` instead (and use `LSAN_SYMBOLIZER_PATH` to pass the symbolizer path).
