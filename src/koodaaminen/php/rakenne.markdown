% Sovelluksen rakenne ja kontrollerit
<!-- order: 1 -->
<!-- addHeaderNavigation -->

<summary>

* Sovelluksen sivut ovat projektin juuressa olevia kontrollereita, jotka käyttävät malleja ja näkymiä.
* Kaikki näkymät menevät kansioon `views`
* Tee sovelluksesi yleisesti käytetyille toiminnoille kirjastotiedosto, johon voi sijoittaa yleiskäyttöisiä toimintoja.
* Kaikki kirjastotiedostot menevät omaan kansioonsa, esim. `libs`.
* Mallit voi sijoittaa kirjastotiedostojen mukana omaan kansioonsa. Esim. `libs/models`.

Lopullisen projektin pitäisi noudatella tämäntapaista kansiorakennetta

~~~~<include src="esimerkit/rakenne/kansiorakenne.txt" />~~~~

</summary>

PHP on historialtaan ja luonteeltaan selkeä [skriptikieli](http://fi.wikipedia.org/wiki/Komentosarjakieli). 
Toisin kuin useimmat käännettävien ohjelmointikielien
ohjelmat, PHP-ohjelmalla ei ole erityistä nimettyä alkukohtaa,
vaan suoritus alkaa tiedoston alusta ja jatkuu siitä tiedoston loppuun,
ellei sitä erikseen keskeytetä.

Lisäksi PHP eroaa hieman useimmista muista web-ohjelmointikielistä
suoraviivaisessa lähestymisessään URL-osoitteiden ja 
suoritettavan ohjelmakoodin väliseen riippuvuuteen.

Perussääntö on hyvin yksinkertainen, jokainen 
tiedosto näkyy oman URL:insa takana sillä palvelimella,
minne tiedostot on sijoitettu. 

Eräänlaisena poikkeuksena toimivat etusivut:
Jos syöttää osoitekenttään pelkän hakemiston osoitteen,
esim. `http://tunnus.users.cs.helsinki.fi` on se sama kuin kirjoittaisi
`http://tunnus.users.cs.helsinki.fi/index.php`, kunhan htdocs-kansiossa on `index.php`-tiedosto.

On periaatteessa täysin mahdollista tehdä php-sivuja, joissa
jokainen ladattava sivu tuotetaan tasan yhdellä php-tiedostolla.

Tästä johtuen yksinkertaisin tapa toteuttaa yksittäisen toiminnon kontrolleri PHP:llä
ei oikeastaan vaadi muuta kuin sopivaan osoitteeseen sijoitetun PHP-tiedoston,
joka kutsuu tarvitsemiaan kirjastoja tuottaakseen 
käyttäjälle halutun vastauksen aineistopyyntöön.

## Spagettikoodi ja kontrolleri

Tiiviimmillään ja rumimmillaan tämä näkyy vieläkin ikävän yleisenä _spagettikoodina_,
jossa sovelluksen kaikki kolme osaa: kontrolleri, näkymä ja malli
ovat sulassa sovussa ja sekasotkussa samassa tiedostossa. 
Lopputulos on vähänkään monimutkaisemmissa sovelluksissa sekava ja vaikea muuttaa.

**spagettikoodi.php**

~~~~php<include src="esimerkit/rakenne/spagettikoodi.php" />~~~~

Tällä kurssilla pyrimme hieman selkeämpään [arkkitehtuuriin]({{rootdir}}koodaaminen/arkkitehtuuri/index.html),
jossa mallit ja näkymät määritellään omissa tiedostoissaan.

Tämä ei kuitenkaan varsinaisesti estä käyttämästä PHP:n suoraviivaista luonnetta
siihen, että jätämme varsinaiset kontrollerit paljaaksi koodiksi,
joka vain suoraan kutsuu erilaisia kirjastoja ja näyttää lopulta näkymän.

Esimerkkinä kuvitteellisen kissalistan kontrolleri:

**kissalista.php**

~~~~php<include src="esimerkit/rakenne/kasittelija.php" />~~~~

Jotta yllä oleva esimerkki toimisi, on luotava sen tueksi malliluokat,
näkymät ja muutama yleiskäyttöinen luokka ja funktio. 

## Mallit

Sijoita projektin mallit omaan kansioonsa kirjastokansiosi alle,
siten että kussakin tiedostossa on yksi malliluokka.

Sijoita malliisi kentät tietokantataulun kenttiä varten
ja luo kentille getterit ja setterit sekä halutessasi konstruktori, joka ottaa kenttien arvot vastaan.

Työn edetessä teemme luokkiin metodeja, 
jotka osaavat hakea olioihin sisältöä tietokannasta,
sekä metodit, joilla tietoa päivitetään takaisin kantaan.

<next>
Seuraavaksi tutustumme tarkemmin 
[näkymien toteuttamiseen](nakymat.html).
</next>
