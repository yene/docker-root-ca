#!/bin/bash
set -e
set -x
docker run --rm -it -p 3002:3002 -t rootca-test
