#!/bin/bash

cat chequeByBank.key > chequeCrypteByClient.key
cat facture.txt | openssl rsautl -encrypt -inkey client/clientprivate.key | base64 >> chequeCrypteByClient.key
