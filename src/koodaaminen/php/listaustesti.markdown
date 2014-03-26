% Listaustesti
<!-- order: 2 -->
<!-- tags: viikko2-php -->

<summary>
* PHP-tilan ja tekstitilan välillä pomppiminen ja miten HTML-koodia tulostetaan.
* Tietokannan käsittely keskitetään omiin luokkiinsa eli *malleihin*.
* Käytännössä jokaista tietokohdetta vastaa yksi malliluokka.
    * Puhtaille välitauluille harvemmin tarvitaan omaa luokkaansa, vaan niiden toiminnot hoidetaan itse tietokohteiden kautta.
    * Luokka sisältää tarvittavat taulun käsittelyyn metodit.
</summary>

Varmista ensin, että sinulla on omassa tiedostossaan luokka tai funktio, jolla saat [yhteyden tietokantaan](../php/tietokantayhteys.html).
Nyt käytämme tietokantayhteyttä luokaksemme hyvin yksinkertaisen sivun, jolla listataan jonkun taulun sisältöä.
Teemme tämän kahdessa vaiheessa: 
Ensin luomme yksinkertaisen sivun, joka näyttää listan asioista
sitten luomme koodin, joka hakee tuon listan tietokannasta.

## Asioiden listaaminen ja HTML

Jotta saamme näkyviin listan asioita, meidän pitää käyttää HTML:ää.
Tämä on PHP:llä onneksi hyvin helppoa. 

Kielessä on käytössä kaksi tilaa, joita kontrolloidaan `<?php ?>`-tägien avulla.
Tägien ulkopuolella oleva teksti lähetetään sellaisenaan suoraan selaimelle,
niiden sisällä taas tulkitaan PHP-ohjelmakoodina.

