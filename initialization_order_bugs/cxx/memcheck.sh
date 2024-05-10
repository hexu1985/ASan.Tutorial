#!/usr/bin/env bash
echo "./link_a_first" && ./link_a_first
echo "./link_a_first_asan" && ASAN_OPTIONS=check_initialization_order=true ./link_a_first_asan
echo "./link_b_first" && ./link_b_first
echo "./link_b_first_asan" && ASAN_OPTIONS=check_initialization_order=true ./link_b_first_asan
echo "strict_init_order=truei ./link_b_first_asan" && ASAN_OPTIONS=check_initialization_order=true:strict_init_order=true ./link_b_first_asan
