#!/usr/bin/env bash

./dockcross cmake -Bbuild -Hsrc -GNinja
./dockcross ninja -Cbuild
