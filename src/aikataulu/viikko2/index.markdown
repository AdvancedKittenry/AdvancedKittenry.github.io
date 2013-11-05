% Viikko 2
<!-- order: 1 -->

<deadline>{{deadline2}}</deadline>

Toisella viikolla jatketaan työn suunnittelua käytännöllisemmällä
puolella suunnittelemalla työlle käyttöliittymä ja tietokanta.

Tämän jälkeen käyttöliittymästä toteutetaan 
oikean näköiset, mutta epätoiminnalliset raakaversiot HTML:llä,
pystytetään tietokanta users-palvelimelle 
ja tehdään pienimuotoinen testiohjelma sen käyttöön.

Näitä harjoituksia on yleensä paras tulla tekemään pajaan,
jolloin ohjaaja voi antaa vinkkejä niiden tekemisessä.

Viikon tehtävät jakautuvat seuraavasti.
Kunkin otsikon alla olevista asioista saa yhden aikataulupisteen.

<comment>
TODO:
* Tiedostot sovelluksen tietokannan taulujen luomiseen ja alasajoon, tietokannan pystytys 
* Testifilu
* Oma listaus! Hyvin yksinkertainen!
</comment>

## Työn käytännön yksityiskohtien suunnittelu (1p)

Dokumentoi ja suunnittele sovelluksellesi käyttöliittymä ja tietokanta.
Lisäohjeita löytyy seuraavilta sivuilta:

* [Käyttöliittymän suunnittelu](suunnittelu.html).
* [Tietokannan suunnittelu](tietokanta.html) ja dokumentointi.

## Käyttöliittymän toteututus HTML:llä (1p)

Tässä vaiheessa työtä siirrytään suunnittelusta käytäntöön
ja luodaan suunnitelluista sivuista oikean näköiset, mutta
vielä staattiset HTML-versiot. 

Se minne sivut kannattaa sijoittaa riippuu hieman ohjelmointikielestä.
Javan servlet-tekniikalla ainoastaan `web`-hakemistoon laitetut
tiedostot näkyvät selaimella. PHP:llä tätä rajoitusta ei ole,
joskin myöhemmin keskitämme HTML-koodin MVC-mallin mukaisesti omaan hakemistoonsa.

Tässä vaiheessa luo hakemisto `html-demo` ja lähde rakentamaan sinne HTML-versiota työstäsi. 
Javalla tämä hakemisto sijoitetaan `web`-hakemistoon, PHP:llä se voi olla projektin juuressa.
Sijoita kaikki tällä viikolla tekemäsi HTML-tiedostot tuohon kansioon.
Lisää ohjeita HTML-kielen kanssa työskentelyyn löytyy [HTML-oppaasta]({{rootdir}}ohjeistus/html-opas.html).

Toteutettuna pitää olla HTML-versiot seuraavista aiemmin suunnitelluista sivuista:

* [Sivujen runko ja navigaatio sekä etusivu](suunnittelu.html#etusivu-ja-yleisnäkymä-template)
* [Listaussivujen](suunnittelu.html#listanäkymän-suunnittelu) toteuttaminen
* [Muokkaus ja tietonäkymien](suunnittelu.html#muokkaus--ja-tietonäkymät) toteuttaminen

## Tietokannan käytön aloittaminen (1p)

* [Tietokannan pystyttäminen palvelimelle]({{rootdir}}ohjeistus/tietokantaohjelmointi/kannan-alustus.html)
    * Luodaan SQL-tiedostot, joilla kannan rakenteen saa vedettyä ylös ja alas.
    * Käytetään luotuja tiedostoja tietokannan pystyttämiseen
* Otetaan käyttöön [tietokantatestisovellus]({{rootdir}}ohjeistus/tietokantaohjelmointi/testisovellus.html)
    * Sovellus näyttää tietokannan taulut ja niiden sisältöä. Ohjaaja käyttää tätä pysyäkseen paremmin kärryillä tietokannan tilasta.
    * Tämän tulee olla näkyvillä usersin palvelintilassa.
* [Kevyt testisivu]({{rootdir}}ohjeistus/tietokantaohjelmointi/listaustesti/index.html), joka listaa jonkin tietokantataulun sisällön.
    * Käytä tietokannan täyttämiseen `add-test-data.sql`-tiedostoa, niin sivulla on jotain näytettävää.

## Palautus

Lopulta palautuksesi kansiorakenteen pitäisi näyttää suurinpiirtein allaolevalta.
Varmista, että olet ottanut kaikki tarvittavat tiedostot mukaan,
ja että ne myös näkyvät selaimella testausosoitteessasi.

<tabs>
<tab title="PHP-projekti">

~~~~
css/
  bootstrap.css
  ...
doc/
  dokumentaatio.pdf
  relaatiotietokantakaavio.dia
  sivukartta.png
  tietosisältökaavio.dia
fonts/
  ...
html-demo/
  index.html
  kissalista.html
  muokkaakissaa.html
js/
  ...
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
  ...
index.php
listaustesti.php
connectionTest.php
.gitignore
~~~~

</tab>
<tab title="Java: NetBeansillä luotu">

~~~~
doc/
  dokumentaatio.pdf
  relaatiotietokantakaavio.dia
  sivukartta.png
  tietosisältökaavio.dia
src/
  conf/
  java/
    Kissalista/
      Servlets/
        Listaservlet.java
    ...
web/ 
  css/
    bootstrap.css
    ...
  fonts/
    ...
  html-demo/
    index.html
    kissalista.html
    muokkaakissaa.html
  js/
  index.jsp
   ...
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
.gitignore
~~~~

</tab>
<tab title="Java suoraan users:illa">

~~~~
doc/
  dokumentaatio.pdf
  relaatiotietokantakaavio.dia
  sivukartta.png
  tietosisältökaavio.dia
css/
  bootstrap.css
  ...
fonts/
  ...
html-demo/
  index.html
  kissalista.html
  muokkaakissaa.html
js/
  ...
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
src/
  Kissalista/
    Servlets/
      Listaservlet.java
  ...
.gitignore
index.jsp
~~~~

</tab>
</tabs>


NetBeansia käyttävillä on projektissaa todennäköisesti huomattavasti enemmän tiedostoja.
Se ei haittaa.

<alert>
Laita kaikki uusi dokumentaatio kootusti yhteen `dokumentaatio.pdf`-tiedostoon `docs`-kansiossa. Ohjaajasi ei halua arvuutella mistä tiedostosta dokumentaatio löytyy.
</alert>
