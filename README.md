# Chèque de banque numérique
### Auteurs :
Kevin FRANQUENOUILLE
Christophe LOUCHART

## HOW TO
1. `bash generateKey.sh`
2. `bash creerFacture.sh <montant>`
3. `bash creerCheque.sh`
4. `bash verifByVendor.sh`
5. `bash verifByBank.sh`
6. `bash clean.sh`

## Explications
1. On génère les dossiers, le talon de chèque et l'historique de la banque.
2. Le vendeur crée la facture avec un montant. Un ID de transaction est présent.
3. Le client remplit le chèque et chiffre le tout.
4. Le vendeur vérifie le chèque que le client a rempli.
5. La banque encaisse ou non le chèque et garde un historique de ce qui a été encaissé.
6. On clean le projet une fois que l'on a tout fini.
