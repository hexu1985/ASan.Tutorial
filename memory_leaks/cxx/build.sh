#!/usr/bin/env bash
g++ -g -fsanitize=address -fno-omit-frame-pointer -o custom_deleter custom_deleter.cpp
