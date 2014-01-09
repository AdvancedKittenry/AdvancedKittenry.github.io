% Tietokannan käytön alkeet
<!-- order: 4 -->

Tehdään nyt aiemmin tehtyyn käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen tarkistamisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se voi palauttaa esimerkiksi käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa käytetään myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

**Esimerkkikoodina ote tiedostosta libs/models/kayttaja.php:**

~~~inlinephp
class Kayttaja {
  
  private $id;
  private $username;
  private $password;
  
  /* Etsitään kannasta käyttäjätunnuksella ja salasanalla käyttäjäriviä */
  public static function getKayttajaTunnuksilla($kayttaja, $salasana) {
    $sql = "SELECT id,username, password from users where username = ? AND password = ? LIMIT 1";
    $kysely = getTietokanta()->prepare($sql);
    $kysely->execute(array($kayttaja, $salasana));

    $tulos = $kysely->fetchObject();
    if ($tulos == null) {
      return null;
    } else {
      $kayttaja = new Kayttaja(); 
      $kayttaja->id = $tulos->id;
      $kayttaja->username = $tulos->username;
      $kayttaja->password = $tulos->password;

      return $kayttaja;
    }
  }

  /* Tähän muita Käyttäjäluokan metodeita */
}
~~~

Tee omaan malliluokkaasi vastaava metodi ja laita kirjautumislomakkeesi käyttämään sitä. Testaa toimiiko kaikki oikein.

<next>

Seuraavaksi käytämme istuntoja [kirjautumisen tallentamiseen sivulatausten välillä](istunnot.html).

</next>
