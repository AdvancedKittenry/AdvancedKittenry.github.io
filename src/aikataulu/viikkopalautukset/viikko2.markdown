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

## Käyttöliittymän suunnittelu (puoli pistettä)

Dokumentoi ja suunnittele sovelluksellesi käyttöliittymä
seuraamalla
[käyttöliittymän suunnitteluohjetta]({{rootdir}}suunnittelu/kayttoliittyma.html).
Lopputuloksena pitäisi dokumentaatiossa olla käyttöliittymäkaavio.
Liitä myös tekemäsi muut suunnitelmat (etenkin yleisnavigaatio)
repositorioosi, ellet ole näyttänyt niitä ohjaajalle pajassa.

## Käyttöliittymän toteututus HTML:llä (1p)

Siirrytään suunnittelusta käytäntöön
ja luodaan suunnitelluista sivuista oikean näköiset, mutta
vielä staattiset HTML-versiot. 

Se minne sivut kannattaa sijoittaa riippuu hieman ohjelmointikielestä.
Javan servlet-tekniikalla ainoastaan `web`-hakemistoon laitetut
tiedostot näkyvät selaimella. PHP:llä tätä rajoitusta ei ole,
joskin myöhemmin keskitämme HTML-koodin MVC-mallin mukaisesti omaan hakemistoonsa.

Tässä vaiheessa luo hakemisto `html-demo` ja lähde rakentamaan sinne HTML-versiota työstäsi. 
Javalla tämä hakemisto sijoitetaan `web`-hakemistoon, PHP:llä se voi olla projektin juuressa.
Sijoita kaikki tällä viikolla tekemäsi HTML-tiedostot tuohon kansioon.
Lisää ohjeita HTML-kielen kanssa työskentelyyn löytyy [HTML-oppaasta]({{rootdir}}koodaaminen/html-opas.html).

Toteutettuna pitää olla HTML-versiot seuraavista aiemmin suunnitelluista sivuista (linkit suunnitteluohjeeseen):

* [Sivujen runko ja navigaatio sekä etusivu]({{rootdir}}suunnittelu/kayttoliittyma.html#etusivu-ja-yleisnäkymä-template)
* [Listaussivujen]({{rootdir}}suunnittelu/kayttoliittyma.html#listanäkymän-suunnittelu) toteuttaminen
* [Muokkaus ja tietonäkymien]({{rootdir}}suunnittelu/kayttoliittyma.html#muokkaus--ja-tietonäkymät) toteuttaminen

## Tietokannan käytön aloittaminen (1p)

Suunnittele ja dokumentoi sovelluksellesi tietokanta
sekä sanallisella että kooditasolla.
Aloita sivulta 
[tietokannan suunnittelu]({{rootdir}}suunnittelu/tietokanta.html).

* [Tietokannan pystyttäminen palvelimelle]({{rootdir}}koodaaminen/kannan-alustus.html)
    * Luodaan SQL-tiedostot, joilla kannan rakenteen saa vedettyä ylös ja alas.
    * Käytetään luotuja tiedostoja tietokannan pystyttämiseen
* Otetaan käyttöön [tietokantatestisovellus]({{rootdir}}koodaaminen/testisovellus.html)
    * Sovellus näyttää tietokannan taulut ja niiden sisältöä. Ohjaaja käyttää tätä pysyäkseen paremmin kärryillä tietokannan tilasta.
    * Tämän tulee olla näkyvillä usersin palvelintilassa.
* Tarvitset koodaamiseen [tietokantayhteyden muodostavan koodin]({{rootdir}}koodaaminen/tietokantayhteys/index.html), joka pitää sijoittaa omaan tiedostoonsa.
* Tee yhteyttä käyttävä [kevyt testisivu]({{rootdir}}koodaaminen/listaustesti/index.html), joka listaa jonkin tietokantataulun sisällön.
    * Käytä tietokannan täyttämiseen `add-test-data.sql`-tiedostoa, niin sivulla on jotain näytettävää.

## Tietokannan rakenteen dokumentoiminen (puoli pistettä)

Tee lopuksi lista kunkin kaavion tietokohteen
sisältämistä tietokentistä, niiden tyypeistä ja rooleista sovelluksessa.
Liitä kenttien kuvaukset taulukkoina dokumentaatioon. 
Myös yhteydet toisiin kohteisiin täytyy määritellä. 
Lopputuloksen kuuluu näyttää tämäntapaiselta:

> **Tietokohde: Kissa**
> 
> ------------------------------------------------------------------------
> Attribuutti          Arvojoukko         Kuvailu
> -------------------- ------------------ -------------------------------
> Nimi                 Merkkijono,        Kissan nimi
>                      max. 80 merkkiä    
> 
> Väri                 Merkkijono,        Kuvaus kissan väristä
>                      max. 30 merkkiä    esim. "valkotäplikäs oranssi"
> 
> Viim. ruokkimis-pvm. Päivämäärä         Koska kissa on viimeksi ruokittu?
> 
> Lisätiedot           Merkkijono,        Kuvaus kissan ominaisuuksista
>                      max. 255 merkkiä   esim. "Serafiina syö vain kalaa."
> 
> -----------------------------------------------------------------------
> 
> Kissa, joka asuu kissatädin kartanossa. Jokainen kissa kuuluu tasan yhteen kissarotuun. Jokaisesta kissasta merkitään ylös sitä viimeksi ruokkinut palvelija.

### Relaatiotietokantakaavio

Tee lopuksi suunnittelemastasi tietosisällöstä [dokumentaatio-ohjeen mukainen relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio):
![Kissoihin liittymätön relaatiotietokantakaavio]({{imgdir}}dokumentaatio-ohje/relaatiokaavio.gif)

Muista lisätä kaavioon kaikki olennaiset viiteavaimet sekä
monesta-moneen suhteiden tilalle välitaulut.

Tallenna tekemäsi kaaviot ja uusi sisältö 
repositoriosi samaan dokumentaatiotiedostoon missä edellisetkin dokumentaatiot olivat.
Lisää myös kaavioiden tuottamiseen käyttämäsi lähdetiedostot
repositoriosi doc-kansioon niin ne pysyvät tallessa muutosten varalta.

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
  muokkaakissaa.html
js/
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


NetBeansia käyttävillä on projektissaa todennäköisesti huomattavasti enemmän tiedostoja.
Se ei haittaa.

<alert>
Laita kaikki uusi dokumentaatio kootusti yhteen `dokumentaatio.pdf`-tiedostoon `docs`-kansiossa. Ohjaajasi ei halua arvuutella mistä tiedostosta dokumentaatio löytyy.
</alert>
