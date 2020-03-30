#!/bin/bash


for name in `ls *.md`; do echo "- [$name](./$name)" >> README.md; done
