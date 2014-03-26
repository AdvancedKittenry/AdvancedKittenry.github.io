% Tietokantayhteyden pystytys
<!-- order: 1 -->
<!-- tags: viikko2-php -->

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Jotta tietokantaa pystyy käyttämään, pitää siihen ottaa yhteys
    * Yhteyttä mallinnetaan PHP:n PDO-tietokantakirjaston tarjoamalla oliolla.
    * Luominen pitää sijoittaa omaan funktioonsa tai metodiinsa, jota käyttämällä muu ohjelmakoodi voi hakea tietokantaolion.
    * Metodi sijoitetaan omaan tiedostoonsa, joka sijoitetaan omaan tietokantakirjastoille tarkoitettuun hakemistoonsa.
* Toteuta ensiksi mahdollisimman yksinkertainen testiohjelma, joka hakee tietokannasta tietoa
* Jos käytät tietokantayhteyden autentikointiin salasanaa, [älä laita sitä GitHubiin sellaisenaan](../git-ja-salasanat.html).
</summary>

Sekä Javalla että PHP:llä tietokantayhteyksiä edustaa erillinen luokka,
jonka olio muodostetaan kutsumalla sopivaa metodia/konstruktoria.
Kummallekin annetaan merkkijonona tietokantayhteyttä kuvaava osoite,
jonka perusteella yhteys muodostetaan. 

Alla on esimerkkikoodia tietokantayhteyden muodostamisesta 
tilanteessa, jossa työ pyörii users-palvelimella.
Koodin tarkoituksena on toteuttaa mahdollisimman yksinkertainen
ohjelma, joka ottaa yhteyden tietokantaan ja suorittaa siellä
SQL-muotoisen SELECT-lauseen, jonka tulos näytetään käyttäjälle.

Tee itsellesi ohjeita noudattaen tiedosto, johon sijoitat 
tietokannan muodostamisen. 
Laita tämä tiedosto omaan kansioonsa.
Hyviä nimiä hakemistolle voivat olla esim. "tietokanta" tai "models".
Sovelluksesta tulee huomattavasti selkeämpi, jos kaikki tietokantaa käsittelevä
koodi on sijoitettu yhteen paikkaan.

## Tietokantayhteys ja PHP Data Objects (PHP)

PHP:ssä käytössä oleva tietokantakirjasto
on nimeltään PHP Data Objects eli PDO.
Otamme tämän kirjaston nyt testiluontoisesti käyttöön.

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
~~~

Jos käytät PostgreSQL:ää users-palvelimella,
voit käyttää myös lyhyempää yhteysosoitetta, johon ei laiteta salasanaa:

~~~inlinephp
$yhteys = new PDO("pgsql:");
~~~

Seuravaa komento pyytää PDO:ta tuottamaan poikkeuksen aina kun jossain on virhe.
Sitä kannattaa käyttää aina, oletuksena PDO ei nimittäin raportoi virhetiloja juuri mitenkään!

~~~inlinephp
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

<alert>
Jos käytät koodista ensimäistä versiota, joka tarvitsee salasanan, älä 
laita sitä repositorioosi suoraan.
Käytä sen sijaan [dist-tiedostoja](../git-ja-salasanat.html).

Salasanojen laittaminen julkiseen git-repositorioon on yleisesti ottaen tietoturvan
kannalta paha tapa, joten sitä kannattaa välttää aina kun mahdollista.
</alert>

### PHP:n omituinen oliosyntaksi

PHP:n oliosyntaksi on valitettavasti sekavampi kuin Javan käyttämä.
Metodien kutsumiseen käytetään syntaksia 
`$olio->metodi();`,
olion atribuutteja käytetään samaan tapaan `$olio->attribuutti`.

Sensijaan jos metodi, attribuutti, tai *vakio* on 
staattinen käytetään kahta kaksoispistettä ja atribuutin tapauksessa
vielä dollaria:

|:------|:-----|
|Staattinen metodi|`LuokanNimi::staattinenMetodi()`|
|Staattinen attribuutti|`LuokanNimi::$attribuutti`|
|Staattinen vakio|`LuokanNimi::VAKION_NIMI`|
</huomio>

## Yhteyden testaaminen

Kun yhteys on muodostettu, sitä voi käyttää SQL-kyselyjen suorittamiseen.
Tehdään tätä varten lyhyt testiohjelma.

Tietokannan nopeaan testaamisen voi käyttää seuraavanlaista koodia,
jonka voi sijoittaa suoraan yllä esitetyn yhteyden muodotamisen perään:

**yhteystesti.php**

~~~inlinephp
//Alustetaan muuttuja jossa on Select-kysely, joka palauttaa lukuarvon:
$sqlkysely = "SELECT 1+1 as two";

//Pyydetään PDO-yhteysoliota käsittelemään SQL-muotoinen kysely.
//Huom! PHP:ssä käytetään syntaksia $olio->metodi(); metodien kutsumiseen.
$kysely = $yhteys->prepare($sqlkysely);


if ($kysely->execute()) {
  //Tulos-muuttujan arvoksi pitäisi tulla numero kaksi.
  $tulos = $kysely->fetchColumn();

  //var_dump tulostaa muuttujan tyypin ja arvon käyttäjälle:
  var_dump($tulos);
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

/** Funktio joka palauttaa yhteyden tietokantaan PDO-oliona. */
function getTietokantayhteys() {
  //Muuttuja, jonka sisältö säilyy getTietokantayhteys-kutsujen välillä.
  static $yhteys = null; 
  
  //Jos $yhteys on null, pitää se muodostaa.
  if ($yhteys == null) { 
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
