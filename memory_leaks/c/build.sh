#!/usr/bin/env bash
gcc -g -fsanitize=address -fno-omit-frame-pointer -o memory_leaks memory_leaks.c
