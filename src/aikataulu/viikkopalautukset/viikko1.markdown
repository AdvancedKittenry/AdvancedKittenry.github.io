% Viikko 1
<!-- order: 1 -->

<deadline>{{deadline1}}</deadline>

<summary>
Aloita [aiheen valinnasta]({{rootdir}}suunnittelu/aiheet/index.html) ja jatka
[ohjelmointikielen]({{rootdir}}suunnittelu/ohjelmointikielet.html)
ja [tietokantapalvelimen]({{rootdir}}suunnittelu/tietokannan-valinta.html)
valintaan.
Pystytä sen jälkeen työsi git-repositorio ja users-palvelimen nettisivutila,
jonne laitat [työn esittelysivun](esittelysivu.html).
Dokumentoi sen jälkeen vielä työsi ja sijoita kaikki tiedostosi versionhallintaan.

Lähetä tämän jälkeen työsi repositorion ja esittelysivun
osoite [labtooliin][labtool].

</summary>

Viikon tehtävät jakautuvat seuraavasti.
Kunkin otsikon alla olevista asioista saa suluissa ilmoitetut aikataulupisteet. Pisteet ovat nähtävillä tietokantasovelluksen [labtoolissa][labtool],
jahka olet ensin [rekisteröinyt itsesi][labtoolreg].

## Aiheen ja tekniikoiden valinta (puoli pistettä)

Valitse aluksi itsellesi 
[työaihe]({{rootdir}}suunnittelu/aiheet/index.html).
Käy sitten läpi oppaat 
[ohjelmointikielen]({{rootdir}}suunnittelu/ohjelmointikielet.html)
ja [tietokantapalvelimen]({{rootdir}}suunnittelu/tietokannan-valinta.html)
valintaan ja valitse itsellesi mieleisesi toteutustekniikka.

Kun aihe ja tekniikat on valittu voidaan lähteä pystyttämään työhön
tarvittavia ohjelmia ja työkaluja.

## Versionhallinnan pystytys  (puoli pistettä)

