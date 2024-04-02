#!/bin/bash

# Cleanup Python cache and bytecode
pyclean() {
  find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

# Simple web server from current directory
pyweb() {
  local port
  # start on port 8080 if not specified
  if [ -z "$1" ]; then
    port=8080
  else
    port=$1
  fi
  python -m SimpleHTTPServer ${port} 
}
