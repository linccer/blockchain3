# Išmanioji sutartis

## Verslo logika
Išmaniojoje sutartyje dalyvauja 2 šalys - sushi restoranas ir klientas.
Restoranas ruošia ir parduoda maistą, o klientas teikia užsakymus.
![Screenshot](/images/image7.png)

## Realizacija
Aprašyta verslo logika realizuota solidity kalboje.

## Testavimas lokaliame tinkle
Naudojant Truffle ir Ganache sutartis ištestuota lokaliame tinkle.
Komandos 'truffle test' rezultatai:
![Screenshot](/images/image5.png)
3-iasis Test.js aprašytas atvejis simuliuoja sutarties vykdymą. Klientas iš restorano nusiperka 'California roll' kurio kaina yra 5 eteriai. Ganache matomas balansų pakitimas - 5 eteriai atimami iš antrosios sąskaitos balanso ir pridedami prie pirmosios sąskaitos balanso:
![Screenshot](/images/image6.png)

## Testavimas Sepolia testnet
Kodas sukompiliuotas ir sutartis paleista sepolia testiniame tinkle, naudojant truffle komandas:
- truffle compile
- truffle migrate --network sepolia

Gautas sutarties adresas:
![Screenshot](/images/image1.png)

Pagal adresą sutartis rasta Etherscan:
![Screenshot](/images/image2.png)

Pakeitus keletą Test.js eilučių bei suvedus truffle test komandą, sutartis praeina Test.js aprašytus testus ir Sepolia tinkle:
![Screenshot](/images/image4.png)
