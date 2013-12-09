% Viikko 1
<!-- order: 1 -->

<deadline>{{deadline1}}</deadline>

Viikon tehtävät jakautuvat seuraavasti.
Kunkin otsikon alla olevista asioista saa suluissa ilmoitetut aikataulupisteet. Pisteet ovat nähtävillä tietokantasovelluksen [labtoolissa][labtool].

## Aiheen, ohjelmointikielen ja tietokantapalvelimen valinta (Yht. 1p)

* [Aiheen valinta]({{rootdir}}suunnittelu/aiheet/index.html)
* [Ohjelmointikielen valinta]({{rootdir}}suunnittelu/ohjelmointikielet.html)
* [Tietokantapalvelimen valinta]({{rootdir}}suunnittelu/tietokannan-valinta.html)

## Ympäristöjen pystytys (puoli pistettä)

Aloita lukemalla ohjeistuksista [users-palvelimeen liittyvä sivut]({{rootdir}}pystytys/index.html). 
Pystytä siellä olevien [ohjeiden]({{rootdir}}pystytys/kayttoonotto/index.html) mukaan käyttämäsi ohjelmointikielen ja tietokannan tuki. 

Varsinkin Javalla koodatessa kannattaa pystyttää projektiansa varten 
[NetBeans-projekti]({{rootdir}}pystytys/netbeans/java.html).
NetBeans helpottaa myös PHP-projektien koodaamista ja osaa
mm. [automaattisesti pystyttää PHP-projektin usersille]({{rootdir}}pystytys/netbeans/php.html).

Tämän jälkeen testaa että käyttämäsi kieli toimii siten että saat jotakin näkyviin selaimellasi.
Tee pystytysohjeiden mukaan juuri aktivoimaasi nettisivutilaan
lyhyt testitiedosto, joka lausuu käyttäjälle tervehdyksen.

Tiedoston tarkalla sisällöllä ei ole väliä. Tärkeintä on, että sen saa näkymään selaimella julkisessa internetissä.


<huomio>
Pystytyksestä saa pisteen vain, mikäli saa työnsä näkymään ohjaajankin koneella ja selaimella.
Tietokantasovelluksia pitää pystyä alusta saakka testaamaan hyvän palautteen antamiseksi.
</huomio>

## Työn dokumentoinnin aloittaminen (1p)

Avaa mieleisesi tekstinkäsittelyohjelma ja tutustu
[dokumentaatio-ohjeen]({{rootdir}}dokumentaatio-ohje.html) avulla miten tuotetaan dokumentaation kolme ensimmäistä lukua 
[Johdanto]({{rootdir}}dokumentaatio-ohje.html#johdanto),
[Yleiskuva järjestelmästä ]({{rootdir}}dokumentaatio-ohje.html#yleiskuva-j%C3%A4rjestelm%C3%A4st%C3%A4) ja 
[Käyttötapaukset]({{rootdir}}dokumentaatio-ohje.html#k%C3%A4ytt%C3%B6tapaukset).

Kirjoita johdantoon kuvaus valitsemastasi aiheesta ja ohjelmointikielestä, sekä mahdollisista muista tekniikoista ja kirjastoista mitä aiot käyttää työssäsi. 

Mieti sen jälkeen mitä käyttötapauksia työssäsi voisi olla. Aihekuvauksissa annetut toimintolistat ovat hyvä lähtökohta,
joskaan nämä listat eivät ole täydellisiä. Nimeä eri sidosryhmät ja piirrä näistä kaikista kaavio. 
Lopuksi tallenna työsi pdf-tiedostoksi nimellä `dokumentaatio.pdf`. 
Tiedostolla on tässä vaiheessa pituutta noin muutama sivu plus mahdolliset kansilehdet ja sisällysluettelot.

## Versionhallinnan pystytys  (puoli pistettä)

Tietokantasovellus-kurssilla käytetään versionhallintana git:iä ja
oletuksena repositoriot sijoitetaan github.com-palveluun. Jos et ole 
aikaisemmin käyttänyt git:iä niin verestä muistiasi
ohjelmoinnin harjoitustyön [git-ohjeella](https://github.com/javaLabra/Javalabra2013-1/wiki/Git-ohje).

Ohjeita noudattamalla luo itsellesi tietokantasovellusta varten oma repositorio.
Luo siihen kansio nimeltä `doc` ja sijoita siihen kaikki
tähän mennessä tekemäsi dokumentaatio. Voit sijoittaa kansioon kaikki
tarvitsemasi dokumentaatioon liittyvät tiedostot kunhan pidät huolen
siitä, että siellä on tietokantasovelluksen [päädokumentti]({{rootdir}}dokumentaatio-ohje.html)
nimellä `dokumentaatio.pdf`. Tuo PDF-tiedosto on se, jonka ohjaajasi lukee, 
mutta on hyvä pitää lähdetiedostotkin versionhallinnassa.

Ensimmäisen viikon palautuksen kansiorakenne näyttää siis todennäköisimmin seuraavanalaiselta:

~~~~
doc/
  dokumentaatio.pdf
  dokumentaatio.odt
~~~~

Kopioi työsi myös usersille. PHP:tä NetBeansillä koodaaville tämä on automaattista.
Javalla helpoin tapa on [kopioida projektin war-tiedosto Tomcatin webapps-hakemistoon]({{rootdir}}pystytys/java-war-paketit.html).

Mikäli kopioit töitä käsin, helpointa on pystyttää git-repositoriosi users:ille ja käyttää sitä tiedostojen synkkaamiseen.
PHP:tä käytettäessä luo repositoriollesi ja työllesi oma alihakemisto `htdocs`:in alle.

<ohje>
Aloita [aiheen valinnasta]({{rootdir}}suunnittelu/aiheet/index.html) ja seuraa vihreitä ohjelaatikoita. 
Dokumentoi sen jälkeen työsi ja sijoita tiedostosi versionhallintaan.

Kun olet tehnyt kaikki viikon tehtävät, 
mene osoitteeseen [http://tsoha-labtool.herokuapp.com/](http://tsoha-labtool.herokuapp.com/)
ja rekisteröi itsesi kurssille. 
Labtool on laitoksen harjoitustöitä varten kehitetty pisteidenseurantajärjestelmä, 
johon kaikki tämänkin kurssin palautteet annetaan.

Varmista, että sinulla on toimiva ja internettiin näkyvä testisivu sovelluksellesi.

Tällä hetkellä labtool ei valitettavasti hyväksy muita versionhallintaosoitteita kuin GitHubiin osoittavat. Tästä ei tosin useimmille pitäisi koitua mitään ongelmaa.
</ohje>

[labtool]: http://tsoha-labtool.herokuapp.com/
