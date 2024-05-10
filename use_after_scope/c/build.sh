#!/usr/bin/env bash
gcc -g -fsanitize=address -fno-omit-frame-pointer -o use_after_scope use_after_scope.c
