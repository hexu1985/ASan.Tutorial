#!/usr/bin/env bash
gcc -g -fsanitize=address -fno-omit-frame-pointer -o prog_3.10-list_reversal prog_3.10-list_reversal.c
gcc -g -fsanitize=address -fno-omit-frame-pointer -o prog_3.10-list_reversal-fix prog_3.10-list_reversal-fix.c
  
