#!/bin/bash
# Wrapper for the Python test runner
python3 "$(dirname "$0")/test_all.py" "$@"
