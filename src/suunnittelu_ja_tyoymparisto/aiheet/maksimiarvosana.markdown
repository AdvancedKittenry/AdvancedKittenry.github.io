<!-- hidden! -->

### Arvosanamaksimi

Kullekin aiheelle on määritelty maksimiarvosana, joka kuvaa karkeasti työn laajuutta.
Arvosanamaksimiin vaikuttaa neljä kriteeriä, joista jokaisen
pitää täyttyä vitosen arvosanamaksimia varten:

<expandable title="Kirjautumisen toteuttaminen">

Sovelluksessa pitää olla toteutettuna perinteinen käyttäjien
tunnistaminen käyttäätunnuksella ja salasanalla.
Käyttäjien tiedot on haettava tietokannasta.

</expandable>
<expandable title="Toteutettavia tietokohteita ainakin kolme">
Sovelluksessa pitää olla ainakin kolme jotakin olennaista tietoa sisältävää tietokantataulua. 
Taulujen pitää sisältää käyttäjälle suoraan relevanttia tietoa.
Tälläisiä kohteita ovat esimerkiksi [muistilistan askare]({{rootdir}}suunnittelu_ja_tyoymparisto/aiheet/Muistilista.html) 
tai käyttäjän kirjautumistiedot.

Tähän määrään ei lasketa tauluja, jotka ovat puhtaita 
liitostauluja kahden muun taulun välillä. 

</expandable>
<expandable title="Vähintään kahden tietokohteen tietokantataulua pitää pystyä muokkaamaan täysin">
  Sovelluksen käyttötapauksiin on kuuluttava vähintään
  kahden kohteen kohdalla ns.
  [CRUD-nelikko](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete) eli kohteen luominen, selailu, muokkaus, ja poisto.
</expandable>
<expandable title="Ainakin yksi monesta-moneen suhde tietokantataulujen välillä">
  Sovelluksessa on oltava ainakin kaksi taulua, joiden välillä on   *monesta moneen -suhde*. Tämä tarkoittaa sitä, että kummankin taulun olioon voi jollain tapaa liittyä mielivaltainen lukumäärä toisen taulun olioita. Tälläisiä suhteita voivat olla vaikkapa 
[keskustelufoorumin]({{rootdir}}suunnittelu_ja_tyoymparisto/aiheet/Keskustelufoorumi.html) käyttäjien ja keskustelujen välillä oleva "on-kirjoittanut tähän keskuteluun" -suhde tai 
[Pokémon-tietokannan]({{rootdir}}suunnittelu_ja_tyoymparisto/aiheet/Pokemon-kanta.html) käyttäjän ja pokémon-lajin välinen omistussuhde.

</expandable>


Parityön aiheeksi kelpaa ainoastaan vitosen arvosanamaksimilla varustettu aihe.

