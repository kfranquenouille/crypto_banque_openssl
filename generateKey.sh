#!/bin/bash

mkdir ./banque ./client ./vendeur

openssl genrsa 2048 > ./banque/bankprivate.key
openssl genrsa 1024 > ./client/clientprivate.key

cat ./banque/bankprivate.key | openssl rsa -pubout > ./banque/bankpublic.key
cat ./client/clientprivate.key | openssl rsa -pubout > ./client/clientpublic.key

cp ./client/clientpublic.key ./banque/
cp ./banque/bankpublic.key ./vendeur/

#cat ./banque/clientpublic.key | openssl rsautl -encrypt -inkey ./banque/bankprivate.key | base64 > cheque.txt

#
cat client/clientpublic.key | openssl enc -e -aes-128-cbc -pass pass:unmdpalacon > clientpubkeyAES.bin
echo "unmdpalacon" | openssl rsautl -encrypt -inkey banque/bankprivate.key | base64 > chequeByBank.key
