#!/usr/bin/env bash
g++ -g -fsanitize=address -fno-omit-frame-pointer -o use_after_free use_after_free.cpp
