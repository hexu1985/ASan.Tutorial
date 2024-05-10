#!/usr/bin/env bash
#./suppressions
ASAN_OPTIONS=detect_leaks=1 LSAN_OPTIONS=suppressions=suppr.txt ./suppressions
