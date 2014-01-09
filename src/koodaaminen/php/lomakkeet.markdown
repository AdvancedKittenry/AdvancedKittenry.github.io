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

Hyvin yksinkertainen kirjautuminen voitaisiin sitä käyttäen toteuttaa suurinpiirtein seuraavasti:

~~~php
<?php
  
  if (empty($_POST["username"]) || empty($_POST["password"]) {
     /* Käytetään omassa kirjastotiedostossa määriteltyä näkymännäyttöfunktioita */
    naytaNakymä("login");
    exit(); // Lopetetaan suoritus tähän. Kutsun voi sijoittaa myös naytaNakyma-funktioon, niin sitä ei tarvitse toistaa joka paikassa
  }

  $kayttaja = $_POST["username"];
  $salasana = $_POST["password"];
  
  /* Tarkistetaan onko parametrina saatu oikeat tunnukset */
  if ("svinhufvud" == $kayttaja && "kissakartano" == $salasana) {
    /* Jos tunnus on oikea, ohjataan käyttäjä sopivalla HTTP-otsakkeella kissalistaan. */
    header('Location: kissalista.php');
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä kirjautumislomakkeen. */
    naytaNakyma("login"));
  }
~~~

Koodissa kannattaa huomata kutsu `header('Location: kissalista.php');`.
[header-funktio](http://php.net/manual/en/function.header.php)
lähettää käyttäjän selaimelle HTTP-otsakkeen.
Otsakkeita voi käyttää monenlaisiin tarkoituksiin, mutta yleisimmin käytetään otsaketta "Location", 
joka lähettää käyttäjän selaimen kaksoispisteen jälkeen kirjoitettuun osoitteesen.
Tämä on kätevä tapa ohjata käyttäjä jonkin toisen sivun luo.

Voit tehdä siitäkin oman apufunktion aiemmin tekemääsi yleiskäyttöiseen kirjastotiedostoon.

<alert>

PHP:llä kannattaa varoa lisäämästä tiedostojensa alkuun välilyöntejä 
ja rivinvaihtoja ennen &lt;?php-tägiä. PHP tulkitsee nämä merkit
sivun sisällöksi, joka pitää lähettää selaimelle. 
Tämä estää kaikkien HTTP-otsakkeiden lähettämisen, 
sillä ne on lähetettävä ennen sivun sisältöä.

Käytännössä tämä vaikuttaa siten, että istunnot 
ja käyttäjän lähettäminen eteenpäin `Location`-otsakkeella
eivät toimi kunnolla tai ollenkaan.

</alert>

Toteuta ylläolevan kaltainen tarkastus omaan tiedostoonsa, esim. `doLogin.php` tai `kirjaudu.php`. 
Voit tehdä lomakkeen vastaanottamisen joko niin, että se toimii samassa kontrollerissa lomakkeen näyttämisen kanssa tai tehdä
kirjautumislomakkeen vastaanottolle oman kontrollerin. 

Keskitytään tämän jälkeen tekemään koodista käyttäjäystävällisempi.

## Käytettävyys

Ylläolevassa kirjautumiskäsittelijässä on kaksi olennaista käytettävyysongelmaa.
Ensinnäkin, mikäli käyttäjä syöttää väärän tunnuksen tai salasana tai ei syötä jompaakumpaa ollenkaan, lomake vain palaa kirjautumisruutuun
kertomatta mitä tapahtui. 
Käyttäjälle jää hiipivä epäilys siitä, ottiko sovellus tunnuksia ollenkaan vastana, kun se ei kerro mitään tekemisistään.

Toinen, hieman pienempi, ongelma on, että salasanansa väärin syöttänyt käyttäjä joutuu syöttämään käyttäjätunnuksensa turhaan uudestaan.

Korjataan nämä ongelmat!

Jälkimmäisen ongelman korjaaminen on yksinkertaista, tarvitsee vain lisätä
näkymän näyttämiseen määrite, jossa lähetetään
käyttäjän syöttämä käyttäjätunnus näkymälle ja sitten näyttää se
näkymässä:

<sidebyside>
<column size="5">
**Kontrolleri:**

~~~inlinephp
naytaNakymä("login", array(
  'kayttaja' => $kayttaja,
));
~~~

</column>
<column size="7">

**Näkymä:**

~~~php
Käyttäjänimi:
<input type="text" name="username" 
 value="<?php echo $data->kayttaja; ?>" />
~~~

</column>
</sidebyside>

Ensimmäinen ongelma eli virheviestien näyttäminen on niin yleinen, että
sitä varten kannattaa sijoittaa oma koodinsa sivupohjatiedostoon,
sillä sitä tullaan oikeasti tarvitsemaan *lähes jokaisella sivulla*.
Idea on samanlainen kuin käyttäjäkentän esitäyttämisessä, mutta 
koodi sijaitsee sivupohjassa:

**Kontrolleri:**

~~~inlinephp
/* Tarkistetaan onko parametrina saatu oikeat tunnukset */
if ($kayttaja == 'svinhufvud' && $salasana == 'kissakartano') {
  /* Jos tunnus on oikea, ohjataan käyttäjä sopivalla HTTP-otsakkeella kissalistaan. */
  header('Location: kissalista.php');
} else {
  /* Väärän tunnuksen syöttänyt saa eteensä lomakkeen ja virheen.
   * Tässä käytetään omassa kirjastotiedostossa määriteltyjä yleiskäyttöisiä funktioita.
   */
  naytaNakyma("login", array(
    /* Välitetään näkymälle tieto siitä, kuka yritti kirjautumista */
    'kayttaja' => $kayttaja,
    'virhe' => "Kirjautuminen epäonnistui! Antamasi tunnus tai salasana on väärä.", request;
  ));
}
~~~

**Sivupohja:**

~~~php
<?php if (!empty($data->virhe)): ?>
  <div class="alert alert-danger"><?php echo $data->virhe; ?></div>
<?php endif; ?>
~~~

On hyvä idea tehdä virheviestit myös sille, että joko
käyttäjää tai salasanaa ei ole syötetty ollenkaan.

Lopullinen kontrollerin koodi voi olla vaikkapa tämän näköinen.

~~~php
<?php
  
  //Tarkistetaan että vaaditut kentät on täytetty:
  if (empty($_POST["username"])) {
    naytaNakymä("login", array(
      'virhe' => "Kirjautuminen epäonnistui! Et antanut käyttäjätunnusta.",
    ));
  }
  $kayttaja = $_POST["username"];

  if (empty($_POST["password"])) {
    naytaNakymä("login", array(
      'kayttaja' => $kayttaja,
      'virhe' => "Kirjautuminen epäonnistui! Et antanut salasanaa.",
    ));
  }
  $salasana = $_POST["password"];
  
  /* Tarkistetaan onko parametrina saatu oikeat tunnukset */
  if ($kayttaja == 'svinhufvud' && $salasana == 'kissakartano') {
    /* Jos tunnus on oikea, ohjataan käyttäjä sopivalla HTTP-otsakkeella kissalistaan. */
    header('Location: kissalista.php');
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä lomakkeen ja virheen.
     * Tässä käytetään omassa kirjastotiedostossa määriteltyjä yleiskäyttöisiä funktioita.
     */
    naytaNakyma("login", array(
      /* Välitetään näkymälle tieto siitä, kuka yritti kirjautumista */
      'kayttaja' => $kayttaja,
      'virhe' => "Kirjautuminen epäonnistui! Antamasi tunnus tai salasana on väärä.", request;
    ));
  }
~~~



Myös koodin alussa oleva muuttujien olemassaolon varmistamisesta huolehtiva koodi
on hyvä kandidaatti yleiskäyttöisen funktion sisällöksi,
sillä tuontapainen koodi toistuu lomakkeiden käsittelyssä hyvin usein.

<alert>
Muista aina testata koodiasi erilaisilla syötteillä niin varmistat ettei se kaadu missään tilanteessa.
</alert>

<next>
Toteuta ylläolevan kaltaiset käytettävyysparannukset myös omaan kirjautumisservlettiisi.

Lisää sitten kirjautumisen taustalle [käyttäjän hakeminen tietokannasta](tietokanta_kirjautuminen.html).
</next>
