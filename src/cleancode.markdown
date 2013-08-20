% Hyvä ohjelmointityyli

Hyvää ohjelmakoodia on helppo lukea ja asiat on siinä järjestetty
johdonmukaisesti.
Pyri siihen, että ohjelmakoodisi toiminta on mahdollista ymmärtää ensi silmäyksellä
vielä siinäkin vaiheessa kun koodi on päässyt unohtumaan työmuistista.

## Nimeä asiat selkeästi ja johdonmukaisesti

* Koskee luokkia, metodeja, attribuutteja, parametreja, funktioita, tiedostoja, tietokantatauluja ja muuttujia. Siis aivan kaikkea, millä on nimi.
* Käytä mahdollisimman kuvaavia nimiä kaikkialla
* Muuttujat, joilla on iso käyttöalue, tulee olla erittäin selkeästi (vaikka pitkästi) nimettyjä.
* Lyhyen metodin sisäisille muuttujille riittää yleensä lyhyt nimi.
* Jos metodia käytetään vähän, tulee nimen olla mahdollisimman kuvaava.
* Jos metodia käytetään useassa kohdassa koodia, voi sen nimi olla lyhyt ja ytimekäs.
* Älä käytä ääkkösiä, Ei myöskään kannata sekoita eri kieliä, esim. suomea ja englantia.

## Ei pitkiä metodeja

* Sovelluslogiikan metodin pituuden tulee ilman erittäin hyvää syytä olla korkeintaan 10 riviä, mieluiten 5.
* Pitkät metodit tulee jakaa useampiin metodeihin.
* Yksi metodi – yksi pieni tehtävä. (Single Responsibility)
* Helpottaa myös testaamista
* Jos metodin voi jakaa useampaan metodiin, niin silloinhan se jo tekee useamman metodin hommat.

## Ei copy-pastea

* Toistuvan koodin saa lähes aina hävitettyä
* Tapauksesta riippuen luo metodi tai yliluokka, joka sisältää toistuvan koodin
* Toistuvien HTML-pätkien tapauksessa kannattaa harkita koodinpätkän siirtämistä omaan tiedostoonsa.

## Luokkien Single Responsibility

* Luokkien ja tiedostojen tulisi hoitaa vain yhtä asiaa
* Esimerkiksi tietokannan avaamista EI tulisi löytyä useasta paikasta 
* Tee oma luokka/asetustiedosto tietokannan avaamiselle.
* Eriytä käyttöliittymä ja sovelluslogiikka
* Kaikki HTML tulisi tuottaa käyttöliittymäkoodissa
* Sovelluslogiikkaan liittyviä laskuja ja tietokantakyselyjä ei tehdä käyttöliittymässä
