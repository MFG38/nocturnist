#!/usr/bin/env bash
VERNUM="test"

echo Building...
cd src/
7za a -tzip nocturnist_${VERNUM}.pk3 *
mv nocturnist_${VERNUM}.pk3 ../build