Tietokantasovellus-kurssilla käytetään versionhallintana git:iä ja
oletuksena repositoriot sijoitetaan github.com-palveluun. Jos et ole 
aikaisemmin käyttänyt git:iä niin verestä muistiasi
ohjelmoinnin harjoitustyön [git-ohjeella](https://github.com/javaLabra/Javalabra2013-1/wiki/Git-ohje).

Ohjeita noudattamalla luo itsellesi tietokantasovellusta varten oma repositorio. Tähän repositorioon laitetaan kurssin aikana 
kaikki työhön liittyvät tiedostot. 

## Ympäristöjen pystytys ja työn esittelysivu (1p)

Repositorion pystyttämisen jälkeen laitetaan työ 
ja kaikki siihen liittyvät tiedostot vielä laitoksen
tietokantasovelluspalvelimelle, users:ille.

Tätä varten usersille pitää pystyttää
oma nettisivutila.
Pystyttäminen ja usersiin ohjeet löytyvät kurssisivulta
[Users-palvelin ja töiden pystyttäminen]({{rootdir}}pystytys/index.html)
 -alakohdan alta.
Pystytä siellä olevien [ohjeiden]({{rootdir}}pystytys/kayttoonotto/index.html) mukaan käyttämäsi ohjelmointikielen ja tietokannan tuki. 

Varsinkin Javalla koodatessa kannattaa pystyttää projektiansa varten 
[NetBeans-projekti]({{rootdir}}pystytys/netbeans/java.html).
NetBeans helpottaa tietokantasovellusten koodaamista huomattavasti.
NetBeansillä on oma tukensa myös PHP-projekteille, joka osaa mm.
[automaattisesti pystyttää PHP-projektin usersille]({{rootdir}}pystytys/netbeans/php.html).

Pystytettyäsi usersin nettisivutilan 
testaa että se toimii siten että saat jotakin näkyviin selaimellasi.
Tämän voi tehdä laittamalla usesille
vaikkapa lyhyen testitiedoston, joka voi vaikkapa lausua käyttäjälle jonkin tervehdyksen.
Tiedoston tarkalla sisällöllä ei ole väliä. Tärkeintä on, että sen saa näkymään selaimella julkisessa internetissä.

Saatuasi jotain näkymään siirry [esittelysivuohjeeseen](esittelysivu.html)
ja tee ohjeiden mukainen työn esittelysivu. 
Tällä viikolla tulee lähinnä linkit työsi repositorioon, 
dokumentaatoon sekä lyhyt aihekuvaus tai linkki valmiiseen aiheeseen.

Pystytä tämäkin sivu usersille.

Laita kaikki tekemäsi tiedostot git-repositorioosi.
Repositoriostasi pitäisi löytyä ainakin: testisivu ja esittelyohjeesi
sekä NetBeans-projektisi, mikäli käytät sitä.

Kannattaa järjestää asiat niin, että usersilla näkyvät sivut 
ovat jotakuinkin identtisiä oman repositorion sisällön kanssa.
PHP:tä NetBeansillä koodaaville tämä on automaattista.
Javalla helpoin tapa on [kopioida projektin war-tiedosto Tomcatin webapps-hakemistoon]({{rootdir}}pystytys/java-war-paketit.html).
Mikäli kopioit töitä PHP:llä käsin, helpointa on pystyttää git-repositoriosi users:ille ja käyttää sitä tiedostojen synkkaamiseen.
Luo tällöin repositoriollesi ja työllesi oma alihakemisto `htdocs`:in alle.

<huomio>
Pystytyksestä saa pisteen vain, mikäli saa työnsä esittelysivun näkymään ohjaajankin koneella ja selaimella.
Tietokantasovelluksia pitää pystyä alusta saakka testaamaan, jotta ohjaaja pystyy antamaan  niistä rakentavaa palauttetta.
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
Tiedostolla on tässä vaiheessa pituutta noin muutama sivu plus mahdolliset kansilehdet ja sisällysluettelot.

Lopuksi tallenna dokumentaatiostasi pdf-versio repositorioosi kansioon `doc` 
nimellä `dokumentaatio.pdf`. 
Voit sijoittaa `doc`-kansioon kaikki
tarvitsemasi dokumentaatioon liittyvät tiedostot kunhan pidät huolen
siitä, että siellä on tietokantasovelluksen [päädokumentti]({{rootdir}}dokumentaatio-ohje.html)
nimellä `dokumentaatio.pdf`. Tuo PDF-tiedosto on se, jonka ohjaajasi lukee, 
mutta on hyvä pitää lähdetiedostotkin versionhallinnassa.

## Ensimmäinen viikon palautuksen tiedostot

Ensimmäisen viikon palautuksen kansiorakenne näyttää todennäköisimmin seuraavanalaiselta:

~~~~
doc/
  dokumentaatio.pdf
  dokumentaatio.odt
esittelysivu.html
hello.html
~~~~

Kansiorakenteesta on löydyttävä `doc`-hakemisto ja 
HTML-sivut jostain loogisesta paikasta.
Esimerkiksi NetBeansillä tehtyjen Java-töiden HTML-tiedostot tulevat omaan `web`-hakemistoonsa.

## Labtool

Kun olet tehnyt kaiken
mene osoitteeseen [http://tsoha-labtool.herokuapp.com/][labtoolreg]
ja rekisteröi itsesi kurssille. 
Labtool on laitoksen harjoitustöitä varten kehitetty pisteidenseurantajärjestelmä, 
johon kaikki tämänkin kurssin palautteet annetaan.

Varmista, että sovelluksella on toimiva ja internettiin näkyvä esittelysivu.

[labtool]: http://tsoha-labtool.herokuapp.com/
[labtoolreg]: http://tsoha-labtool.herokuapp.com/register