PHP-tilassa on myös mahdollista lähettää selaimelle tekstiä käyttämällä
[echo-konstruktiota](http://www.php.net/echo):

~~~php
<?php echo "Hei maailma!", "Hei ", $nimi; ?>
~~~

PHP- ja HTML-tilojen välillä voi myös hyppiä koska tahansa. 
Esimerkiksi for-luupin sisällä on täysin laillista lopettaa php-tägi
ja siirtyä HTML-tilaan. 

Oikeastaan voidaan ajatella että kaikki php-tägien ulkopuolinen
on oikeastaan vain yhtä suurta echo-lausetta.

Tämä mielessä pitäen yksinkertainen lista voidaan toteuttaa suhteellisen helposti:

**Esimerkki**

~~~php
<?php
//Lista asioista array-tietotyyppiin laitettuna:
$lista = array("Kirahvi", "Trumpetti", "Jeesus", "Parta");
?><!DOCTYPE HTML>
<html>
  <head><title>Otsikko</title></head>
  <body>
    <h1>Listaelementtitesti</h1>
    <ul>
    <?php foreach($lista as $asia) { ?>
      <li><?php echo $asia; ?></li>
    <?php } ?>
    </ul>
  </body>
</html>
~~~

Ohjeisen koodin pitäisi tuottaa selaimelle lista, jossa on asiat-listaan lisätyt
neljä asiaa. Testaa tätä selaimessa nyt.

Tätä nimenomaista HTML-koodin seassa koodausta varten PHP:ssä on 
olemassa myös hieman 
[erilaiset versiot useimmista kielen rakenteista](http://php.net/manual/en/control-structures.alternative-syntax.php):

<sidebyside>
<column>
**Normaali foreach**

~~~php
<?php foreach($lista as $asia) { ?>
  <li><?php echo $asia; ?></li>
<?php } ?>
~~~
</column>
<column>

**HTML:n sekaan sopivampi foreach**

~~~php
<?php foreach($lista as $asia): ?>
  <li><?php echo $asia; ?></li>
<?php endforeach; ?>
~~~

</column>
</sidebyside>

Huomaa kaksoispiste foreach-luupin jälkeen ja puolipiste endforeach-sanan jälkeen.

Oikealla puolella esitetty tapa kirjoittaa luuppeja ja muita
kontrollirakenteita tekevät varsinkin pidempien HTML-koodin pätkien
tulkitsemisesta usein helpompaa, sillä lopetussanasta näkee heti minkä
rakenteen se lopettaa.

Jos haluat tutustua näkymäkoodin kirjoittamiseen tarkemmin, voit tutustua 
[kolmosviikon ohjeisiin](../php/rakenne.html).

## Tietokannan käyttö ja mallit

Nyt kun meillä on tapa laittaa lista näkyville, voimme kirjoittaa koodia,
joka tuottaa meille listan tietokannassa olevista asioista, vaikkapa kissoista.

Aivan kuten tietokantayhteydenkin muodostamisenkin
kirjoitamme tietokantaa käsittelevän koodin omaan tiedostoonsa.
Tapana on jakaa tietokantaa käsittelevä koodi tietokohteittain
siten, että kutakin tietokantataulua käsittelevä koodi on 
omassa luokassaan. Näitä luokkia kutsutaan malleiksi.
(Malleista ja sovelluksen arkkitehtuurista voi lukea lisää 
[kolmosviikon materiaalista]({{rootdir}}koodaaminen/arkkitehtuuri/index.html))

Poikkeuksena tietokantataulujen ja malliluokkien vastaavuuteen
ovat tosin välitaulut, joille ei välttämättä aina tarvitse tehdä omaa malliluokkaansa.

Tässä materiaalissa rakennamme mallit niin, että kunkin malliluokan
oliot vastaavat mallin kuvaaman tietokantataulun rivejä
ja mallissa on staattisia metodeja, joilla on mahdollista
hakea näitä olioita tietokannasta.

### Mallin tekeminen käyttäjille

Tehdän ensi viikon kirjautumisen toteuttamista silmälläpitäen
jo valmiiksi käyttäjille oma malliluokkansa.
Lisätään luokalle attribuuteiksi käyttäjätaulun kentät, sekä konstruktori:

~~~php
<?php
class Kayttaja {
  
  private $id;
  private $tunnus;
  private $salasana;

  public function __construct($id, $tunnus, $salasana) {
    $this->id = $id;
    $this->tunnus = $tunnus;
    $this->salasana = $salasana;
  }

  /* Kirjoita tähän gettereitä ja settereitä */
}
~~~

Tälläinen omaan tiedostoonsa kirjoitettu kirjastoluokka, haetaan käyttöön 
[include tai require-funktiolla](http://php.net/manual/en/function.include.php).

~~~php
<?php
  require 'kirjastot/kayttaja.php';
~~~

Include ja require ovat hieman samanlaisia kuin Javan import, mutta ovat
teknisesti lähemänä C-kielen includea. 
Molemmat lähinnä ikäänkuin upottavat kysytyn tiedoston siihen kohtaan
koodia, missä niitä kutsutaan. 

Kirjastoja hakiessa kannattaa käyttää once-päätteisiä versioita, jotka
eivät koskaan hae samaa tiedostoa kahdesti. 
PHP:ssä saman tiedoston voi hakea kahdesti, mutta jos tiedostossa on luokkamäärittely
kaatuu suoritus siihen, että toisella kerralla jo olemassa olevaa luokkaa yritettään luoda uusiksi.

<vinkki>
Näitä luokkia sisältäviä kirjastoina toimivia php-tiedostoja ei tarvitse päättää `?>`-lopputägiin. 
Lopputägin laittaminen on itseasiassa huono idea, sillä niiden jälkeen saattaa tällöin
eksyä rivinvaihtoja ja välilyöntejä, jotka PHP lähettää empimättä selaimelle. 
Tällä on ikävä tapa sotkea istuntojen ja sivujen välisten ohjausten ym. HTTP-otsakkeita käyttävien toimintojen toimintaa.
</vinkki>

### Tietokantahaku

Tehdään seuraavaksi luokalle staattinen metodi, joka palauttaa 
kaikki tuon tietokohteen taulun rivit tuon luokan olioina.
Käytetään tähän aiemmin tekemäämme tietokantayhteysfunktiota, jolta kysymme `PDO`-tyyppistä yhteysoliota:

~~~inlinephp
$yhteys = getTietokantayhteys();
~~~

Yhteysoliota voi pyytää valmistelemaan SQL-koodia suoritettavaksi kutsumalla sen `prepare`-metodia.
Tuloksena saatavan `PDOStatement`-olion voi taas käskeä sille annetun suorittamaan SQL:n
kutsumalla `execute`-metodia.

~~~inlinephp
$sql = "SELECT id,tunnus, password from users";
$kysely = getTietokantayhteys()->prepare($sql); 
$kysely->execute();
~~~

### Tiedon hakeminen kyselyoliolta

Viimeisen kutsun jälkeen `$kysely`-muuttujalta voi kysellä
kannasta saatuja tietoja takaisin. Tietoja voi pyydellä
rivi kerrallaan käyttämällä `fetch` tai `fetchObject`-metodia.
Molemmat hakevat seuraavan tuloksissa olevan rivin.

~~~inlinephp
//Haetaan kaksi riviä eri tyyppisinä ja tulostetaan niiltä tunnus.
$assosiaatiotaulu = $kysely->fetch();
echo $assosiaatiotaulu['tunnus'];

$nimeton_olio = $kysely->fetchObject();
echo $nimeton_olio->tunnus;
~~~

Tiedot voi myös hakea kaikki rivit kerralla `fetchAll`-metodilla.

~~~inlinephp
$rivit = $kysely->fetchAll();
echo $rivit[0]['tunnus'];
~~~

`fetchAll`-metodille voi antaa parametrin, jolla määritellään palautustyyppi.
Listan olioita saa antamalla metodille paremetrina vakion `PDO::FETCH_OBJ`.

~~~inlinephp
$rivit = $kysely->fetchAll(PDO::FETCH_OBJ);
echo $rivit[0]->tunnus;
~~~

Lopuksi on mahdollista hakea yksittäinen arvo `fetchColumn`-metodilla:

~~~inlinephp
$id = $kysely->fetchColumn(); //Hakee oletuksena ensimmäisen sarakkeen
echo $id;

//Huomaa! Myös fetchColumn hakee aina seuraavalta tietokannan
//palauttamalta tulosriviltä.
//Seuraavalla rivillä haetaan jo aivan eri riviltä tietoja,
//kuin id-numeroa hakenut metodikutsu!
$tunnus = $kysely->fetchColumn(1);
~~~


Näillä metodeilla haetut tiedot voidaan nyt tallentaa olioihin, jotka voidaan tallentaa listaan
ja palauttaa metodin kutsujalle.

Alla on esimerkki valmiista metodista, joka palauttaa jokaisen käyttäjän.

~~~inlinephp
public static function etsiKaikkiKayttajat() {
  $sql = "SELECT id,tunnus, password FROM users";
  $kysely = getTietokantayhteys()->prepare($sql); $kysely->execute();
    
  $tulokset = array();
  foreach($kysely->fetchAll(PDO::FETCH_OBJ) as $tulos) {
    $kayttaja = new Kayttaja();
    $kayttaja->setId($tulos->id);
    $kayttaja->setTunnus($tulos->tunnus);
    $kayttaja->setSalanana($tulos->salasana);

    //$array[] = $muuttuja; lisää muuttujan arrayn perään. 
    //Se vastaa melko suoraan ArrayList:in add-metodia.
    $tulokset[] = $kayttaja;
  }
  return $tulokset;
}
~~~

### Koodin käyttäminen kontrollerissa

Malliluokan koodia käyttäen listaesimerkin alku voi näyttää esimerkiksi seuraavalta:

~~~php
<?php
//require_once sisällyttää annetun tiedoston vain kerran
require_once "libs/tietokanta.php"; 
require_once "libs/models/kayttaja.php";

//Lista asioista array-tietotyyppiin laitettuna:
$lista = Kayttaja::getKayttajat();
?><!DOCTYPE HTML>
...
~~~

Ja koska kyseessä ovat oliot, pitää niitä listatessa tulostaa jokin merkkijono
eikä itse oliota:

~~~php
<?php echo $asia->getUsername(); ?>
~~~


<vinkki title="Hyvä tietää">
Tällä viikolla tehtävä listaus on tahallaan melko yksinkertainen, sillä tarkoitus on vain testata tietokantaohjelmointia.
Lopulliset sivut tulevat noudattamaan läheisemmin [MVC-arkkitehtuuria][mvc].
</vinkki>
[mvc]: {{rootdir}}koodaaminen/arkkitehtuuri/index.html

## Linkkejä

* [Esimerkkejä PHP-tilasta kielen omassa dokumentaatiossa](http://www.php.net/manual/en/language.basic-syntax.phpmode.php)
* [Include ja require](http://php.net/manual/en/function.include.php)

<last>
Kun listaustestisi toimii moitteetta, olet suunnitellut ja toteuttanut käyttöliittymän ja dokumentoinut kaiken,
olet saanut valmiiksi viikon 2 palautuksen. 
Varmista vielä, että kaikki tiedostot löytyvät repositoriostasi.
Muista myös päivittää kaikki tekeäsi uudet asiat [esittelysivulle]({{rootdir}}aikataulu/viikkopalautukset/esittelysivu.html).

Halutessasi voit seuraavaksi tutustua viikon 3 materiaaliin:
[MVC-arkkitehtuuriin][mvc]
ja sen jälkeen [kirjautumisen toteuttamiseen](../php/index.html).
</last>
