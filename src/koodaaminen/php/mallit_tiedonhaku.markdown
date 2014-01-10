% Tietokantahaku ja kyselyn parametrit
<!-- order: 4 -->

<summary>
* Lisätään aiemmin tehtyyn malliluokkaan haeKayttajaTunnuksilla-metodi.
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille. Tähän käytetään PDO:n *prepared statements* -tukia.
</summary>

Jotta sovellukseen voi kirjautua muillakin kuin yhdellä tunnuksella,
pitää kirjautumisen taustalle tehdä oikea tietokantaa käyttävä
malli, jolta voidaan kysyä ovatko käyttäjän antamat tunnukset oikeita.

## Turvallinen tietokantaohjelmointi

Olennainen osa järkevää tietokantaohjelmointia
on nk. [SQL-injektioiden](http://fi.wikipedia.org/wiki/SQL-injektio) välttäminen.

Sovellukseen on mahdollista tehdä SQL-injektio silloin, kun käyttäjän
antamia syötteitä ei tarkisteta kunnolla vaan ne upotetaan SQL-kyselyihin sellaisinaan.

**Esimerkki:**

~~~inlinephp
$nimi = $_POST['nimi'];

$yhteys = Tietokanta::getYhteys();
$kysely = $yhteys->prepare("SELECT * FROM users WHERE nimi = '$nimi' LIMIT 1");
~~~

Nyt, mikäli nimeksi annetaankin vaikka merkkijono `' OR username = 'admin'`,
hakeekin kysely kannasta aivan eri käyttäjän kuin pitäisi!

Jos tälläinen virhe eksyy vaikkapa kirjautumislogiikkaan, on sovellus auttamatta haavoittuvainen murtautumisyrityksille.

Onneksi sekä PHP:llä että Javalla on olemassa hyvin helppokäyttöinen tapa
estää tälläisiä kyselyjä menemästä kantaan:
[Prepared statementit](http://en.wikipedia.org/wiki/Prepared_statement)
eli kankeasti suomennettuna esivalmistellut SQL-lauseet 
ovat ratkaisu ongelmaan.

Käytännössä kyseessä on tietokannalle etukäteen lähetetty 
SQL-kielinen kysely, johon on upotettu paikkoja parametreille.
Näiden parametrien paikalle voi sitten upottaa haluamiaan arvoja.

Näitä parametrien paikkoja ilmaistaan kysymysmerkeillä.
PHP:llä parametrit annetaan array-tyyppisenä listana [kyselyä suoritettaessa](http://php.net/manual/en/pdostatement.execute.php)

**Esimerkki** 

~~~inlinephp
$nimi = $_POST['nimi'];
$yhteys = Tietokanta::getYhteys();

//Etsitään käyttäjää nimellä
$sql = "SELECT * FROM users WHERE nimi = ?";
$kysely = $yhteys->prepare($sql);

//Annetaan yksi parametri array:n sisällä
$tulokset = $kysely->execute(array($nimi));
~~~

## Yksittäisen käyttäjän hakeminen kannasta

Tehdään aiemmin tehtyyn käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen tarkistamisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se voi palauttaa esimerkiksi käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa voidaan käyttää myös myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

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
