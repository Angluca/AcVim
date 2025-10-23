#!/bin/bash
CC=$1
TARGET=$2
DEPS=$(eval echo $(cat DEPS))
OPTS=

$CC $OPTS $DEPS $TARGET
# ./build.sh v3i test.v3
