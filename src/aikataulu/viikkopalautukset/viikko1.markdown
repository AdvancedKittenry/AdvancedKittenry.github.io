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

## Versionhallinnan pystytys  (puoli pistettä)

Työtä varten luodaan oma git-repositorionsa, jotta ohjaajat 
ja mahdolliset koodikatselmoijat voivat
nähdä ja antaa kommentteja koodistasi.

## Perusasioiden dokumentointi (1p)

Työstä dokumentoidaan vaaditun dokumentaation ensimmäiset kaksi kappaletta:

* Johdanto
* Käyttötapaukset

Kaikki dokumentaatio on laitettava yhteen pdf-tiedostoon.

## Ympäristöjen pystytys ja työn esittelysivu (1p)

Repositorion lisäksi työsi
ja laitetaan ajettavaksi laitoksen
tietokantasovelluspalvelimelle, users:ille.

* Pystytetään käytetyn ohjelmointikielen tuki
* Otetaan käyttöön tietokantapalvelin
* Luodaan työtä varten NetBeans-projekti (vapaaehtoinen)
* Laitetaan työn arvioimisen helpottamiseksi palvelimelle näkyviin työn [esittelysivu](esittelysivu.html)

<comment>
TODO:

Kannattaa järjestää asiat niin, että usersilla näkyvät sivut 
ovat jotakuinkin identtisiä oman repositorion sisällön kanssa.
PHP:tä NetBeansillä koodaaville tämä on automaattista.
Javalla helpoin tapa on [kopioida projektin war-tiedosto Tomcatin webapps-hakemistoon]({{rootdir}}koodaaminen/java/java-war-paketit.html).
Mikäli kopioit töitä PHP:llä käsin, helpointa on pystyttää git-repositoriosi users:ille ja käyttää sitä tiedostojen synkkaamiseen.
Luo tällöin repositoriollesi ja työllesi oma alihakemisto `htdocs`:in alle.

Varsinkin Javalla koodatessa kannattaa pystyttää projektiansa varten 
[NetBeans-projekti]({{rootdir}}suunnittelu_ja_tyoymparisto/netbeans/java.html).
NetBeans helpottaa tietokantasovellusten koodaamista huomattavasti.
NetBeansillä on oma tukensa myös PHP-projekteille, joka osaa mm.
[automaattisesti pystyttää PHP-projektin usersille]({{rootdir}}suunnittelu_ja_tyoymparisto/netbeans/php.html).
</comment>

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
