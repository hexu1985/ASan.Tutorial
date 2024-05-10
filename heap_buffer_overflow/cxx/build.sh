#!/usr/bin/env bash
g++ -g -fsanitize=address -fno-omit-frame-pointer -o heap_buffer_overflow heap_buffer_overflow.cpp
