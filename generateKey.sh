#!/bin/bash

mkdir ./banque ./client ./vendeur

openssl genrsa 2048 > ./banque/bankprivate.key
openssl genrsa 1024 > ./client/clientprivate.key

cat ./banque/bankprivate.key | openssl rsa -pubout > ./banque/bankpublic.key
cat ./client/clientprivate.key | openssl rsa -pubout > ./client/clientpublic.key

cp ./client/clientpublic.key ./banque/
cp ./banque/bankpublic.key ./vendeur/

#cat ./banque/clientpublic.key | openssl rsautl -encrypt -inkey ./banque/bankprivate.key | base64 > cheque.txt

touch banque/history.txt

#
cat client/clientpublic.key | openssl enc -e -aes-128-cbc -pass pass:unmdpalaconquelonveutmettre > clientpubkeyAES.bin
echo "Création d'un mot de passe pour chiffrer la clé du client"
echo "unmdpalaconquelonveutmettre" | openssl rsautl -decrypt -inkey banque/bankprivate.key -raw | base64 > chequeByBank.key
