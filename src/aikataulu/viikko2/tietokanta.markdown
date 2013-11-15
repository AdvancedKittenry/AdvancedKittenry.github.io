% Tietokannan suunnittelu
<!-- order: 3 -->

<summary>
* Suunnittele tietokantasi
* Luo dokumentaatioon asiaanliittyvät kaaviot ja kappaleet: 
    * [Järjestelmän tietosisältö]({{rootdir}}dokumentaatio-ohje.html#j%C3%A4rjestelm%C3%A4n-tietosis%C3%A4lt%C3%B6)
    * [Relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio)
* Sijoita uudet kappaleet samaan pdf-tiedostoon kuin aikaisempikin dokumentaatio
</summary>

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
repositoriosi samaan dokumentaatiotiedostoon missä edellisetkin dokumentaatiot olivat.
Lisää myös kaavioiden tuottamiseen käyttämäsi lähdetiedostot
repositoriosi doc-kansioon niin ne pysyvät tallessa muutosten varalta.

## Linkkejä

* [MySql:n dokumentaatio](http://dev.mysql.com/doc/refman/5.1/en/index.html)
* [PostgreSql:n dokumentaatio](http://www.postgresql.org/docs/8.4/interactive/index.html)
* [W3Schoolsin SQL-intro](http://w3schools.com/sql/default.asp)
* Laineen tietokantojen perusteet -kurssin SQL materiaaleja
   * [Osa 1](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa1.pdf)
   * [Osa 2](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa2.pdf)
   * [Osa 3](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa3.pdf)

<next>
Suunniteltuasi kaiken voit toteuttaa käyttöliittymän [HTML:llä]({{rootdir}}ohjeistus/html-opas.html). Tai siirtyä [käytännön tietokantaohjelmointiin]({{rootdir}}ohjeistus/tietokantaohjelmointi/kannan-alustus.html).
</next>
