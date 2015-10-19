#!/bin/bash

cat chequeByBank.key > chequeCrypteByClient.key
cat facture.txt | openssl rsautl -decrypt -inkey client/clientprivate.key -raw | base64 >> chequeCrypteByClient.key
