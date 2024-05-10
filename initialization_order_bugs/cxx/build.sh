#!/usr/bin/env bash
gcc -g a.cc b.cc -o link_a_first
gcc -g b.cc a.cc -o link_b_first
gcc -g -fsanitize=address -fno-omit-frame-pointer a.cc b.cc -o link_a_first_asan
gcc -g -fsanitize=address -fno-omit-frame-pointer b.cc a.cc -o link_b_first_asan

