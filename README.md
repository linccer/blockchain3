# Išmanioji sutartis

## Verslo logika

## Realizacija
Aprašyta verslo logika realizuota solidity kalboje.

## Testavimas lokaliame tinkle

## Testavimas Sepolia testnet
Kodas sukompiliuotas ir sutartis paleista sepolia testiniame tinkle, naudojant truffle komandas:
- truffle compile
- truffle migrate --network sepolia

Gautas sutarties adresas:
![Screenshot](/images/image1.png)

Pagal adresą sutartis rasta Etherscan:
![Screenshot](/images/image2.png)

Pakeitus keletą Test.js eilučių bei suvedus truffle test komandą, sutartis praeina Test.js aprašytus testus ir Sepolia tinkle:
![Screenshot](/images/image3.png)
