#!/bin/bash

if [ ! -f "./facture.txt" ];then echo "ERREUR : Déjà vérifié ou pas de facture !"; exit 1;fi

MDP=`cat chequeCrypteByClient.key | sed -n 1,5p | base64 -d | openssl rsautl -encrypt -inkey banque/bankpublic.key -pubin -raw`

#echo $MDP

PUBKEYCL=`cat clientpubkeyAES.bin | openssl aes-128-cbc -d -pass pass:$MDP`

echo $PUBKEYCL > pubKeyClientDecrypt.key

cat pubKeyClientDecrypt.key | tr ' ' '\n' > pubKeyClientDecrypt2.key

cat client/clientpublic.key | sed -n 1p > correct.key
cat pubKeyClientDecrypt2.key | sed -n 4,7p >> correct.key
cat client/clientpublic.key | sed -n 6p >> correct.key

DATA=`cat chequeCrypteByClient.key | sed -n 6,8p | base64 -d | openssl rsautl -encrypt -inkey correct.key -pubin -raw`

echo $DATA | tr ' ' '\n' > decryptedfacture.txt

DIFF=$(diff -b decryptedfacture.txt facture.txt) 
if [ "$DIFF" == "" ] 
then
    echo "Cheque OK pour le vendeur"
fi

rm facture.txt
rm pubKeyClientDecrypt.key
rm pubKeyClientDecrypt2.key
rm correct.key
rm decryptedfacture.txt
