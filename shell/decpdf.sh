#!/bin/sh

# Decrypt a password-protected pdf
qpdf --decrypt --password="$2" "$1" out && mv out "$1"
