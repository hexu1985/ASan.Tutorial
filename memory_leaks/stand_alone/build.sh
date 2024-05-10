#!/usr/bin/env bash
gcc -g -fsanitize=leak -fno-omit-frame-pointer -o memory_leaks memory_leaks.c
