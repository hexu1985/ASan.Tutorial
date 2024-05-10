#!/usr/bin/env bash
ASAN_OPTIONS=detect_stack_use_after_return=1 ./use_after_return
