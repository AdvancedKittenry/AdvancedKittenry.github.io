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

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset. Kunkin otsikon alla olevista asioista saa suluissa määritellyt aikataulupisteet.

## Käyttöliittymän suunnittelu ja toteutus (1½p)

Dokumentoi ja suunnittele sovelluksellesi käyttöliittymä
seuraamalla
[käyttöliittymän suunnitteluohjetta]({{rootdir}}suunnittelu/kayttoliittyma.html).
Lopputuloksena pitäisi dokumentaatiossa olla käyttöliittymäkaavio.
Liitä myös tekemäsi muut suunnitelmat (etenkin yleisnavigaatio)
repositorioosi, ellet ole näyttänyt niitä ohjaajalle pajassa.

Suunnitelmien perusteella luodaan sivuista oikean näköiset, mutta
vielä staattiset HTML-versiot. 

Se minne sivut kannattaa sijoittaa riippuu hieman ohjelmointikielestä.
Javan servlet-tekniikalla ainoastaan `web`-hakemistoon laitetut
tiedostot näkyvät selaimella. PHP:llä tätä rajoitusta ei ole,
joskin myöhemmin keskitämme HTML-koodin MVC-mallin mukaisesti omaan hakemistoonsa.

Tässä vaiheessa luo hakemisto `html-demo` ja lähde rakentamaan sinne HTML-versiota työstäsi. 
Javalla tämä hakemisto sijoitetaan `web`-hakemistoon, PHP:llä se voi olla projektin juuressa.
Sijoita kaikki tällä viikolla tekemäsi HTML-tiedostot tuohon kansioon.
Lisää ohjeita HTML-kielen kanssa työskentelyyn löytyy [HTML-oppaasta]({{rootdir}}koodaaminen/html-opas.html).

Toteutettuna pitää olla HTML-versiot seuraavista aiemmin suunnitelluista sivuista:

* Sivujen runko ja navigaatio 
* Etusivu
* Listaussivut
* Muokkaus ja tietonäkymät

<ohje>
Aloita sivulta 
[käyttöliittymän suunnittelu]({{rootdir}}suunnittelu/kayttoliittyma.html).
ja seuraa vihreitä ohjelaatikoita.
</ohje>

## Tietokannan käytön aloittaminen ja dokumentointi (1½p)

Suunnittele ja dokumentoi sovelluksellesi tietokanta
sekä sanallisella että kooditasolla.
Pisteistä puolikas piste tulee dokumentaatiosta.

* [Tietokannan pystyttäminen palvelimelle]({{rootdir}}koodaaminen/kannan-alustus.html)
    * Luo SQL-tiedostot, joilla kannan rakenteen saa vedettyä ylös ja alas.
    * Käytä luotuja tiedostoja tietokannan pystyttämiseen
* Ota käyttöön [tietokantatestisovellus]({{rootdir}}koodaaminen/testisovellus.html)
    * Sovellus näyttää tietokannan taulut ja niiden sisältöä. Ohjaaja käyttää tätä pysyäkseen paremmin kärryillä tietokannan tilasta.
    * Testisovelluksen tulee näkyä Users-palvelimella.
* Tarvitset koodaamiseen tietokantayhteyden muodostavan koodi, joka pitää sijoittaa omaan tiedostoonsa.
* Tee yhteyttä käyttävä kevyt testisivu, joka listaa jonkin tietokantataulun kaikkilta riveiltä jotakin, esimerkiksi jokaisen käyttäjän nimen.
    * Käytä tietokannan täyttämiseen `add-test-data.sql`-tiedostoa, niin sivulla on jotain näytettävää.
* Dokumentaatioon lisätään asiaanliittyvät kaaviot ja kappaleet
Järjestelmän tietosisältö ja Relaatiotietokantakaavio

<ohje>
Aloita sivulta 
[tietokannan suunnittelu]({{rootdir}}suunnittelu/tietokanta.html).
ja seuraa vihreitä ohjelaatikoita.
</ohje>

## Palautus ja esittelysivun päivittäminen

Laita lopuksi kaikki tekemäsi uudet tiedostot git-repositorioosi.
(ConnectionTest-sovellusta ei tosin ole tarpeellista laittaa repositorioon).
Päivitä [esittelysivullesi](esittelysivu.html)
linkit omaan sivutilaasi pystyttämääsi
Connectiontest-sovellukseen,
HTML-demosivujen etusivulle sekä
tekemäsi oman tietokantalistaukseen.
Mallia linkkeihin voi katsoa 
[valmiin sivun näköisversiosta]({{rootdir}}src/{{curdir}}esittelysivu/esittelysivu-lopullinen.html).

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
  muokkaakissaa.html js/
  ...
libs/
  tietokantayhteys.php
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
  ...
esittelysivu.html
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
      Models/
        Tietokanta.java
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
  esittelysivu.html
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
    Models/
      Tietokanta.java
    Servlets/
      Listaservlet.java
  ...
.gitignore
esittelysivu.html
index.jsp
~~~~

</tab>
</tabs>


NetBeansia käyttävillä on projektissaan todennäköisesti huomattavasti enemmän tiedostoja.
Se ei haittaa.

<alert>
Laita kaikki uusi dokumentaatio kootusti yhteen `dokumentaatio.pdf`-tiedostoon `docs`-kansiossa. Ohjaajasi ei halua arvuutella mistä tiedostosta dokumentaatio löytyy.
</alert>
