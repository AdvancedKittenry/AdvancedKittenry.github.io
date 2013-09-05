% Arvosteluperusteet
<!-- order: xx -->

Työn arvosteluun vaikuttavat valittu aihe, aikataulussa pysyminen, koodin laatu, sovelluksen
käytettävyys sekä dokumentaatio.
Valmiistä työstä voi saada maksimissaan 60 pistettä. 
Pisteet jakautuvat seuraavasti:

Osa-alue                    Minimipistemäärä   Maksimipistemäärä
------------------------  -------------------- -----------------
Aikataulun noudattaminen  9                    15
Koodin laatu              15                   25
Käytettävyys              5                    10 
Dokumentaatio             5                    10
------------------------  -------------------- ------------------

<alert>
Jokaisesta osa-alueesta on saatava vähintään minimipistemäärän verran pisteitä.
Varsinkin dokumentointi ja käytettävyys kannattaa hoitaa kuntoon ajoissa.
</alert>

Ohessa kunkin osa-alueen vaatimia työn ominaisuuksia.

## Aikataulun noudattaminen (15 pistettä)

Jokaisesta onnistuneesta aikataulun palautuksesta saa kolme pistettä. 
Myöhästyneistä palautuksista ei saa pisteitä ja yli kahdesta myöhästymisestä
lentää ulos kurssilta.

## Koodin laatu (25 pistettä)
Koodi on laadukasta ja toimii. Muuttujat, luokat ja metodit on nimetty johdonmukaisesti, 
eikä koodia toisteta turhaan. SQL-kieltä on käytetty asianmukaisesti, turhia
tietokantakyselyjä ei tehdä tai haeta kannasta enempää tietoa kuin on tarpeen.

## Käytettävyys (10 pistettä)

Sovellusta on selkeä, siistin näköinen ja helppo käyttää ja se noudattaa hyväksi todettuja 
käyttöliittymän suunnitteluperiaatteita. Sovelluksen toiminnot on nimetty
johdonmukaisesti ja ne on helppo löytää koko sivuston kattavasta sivunavigaatiosta. 

Sovellus ei koskaan kysy uudestaan tietoja, jotka käyttäjä on jo syöttänyt.
Virheellisten tietojen syöttämisestä annetaan käyttäjälle selkeä virheviesti ja
mahdollisuus korjata virheelliset tiedot kirjoittamatta kaikkia tietoja uudestaan.

## Dokumentaatio (10 pistettä)

Sovelluksen kaikki osa-alueet on dokumentoitu kattavasti ja selkokielisesti
ja sovellus on helppo asentaa ja ottaa käyttöön annetuilla dokumenteilla.
Katso myös [dokumenaatio-ohje](dokumentaatio-ohje.html).

## Pisteiden ja arvosanan suhde

Pisteistä määritellään arvosana seuraavan taulukon ja valitun aiheen maksimiarvosanan mukaisesti.
Läpipääsyyn työstä on saatava vähintään 30 pistettä eli puolet kaikista 
pisteistä, tästä ylöspäin arvosana nousee joka viides piste aina aiheen
maksimiarvosanaan saakka. Jos valitusta aiheesta on toteutettu vain osa
katsotaan maksimiarvosana toteutetun työmäärän mukaisesti.

Pisteet    30  35  40  45  50
---------  --- --- --- --- ---
Arvosana   1   2   3   4   5

Työstä ei voi saada maksimiarvosanaa suurempaa arvosanaa!
Vitosen arvosanamaksimiin vaaditaan työltä ainakin seuraavat:
  
* Kirjautumisen toteuttaminen
* Toteutettavia tietokohteita ainakin kolme
* Vähintään kahteen tietokohteeseen pitää olla toteutettuna täysi [CRUD-nelikko](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete): kohteen luominen, selailu, muokkaus, ja poisto.
* Järjestelmässä on ainakin yksi monesta-moneen suhde tietokantataulujen välillä
