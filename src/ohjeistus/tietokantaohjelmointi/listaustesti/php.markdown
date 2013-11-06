% Listaus PHP:llä

Varmista ensin, että sinulla on omassa tiedossaan luokka tai funktio, jolla saat [yhteyden tietokantaan](../tietokantayhteys/index.html).
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

~~~php
<?php foreach($lista as $asia): ?>
  <li><?php echo $asia; ?></li>
<?php endforeach; ?>
~~~

Huomaa kaksoispiste for-luupin jälkeen ja puolipiste endforeach-sanan jälkeen.

HTML-koodin seassa nämä tavat ilmaista luuppeja ja muita kontrollirakenteita
tekevät koodin tulkitsemisesta usein helpompaa, sillä lopetussanasta näkee 
heti minkä rakenteen se lopettaa.

Jos haluat tutustua näkymäkoodin kirjoittamiseen tarkemmin, voit tutustua 
[kolmosviikon ohjeisiin]({{rootdir}}aikataulu/viikko3/php/rakenne.html).

## Tietokannan käyttö

Nyt kun meillä on tapa kirjoitaa lista, voimme kirjoittaa koodia,
joka palauttaa meille listan.

Alla on esimerkki käyttäjäluokasta, jolla on metodi, joka palauttaa jokaisen käyttäjän.
Koodissa oletetaan, että funktio `getTietokanta` palauttaa 
sovelluksen tietokantaa vastaavan PDO-olion.

~~~php
class Kayttaja {
  
  private $id;
  private $username;
  private $password;
  
  public static function getKayttajat() {
    $sql = "SELECT id,username, password from users";
    $kysely = getTietokanta()->prepare($sql); $kysely->execute();
      
    $tulokset = array();
    foreach($kysely->fetchAll() as $tulos) {
      $kayttaja = new Kayttaja(); 
      /* Käytetään PHP:n vapaamielistä muuttujamallia olion
         kenttien asettamiseen */
      foreach($tulos as $kentta => $arvo) {
        $kayttaja->$kentta = $arvo;
      }
      $tulokset[] = $kayttaja;
    }
    return $tulokset;
  }
  
  public function getUsername() {
    return $this->username;
  }
  /* Tähän muita Käyttäjäluokan metodeita */
}
~~~

Tälläinen luokka kannattaa sijoittaa omaan tiedostoonsa, josta se haetaan käyttöön 
[include tai require-funktiolla](http://php.net/manual/en/function.include.php).
Include ja require ovat hieman samanlaisia kuin Javan import, mutta ovat
teknisesti lähemänä C-kielen includea. 
Molemmat lähinnä ikäänkuin upottavat kysytyn tiedoston siihen kohtaan
koodia, missä niitä kutsutaan. 

Nyt listaesimerkin alku voi näyttää esimerkiksi seuraavalta:

~~~php
<?php
require_once "utils/tietokanta.php";
require_once "models/kayttaja.php";

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
[mvc]: {{rootdir}}ohjeistus/tietokantaohjelmointi/arkkitehtuuri/index.html

## Linkkejä

* [Esimerkkejä PHP-tilasta kielen omasta dokumentaatiosta](http://www.php.net/manual/en/language.basic-syntax.phpmode.php)
* [Include ja require](http://php.net/manual/en/function.include.php)

<next>
Testisovelluksen tehtyäsi voit tustustua tarkemmin viikon 3 materiaaliin:
[MVC-arkkitehtuuriin](../arkkitehtuuri/index.html)
ja sen jälkeen kirjautumisen toteuttamiseen.
</next>
