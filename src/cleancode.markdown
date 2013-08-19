% Ohjelmointityyli

## Nimeä luokat, metodit, attribuutit, parametrit ja muuttujat selkeästi ja johdonmukaisesti

Käytä mahdollisimman kuvaavia nimiä kaikkialla
Muuttujat, joilla on iso käyttöalue, tulee olla erittäin selkeästi (vaikka pitkästi) nimettyjä.
Lyhyen metodin sisäisille muuttujille riittää yleensä lyhyt nimi.
Jos metodia käytetään vähän, tulee nimen olla mahdollisimman kuvaava.
Jos metodia käytetään useassa kohdassa koodia, voi sen nimi olla lyhyt ja ytimekäs.
Älä käytä ääkkösiä
Huomaa: tee uudelleennimeäminen NetBeansin Refactor/rename-ominaisuuden avulla, ks kohta refaktorointi

## Ei pitkiä metodeja

Sovelluslogiikan metodin pituuden tulee ilman erittäin hyvää syytä olla korkeintaan 10 riviä, mieluiten ##
Pitkät metodit tulee jakaa useampiin metodeihin.
Yksi metodi – yksi pieni tehtävä. (Single Responsibility)
Helpottaa myös testaamista
Jos metodin voi jakaa useampaan metodiin, niin silloinhan se jo tekee useamman metodin hommat.

## Ei copy-pastea

Toistuvan koodin saa lähes aina hävitettyä
Tapauksesta riippuen luo metodi tai yliluokka, joka sisältää toistuvan koodin

## Luokkien Single Responsibility

Luokkien tulisi hoitaa vain yhtä asiaa
Esimerkiksi tiedoston lukemista tai -kirjoittamista EI tulisi löytyä useasta luokasta
Tee oma luokka tiedostojen käsittelylle
Eriytä käyttöliittymä ja sovelluslogiikka
Kaikki tulostaminen tulisi tapahtua käyttöliittymässä
Sovelluslogiikkaan liittyviä laskuja ja tapahtumia ei tehdä käyttöliittymässä
Edellinen mahdollistaa helpon siirtymän tekstikäyttöliittymästä graafiseen
