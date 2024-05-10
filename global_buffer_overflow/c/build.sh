#!/usr/bin/env bash
gcc -g -fsanitize=address -fno-omit-frame-pointer -o global_buffer_overflow global_buffer_overflow.c
