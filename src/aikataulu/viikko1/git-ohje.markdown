% Versionhallinta
<!-- order: 6 -->

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
Javalla helpoin tapa on [kopioida projektin war-tiedosto Tomcatin webapps-hakemistoon]({{rootdir}}ohjeistus/users/java-war-paketit.html).

Mikäli kopioit töitä käsin, helpointa on pystyttää git-repositoriosi users:ille ja käyttää sitä tiedostojen synkkaamiseen.
PHP:tä käytettäessä luo repositoriollesi ja työllesi oma alihakemisto `htdocs`:in alle.

Kun olet tehnyt kaikki viikon tehtävät, 
mene osoitteeseen [http://tsoha-labtool.herokuapp.com/](http://tsoha-labtool.herokuapp.com/)
ja rekisteröi itsesi kurssille. 
Labtool on laitoksen harjoitustöitä varten kehitetty pisteidenseurantajärjestelmä, 
johon kaikki tämänkin kurssin palautteet annetaan.

<alert>
Tällä hetkellä labtool ei valitettavasti hyväksy muita versionhallintaosoitteita kuin GitHubiin osoittavat. Tästä ei tosin useimmille pitäisi koitua mitään ongelmaa.
</alert>

<last>
  Labtooliin rekisteröityäsi olet suorittanut [1. viikon tehtävät](index.html).
</last>
