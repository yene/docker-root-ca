#!/bin/bash
set -e
set -x
docker build --no-cache -t "rootca-test" .
