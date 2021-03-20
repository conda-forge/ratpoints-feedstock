#!/bin/bash

PRIME_SIZE=7
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"
export CCFLAGS1="-I$PREFIX/include -Wall -O2 -fPIC -DRATPOINTS_MAX_BITS_IN_PRIME=$PRIME_SIZE $CFLAGS"
export CCFLAGS2=""
export CCFLAGS="-L$PREFIX/lib -lgmp -lm $LDFLAGS"
export INSTALL_DIR="$PREFIX"

sed -i.bak 's/${CC} gen_init_sieve_h.c/${CC_FOR_BUILD} gen_init_sieve_h.c/g' Makefile
sed -i.bak 's/${CC} gen_find_points_h.c/${CC_FOR_BUILD} gen_find_points_h.c/g' Makefile

make -e libratpoints.a
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make -e test
fi
make -e install-lib
