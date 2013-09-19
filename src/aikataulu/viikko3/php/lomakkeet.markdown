% Lomakkeiden käyttö ja vastaanottaminen
<!-- order: 2 -->

Seuraavaksi tee sivu, joka näyttää
html-demoon tekemäsi kirjautumislomakkeen
näkymänään. 
Voit laittaa sivun esim. osoitteeseen `/kirjautuminen.php`
tai `/login.php`. 

Laitetaan seuraavaksi tämä sivu ottamaan kirjautuminen myös vastaan.

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

  if (empty($_POST["username"])) {
  }
  if (empty($_POST["password"])) {
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
    asetaVirhe("Kirjautuminen ei onnistunut. Käyttäjää ei löytynyt", request);
    naytaJSP("login.php", request, response);
  }
~~~

Koodissa kannattaa huomata kutsu `header('Location: kissalista.php');`.
[header-funktio](http://php.net/manual/en/function.header.php)
lähettää käyttäjän selaimelle HTTP-otsakkeen.
Otsakkeita voi käyttää monenlaisiin tarkoituksiin, mutta yleisimmin käytetään otsaketta "Location", 
joka lähettää käyttäjän selaimen kaksoispisteen jälkeen kirjoitettuun osoitteesen.
Tämä on kätevä tapa ohjata käyttäjä jonkin toisen sivun luo.
Voit halutessasi tehdä siitäkin oman apufunktion aiemmin tekemääsi yleiskäyttöiseen kirjastotiedostoon.

<alert>

PHP:llä kannattaa varoa lisäämästä tiedostojensa alkuun välilyöntejä 
ja rivinvaihtoja ennen <?php-tägiä. PHP tulkitsee nämä merkit
sivun sisällöksi, joka pitää lähettää selaimelle. 
Tämä estää kaikkien HTTP-otsakkeiden lähettämisen, 
sillä ne on lähetettävä ennen sivun sisältöä.
 
</alert>

Toteuta ylläolevan kaltainen tarkastus omaan kirjautumissivuusi.
Voit tehdä tarkistuksen joko niin, että se toimii samassa tiedostossa kuin kirjautumislomake tai tehdä
lomakkeen vastaanottolle oman tiedoston. 
Tee myös aiemmin tekemääsi käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen tarkistamisen toteuttamiseen. 

Itse metodin ei vielä tässä vaiheessa tarvitse olla allaolevaa logiikkaa monimutkaisempi:

**Ote tiedostosta libs/models/kayttaja.php:**

~~~java
public static function getKayttaja($kayttaja, $salasana) {
  $oikeaSalasana = "kala";
  $oikeaKayttaja = "admin";

  if (oikeaKayttaja == kayttaja && oikeaSalasana == salasana) {
    return new Kayttaja();
  }

  return null;
}
~~~

Varmista, että kirjautumislomake näyttää käyttäjälle järkevän virheviestin
mikäli kirjautuminen ei onnistu.

<next>

Seuraavaksi käytämme istuntoja [kirjautumisen tallentamiseen sivulatausten välillä](istunnot.html).

</next>
