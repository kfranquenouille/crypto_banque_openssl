#!/bin/bash

re='^[0-9]+$'
if ! [[ $1 =~ $re ]] ; then
   echo "Usage : bash creerFacture.sh <montant>" >&2; exit 1
fi

number=`shuf -i 100000-9999999999999999999 -n 1`

echo $1 > facture.txt
echo $number >> facture.txt

