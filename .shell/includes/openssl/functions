#!/bin/bash

# Generate a local certificate authority
ssl-new-ca() {
  if [ -n "$1" ]; then
    SUBJ=$1
  else 
    SUBJ="/CN=LOCAL-CA"
  fi
  openssl genrsa -out ca.key 4096
  openssl req -new -key ca.key -subj "$SUBJ" -out ca.csr
  openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
}

# Generate a new key and csr
ssl-new-csr() {
  if [ -n "$1" ]; then
    NAME=$1
  else
    NAME=new
  fi

  openssl genrsa -out ${NAME}.key 4096
  openssl req -new -key ${NAME}.key -out ${NAME}.csr
}

# Sign a csr with a ca
ssl-sign-csr() {
  if [ -z "$1" ] || [ -z "$2" ]; then
     echo "Usage: ssl-sign-csr [CSR] [CA]"
  fi

  CSR=$1
  CA=$2
  CRT=$(basename $CSR)
  openssl x509 -req -in $CSR -signkey $CA -out $CRT.crt
}


# Create an openssl config file with DSN alt_names
ssl-new-san-config() {

  cat <<EOF > openssl.cnf
[req]
req_extensions = v3_req
[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation,
subjectAltName = @alt_names
[alt_names]
EOF

  COUNT=1
  for dns in $*; do
    echo "DNS.$COUNT = $dns" >> openssl.cnf
    COUNT=$((COUNT + 1))
  done
}
