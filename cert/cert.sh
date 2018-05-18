#!/usr/bin/env bash
openssl genrsa -out ca.key 4096
openssl req -new -x509 -days 1826 -key ca.key -out ca.crt
openssl genrsa -out server.key 4096
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 730 -in server.csr -CA ca.crt -CAkey ca.key -set_serserverl 01 -out server.crt
openssl pkcs12 -export -out server.p12 -inkey server.key -in server.crt -chain -CAfile ca.crt