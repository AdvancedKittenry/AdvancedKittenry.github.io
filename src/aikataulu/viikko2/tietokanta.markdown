% Tietokannan suunnittelu
<!-- order: 3 -->

Suunniteltuasi sovelluksen ulkoasua, uppoa tietokantataulujen
maailmaan. 
Tee sovelluksellesi alustava käsitekaavio erittelemällä
tekemiltäsi sivuilta ja aihekuvauksesta kaikki tietokohteet
sekä niiden väliset riippuvuudet yhdellä kaaviolla:

![Esimerkki alustavasta käsitekaaviosta]({{myimgdir}}kasitekaavio.jpg)

Tässäkin voi olla vielä järkevää käyttää paperia tai valkotaulua, mutta jossuunnitelma on päässäsi jo selkeä, voit käyttää suoraan kaavio-ohjelmistoa, jolloin jälki on siistimpää.
<expandable title="Siistimpi käsitekaavioversio (avaa tästä)">
![Esimerkki käsitekaaviosta]({{imgdir}}dokumentaatio-ohje/information_diagram.png)
</expandable>

Kaikki tähän alustavaan käsitekaavioon tulevat asiat eivät välttämättä ole
relevantteja ohjelman toteutuksen kannalta. Esimerkiksi
palveluskunta ei kokonaisuutena näyttele juuri mitään roolia
ohjelman toiminnassa, vaan pääosassa ovat sen jäsenet.
Lopullisessa kissalistan toteutuksessa ei tämän takia ole palveluskunta-taulua. 
Hyvänä valintakriteerinä on se, sisältääkö tietokohde jotain omia kenttiään, vai onko se vain täysin osasistaan koostuva kokoelma.

Lähde tämän jälkeen tekemään listaa kunkin kaavion tietokohteen
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
> Kuva                 Kuvatiedosto,      Kuva kissasta
>                      vapaaehtoinen
> 
> Viim. ruokkimis-pvm. Päivämäärä         Koska kissa on viimeksi ruokittu?
> 
> Lisätiedot           Merkkijono,        Kuvaus kissan ominaisuuksista
>                      max. 255 merkkiä   esim. "Serafiina syö vain kalaa."
> 
> Lainaajan nimi       Merkkijono,        Mahdollisen kissan lainaajan nimi
>                      max. 40 merkkiä,
>                      vapaaehtoinen
> -----------------------------------------------------------------------
> 
> Kissa, joka asuu kissatädin kartanossa. Jokainen kissa kuuluu tasan yhteen kissarotuun. Jokaisesta kissasta merkitään ylös sitä viimeksi ruokkinut palvelija.

## Relaatiotietokantakaavio

Tee nyt suunnittelemastasi tietosisällöstä [dokumentaatio-ohjeen mukainen relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio):
![Kissoihin liittymätön relaatiotietokantakaavio]({{imgdir}}dokumentaatio-ohje/relaatiokaavio.gif)

Muista lisätä kaavioon kaikki olennaiset viiteavaimet sekä
monesta-moneen suhteiden tilalle välitaulut.

Tallenna tekemäsi kaaviot ja uusi sisältö 
repositoriosi dokumentaatiotiedostoon.
Lisää myös kaavioiden tuottamiseen käyttämäsi lähdetiedostot
repositoriosi doc-kansioon niin ne pysyvät tallessa muutosten varalta.

## Tietokannan alustustiedostojen luominen

Muistele Tietokantojen perusteet -kurssilla oppimaasi SQL-kieltä ja tutustu valitsemasi tietokannan dokumentaatioon.
Luo sitten repositorioosi sql-kansio ja sijoita siihen kolme sql-tiedostoa:
<code>create-tables.sql</code>, <code>drop-tables.sql</code> ja <code>add-test-data.sql</code>.
Kirjoita näihin tiedostoihin tietokantasi alustavat create table -lauseet, drop table -lauseet, ja testidatan (oletuskäyttäjätunnusten yms.) luominen.

SQL-lauseiden sijoittaminen tiedostoihin mahdollistaa kannan helpon
pystyttämisen ja alasajon. 
Voit ajaa sql-tiedostoon kantaan kirjautumalla usersille
ja käyttämällä unixin _putkitusta_. Esimeriksi PostgreSQL:llä tämä tapahtuu seuraavasti:

~~~~
psql < sql/create-tables.sql
~~~~


Yllä oleva komento suorittaa tiedoston sisältämät SQL-lauseet
tietokannassa. MySQL-versio on samantapainen, mutta komentona on psql:n
sijasta mysql, minkä lisäksi mysql kysyy sinulta salasanaa.

Mikäli haluaa resetoida koko tietokantansa voi ajaa seuraavat kolme komentoa peräkkäin:

~~~~
psql < sql/drop-tables.sql
psql < sql/create-tables.sql
psql < sql/add-test-data.sql
~~~~

Tiedostossa <code>drop-tables.sql</code> kannattaa käyttää pudotuskäskystä
muotoa <code>DROP TABLE IF EXISTS taulun_nimi</code>. 
Näin tietokantataulun puuttuminen ei katkaise komentosarjaa. 
Viiteavaimien takia joudut myös yleensä kirjoittamaan pudotuskäskyt päinvastaisessa
järjestyksessä luontilauseisiin nähden. Muuten viite-eheystarkistukset eivät välttämättä anna ajaa kantaa alas.


<next>
Suunniteltuasi kaiken tee suunnitelmistasi demoversiot [HTML:llä ja CSS:llä](html-versioiden-luonti.html).
</next>
