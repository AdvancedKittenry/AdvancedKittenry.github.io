% Lomakkeiden käyttö ja vastaanottaminen
<!-- order: 3 -->

Käsittelemme seuraavaksi lomakkeita ja kirjautumisen toteuttamista.

Aloita tekemällä kontrolleri, joka näyttää
html-demoon tekemäsi kirjautumislomakkeen
näkymänään. 
Voit laittaa sivun esim. osoitteeseen `/kirjautuminen.php`
tai `/login.php`. 

Laitetaan seuraavaksi tämä sivu ottamaan kirjautumislomake vastaan.

## Lomakkeiden vastaanottaminen

Oletetaan, että kirjautumisnäkymässä on suurinpiirtein allaolevan tapainen lomake.

~~~html
<form action="login" method="POST">
Käyttäjänimi: <input type="text" name="username" />
Salasana: <input type="password" name="password" />
<button type="submit">Kirjaudu</button>
</form>
~~~

HTML-kertauksena: `form`-elementin `action`-attribuutti määrittää 
mihin osoitteeseen lomakkeen tiedot lähetetään, 
`method` sensijaan kertoo lähetetäänkö tiedot GET- vai POST-parametreina.
Jokaisen `input`-elementin sisältö lähetetään parametrina, 
joka tunnistetaan `name`-attribuutissa annetulla nimellä.

Lähetetyn lomakkeen parametreja voidaan käsitellä hakemalla ne 
PHP:n [superglobaaleista muuttujista](http://php.net/manual/en/language.variables.superglobals.php)
`$_GET` ja `$_POST`. Ne ovat PHP:n automaattisesti määrittämiä muuttujia, jotka
ovat näkyvissä kaikissa funktioissa ja metodeissa automaattisesti.
Niiden sisältönä on array, johon on laitettu sivun lomakkeelta vastaanottamat
GET- ja POST-parametrit.

Hyvin yksinkertainen kirjautuminen voitaisiin näitä muuttujia käyttäen toteuttaa suurinpiirtein seuraavasti:

~~~php
<?php
  
  //Tarkistetaan että vaaditut kentät on täytetty:
  if (empty($_POST["username"])) {
    naytaNakymä("login", array(
      'virhe' => "Kirjautuminen epäonnistui! Antamasi käyttäjänimi on tyhjä.",
    ));
  }
  if (empty($_POST["password"])) {
    naytaNakymä("login", array(
      'virhe' => "Kirjautuminen epäonnistui! Antamasi salasana on tyhjä.",
    ));
  }
  
  $salasana = $_POST["password"];
  $kayttaja = $_POST["username"];
  
  /* Tarkistetaan mallilta onko parametrina saatu oikeat tunnukset */
  if (Kayttaja::getKayttaja($kayttaja, $salasana) != null) {
    /* Jos tunnus on oikea, ohjataan käyttäjä sopivalla HTTP-otsakkeella kissalistaan. */
    header('Location: kissalista.php');
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä lomakkeen ja virheen.
     * Tässä käytetään omalta yläluokalta perittyjä yleiskäyttöisiä metodeja.
     */
    naytaNakyma("login", array(
      'virhe' => "Kirjautuminen ei onnistunut. Käyttäjää ei löytynyt", request;
    ));
  }
~~~

Koodissa kannattaa huomata kutsu `header('Location: kissalista.php');`.
[header-funktio](http://php.net/manual/en/function.header.php)
lähettää käyttäjän selaimelle HTTP-otsakkeen.
Otsakkeita voi käyttää monenlaisiin tarkoituksiin, mutta yleisimmin käytetään otsaketta "Location", 
joka lähettää käyttäjän selaimen kaksoispisteen jälkeen kirjoitettuun osoitteesen.
Tämä on kätevä tapa ohjata käyttäjä jonkin toisen sivun luo.

Voit tehdä siitäkin oman apufunktion aiemmin tekemääsi yleiskäyttöiseen kirjastotiedostoon.
Myös koodin alussa oleva muuttujien olemassaolon varmistamisesta huolehtiva koodi
on hyvä kandidaatti yleiskäyttöisen funktion sisällöksi.

<alert>

PHP:llä kannattaa varoa lisäämästä tiedostojensa alkuun välilyöntejä 
ja rivinvaihtoja ennen &lt;?php-tägiä. PHP tulkitsee nämä merkit
sivun sisällöksi, joka pitää lähettää selaimelle. 
Tämä estää kaikkien HTTP-otsakkeiden lähettämisen, 
sillä ne on lähetettävä ennen sivun sisältöä.
 
</alert>

Toteuta ylläolevan kaltainen tarkastus omaan tiedostoonsa, esim. `doLogin.php` tai `kirjaudu.php`.
Tee myös aiemmin tekemääsi käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen tarkistamisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se voi palauttaa esimerkiksi käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa käytetään myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

**Esimerkkikoodina ote tiedostosta libs/models/kayttaja.php:**

~~~php
class Kayttaja {
  
  private $id;
  private $username;
  private $password;
  
  public static function getKayttaja($kayttaja, $salasana) {
    $sql = "SELECT id,username, password from users where username = ? AND password = ?";
    $kysely = getTietokanta()->prepare($sql);
    $kysely->execute(array($kayttaja, $salasana));

    $tulos = $kysely->fetchObject();
    if ($tulos == null) {
      return null;
    } else {
      $kayttaja = new Kayttaja(); 
      /* Käytetään PHP:n vapaamielistä muuttujamallia olion
         kenttien asettamiseen */
      foreach($tulos as $kentta => $arvo) {
        $kayttaja->$kentta = $arvo;
      }
      return $kayttaja;
    }
  }

  /* Tähän muita Käyttäjäluokan metodeita */
}
~~~

Varmista, että kirjautumislomake näyttää käyttäjälle järkevän virheviestin
mikäli kirjautuminen ei onnistu.

<next>

Seuraavaksi käytämme istuntoja [kirjautumisen tallentamiseen sivulatausten välillä](istunnot.html).

</next>
