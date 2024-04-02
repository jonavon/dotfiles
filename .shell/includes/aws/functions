#!/bin/bash

# decode error messages
sts-decode() {
  msg=$1
  aws sts decode-authorization-message --encoded-message $msg --output text | jq .
}
