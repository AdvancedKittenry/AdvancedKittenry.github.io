% Listaus PHP:llä

<wip />
Varmista ensin, että sinulla on luokka tai funktio, jolla saat [yhteyden tietokantaan](../tietokantayhteys/index.html).
Nyt käytämme tietokantayhteyttä luokaksemme hyvin yksinkertaisen sivun, jolla listataan jonkun taulun sisältöä.
Teemme tämän kahdessa vaiheessa: 
Ensin luomme yksinkertaisen sivun, joka näyttää listan asioista
sitten luomme koodin, joka hakee tuon listan tietokannasta.

## Asioiden listaaminen


Tarkempien ohjeiden puuttuessa näkymien toteutuksen esimerkkikoodia voi noukkia
[viikon 3 materiaaleista]({{rootdir}}aikataulu/viikko3/php/rakenne.html).


<comment>
~~~php


~~~

</comment>

## Tietokannan käyttö

Esimerkki metodista joka hakee kaikki käyttäjät kannasta ja käyttäjäluokasta.
Luokka kannattaa sijoittaa omaan tiedostoonsa, josta se haetaan käyttöön 
[require-funktiolla](http://php.net/manual/en/function.include.php).

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

  /* Tähän muita Käyttäjäluokan metodeita */
}
~~~

<vinkki title="Hyvä tietää">
Tällä viikolla tehtävä listaus on tahallaan melko yksinkertainen, sillä tarkoitus on vain testata tietokantaohjelmointia.
Lopulliset sivut tulevat noudattamaan läheisemmin [MVC-arkkitehtuuria][mvc].
</vinkki>
[mvc]: {{rootdir}}ohjeistus/arkkitehtuuri/index.html
