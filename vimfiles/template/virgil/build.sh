#!/bin/bash
CC=$1
TARGET=$2
DEPS=$(eval echo $(cat DEPS))
$CC $DEPS $TARGET
# ./build.sh v3i test.v3
