% Tietokantayhteyden pystytys
<!-- order: 1 -->
<!-- tags: viikko2-php -->

Seuraavaksi pyrimme luomaan tiedoston, jossa on tarvittava koodi
tietokantayhteyden luomiseen.
Samoin esitetään lyhyet testiohjelma, jolla yhteyttä voi testata. 

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Jotta tietokantaa pystyy käyttämään, pitää siihen ottaa yhteys
    * Yhteyttä mallinnetaan PHP:n PDO-tietokantakirjaston tarjoamalla oliolla.
    * Luominen pitää sijoittaa omaan funktioonsa tai metodiinsa, jota käyttämällä muu ohjelmakoodi voi hakea tietokantaolion.
    * Metodi sijoitetaan omaan tiedostoonsa, joka sijoitetaan omaan tietokantakirjastoille tarkoitettuun hakemistoonsa.
* Jos käytät tietokantayhteyden autentikointiin salasanaa, [älä laita sitä GitHubiin sellaisenaan](../git-ja-salasanat.html).
</summary>

Sekä Javalla että PHP:llä tietokantayhteyksiä edustaa erillinen luokka,
jonka olio muodostetaan kutsumalla sopivaa metodia/konstruktoria.
Kummallekin annetaan merkkijonona tietokantayhteyttä kuvaava osoite,
jonka perusteella yhteys muodostetaan. 

Alla on esimerkkikoodia tietokantayhteyden muodostamisesta 
tilanteessa, jossa työ pyörii users-palvelimella.

Tee itsellesi ohjeita noudattaen tiedosto, johon sijoitat 
tietokannan muodostamisen. 
Laita tämä tiedosto omaan kansioonsa.
Hyviä nimiä hakemistolle voivat olla esim. "tietokanta" tai "models".
Sovelluksesta tulee huomattavasti selkeämpi, jos kaikki tietokantaa käsittelevä
koodi on sijoitettu yhteen paikkaan.

## Tietokantayhteys ja PDO

Sijoita allaolevat koodit ensiksi omaan
testausta varten tekemääsi tiedostoon, esim. `yhteystesti.php`.

Yhteyden avaaminen onnistuu seuraavalla tavalla.

**yhteystesti.php**

~~~php
<?php
//Tietokannan tunnukset:
$tunnus = "kayttajatunnuksesi";
$salasana= "psql-salasana";

//Yhteysolion luominen
$yhteys = new PDO("pgsql:host=localhost;port=5432;dbname=$tunnus", $tunnus, $salasana);

//Seuravaa komento pyytää PDO:ta tuottamaan poikkeuksen aina kun jossain on virhe.
//Kannattaa käyttää, oletuksena luokka ei raportoi virhetiloja juuri mitenkään!
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

Koodatessa PostgreSQL:llä users-palvelimella voidaan käyttää myös lyhyempää yhteysosoitetta, johon ei laiteta salasanaa:

~~~php
<?php
$yhteys = new PDO("pgsql:");
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

<alert>
Jos käytät koodista sitä versiota, joka tarvitsee salasanan, älä 
laita sitä repositorioosi suoraan.
Käytä sen sijaan [dist-tiedostoja](../git-ja-salasanat.html)
</alert>

## Yhteyden testaaminen

Tietokannan nopeaan testaamisen voi käyttää seuraavanlaista koodia,
jonka voi sijoittaa suoraan yllä esitetyn yhteyden muodotamisen perään:

**yhteystesti.php**

~~~inlinephp
$sql = "select 1+1 as two";
$kysely = $yhteys->prepare($sql);


if ($kysely->execute()) {
  $kakkonen = $kysely->fetchColumn();
  var_dump($kakkonen);
}
~~~

Koodin pitäisi tulostaa seuraava teksti debug-koodaukseen tarkoitettua
[var_dump](http://php.net/manual/en/function.var-dump.php)-funktiota käyttäen:

~~~
int(2)
~~~

Kun olet saanut saanut yhteyden toimimaan ja palauttamaan kannasta tietoa,
tee yhteyden muodostamista varten oma tiedostonsa ja luo sitä
ja muita tietokantaan liittyviä tiedostoja varten oma hakemistonsa,
jonka nimi voi olla vaikkapa `libs` tai `kirjastot`.
Tähän tiedostoon sijoitetaan joko luokkaan tai funktioon 
yllä esitetty yhteyskoodi.

Huomaa, että on tärkeää, että yhteys luodaan vain kerran, sillä sen luominen on verraten hidasta.

Voit tehdä yhteydelle halutessasi luokan, johon voi sijoittaa 
muitakin toistuvia tietokantaan liittyviä koodinpätkiä.
Jos et halua tehdä luokkaa, voit PHP:llä käyttää myös lyhyttä funktiota, jossa on funktion sisäinen
[staattinen muuttuja](http://php.net/manual/en/language.variables.scope.php#language.variables.scope.static):

**libs/tietokantayhteys.php**

~~~inlinephp
<?php
function getTietokantayhteys() {
  static $yhteys = null; //Muuttuja, jonka sisältö säilyy getTietokantayhteys-kutsujen välillä.

  if ($yhteys === null) { 
    //Tämä koodi suoritetaan vain kerran, sillä seuraavilla 
    //funktion suorituskerroilla $yhteys-muuttujassa on sisältöä.
    $yhteys = new PDO('pgsql:');
    $yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
  }

  return $yhteys;
}
~~~

Nyt jossain toisessa tiedostossa funktiota voi käyttää vaikkapa näin:

~~~php
<?php
  require 'libs/tietokantayhteys.php';
  $kysely = getTietokantayhteys()->prepare("SELECT 1");
  $kysely->execute();
  
  echo $kysely->fetchColumn();
~~~

<next>
Kun olet saanut tietokantaan toimivan yhteyden ja laittanut sen omaan tiedostoonsa, 
voit jatkaa tietokantaohjelmointia
tekemällä [yksinkertaisen listauksen](listaustesti.html).
</next>
