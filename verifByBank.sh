#!/bin/bash

MDP=`cat chequeCrypteByClient.key | sed -n 1,5p | base64 -d | openssl rsautl -encrypt -inkey vendeur/bankpublic.key -pubin -raw`

#echo $MDP

PUBKEYCL=`cat clientpubkeyAES.bin | openssl aes-128-cbc -d -pass pass:$MDP`

echo $PUBKEYCL > pubKeyClientDecrypt.key

cat pubKeyClientDecrypt.key | tr ' ' '\n' > pubKeyClientDecrypt2.key

cat banque/clientpublic.key | sed -n 1p > correct.key
cat pubKeyClientDecrypt2.key | sed -n 4,7p >> correct.key
cat banque/clientpublic.key | sed -n 6p >> correct.key

DATA=`cat chequeCrypteByClient.key | sed -n 6,8p | base64 -d | openssl rsautl -encrypt -inkey correct.key -pubin -raw`

echo $DATA > decryptedfacture.txt
GREP=$(grep -F -f decryptedfacture.txt banque/history.txt) 
if [ "$GREP" == "" ] 
then
    echo $DATA >> banque/history.txt
    echo "Cheque OK"
else
	echo "ERREUR : Chèque déjà encaissé !"
fi

rm pubKeyClientDecrypt.key
rm pubKeyClientDecrypt2.key
rm correct.key
rm decryptedfacture.txt
