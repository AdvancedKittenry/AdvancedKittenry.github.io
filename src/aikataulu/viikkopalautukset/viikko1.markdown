% Viikko 1
<!-- order: 1 -->

<deadline>{{deadline1}}</deadline>

Viikon tehtävät jakautuvat seuraavasti.
Kunkin otsikon alla olevista asioista saa suluissa ilmoitetut aikataulupisteet. 
Pisteet tulevat nähtäville tietokantasovelluksen labtool-sivustolle.

## Aiheen ja tekniikoiden valinta (puoli pistettä)

Aivan aluksi valitaan tärkeimmät yleisen tason toteutusyksityiskohdat:

* Työaihe
* Ohjelmoitikieli
* Tietokanta

## Perusasioiden dokumentointi (1p)

Työstä dokumentoidaan vaaditun dokumentaation ensimmäiset kolme kappaletta:

* Johdanto
* Yleiskuva järjestelmästä
* Käyttötapaukset

Kaikki dokumentaatio on laitettava yhteen pdf-tiedostoon.

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
[omilta sivuiltaan]({{rootdir}}suunnittelu_ja_tyoymparisto/users/index.html).
Pystytä ohjeiden mukaan käyttämäsi ohjelmointikielen ja tietokannan tuki. 

Varsinkin Javalla koodatessa kannattaa pystyttää projektiansa varten 
[NetBeans-projekti]({{rootdir}}suunnittelu_ja_tyoymparisto/netbeans/java.html).
NetBeans helpottaa tietokantasovellusten koodaamista huomattavasti.
NetBeansillä on oma tukensa myös PHP-projekteille, joka osaa mm.
[automaattisesti pystyttää PHP-projektin usersille]({{rootdir}}suunnittelu_ja_tyoymparisto/netbeans/php.html).

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


[labtool]: http://tsoha-labtool.herokuapp.com/
[labtoolreg]: http://tsoha-labtool.herokuapp.com/register

<ohje>
Aloita sivulta 
[Työaiheen valinta]({{rootdir}}suunnittelu_ja_tyoymparisto/aiheet/index.html).
ja seuraa vihreitä ohjelaatikoita.

Kun ole tehnyt kaiken laita kaikki tekemäsi uudet tiedostot git-repositorioosi,
varmista, että sovelluksella on toimiva ja internettiin näkyvä esittelysivu,
ja [rekisteröidy sitten labtooliin][labtoolreg].

Labtool on laitoksen harjoitustöitä varten kehitetty pisteidenseurantajärjestelmä, 
johon kaikki tämänkin kurssin palautteet annetaan.

<expandable title="**Lista tällä viikolla hyödyllisistä ohjesivuista**">

~~~~ {execute=bash}
./list-tagged-files.sh viikko1
~~~~

</expandable>
</ohje>

## Palautukseen vaaditut tiedostot

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
