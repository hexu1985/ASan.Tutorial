#!/usr/bin/env bash
gcc -g -fsanitize=address -fno-omit-frame-pointer -o stack_buffer_overflow stack_buffer_overflow.c
