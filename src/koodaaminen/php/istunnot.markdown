% Istunnot ja kirjautumisen tallentaminen
<!-- order: 7 -->
<!-- tags: viikko3-php -->

Edellä toteutetussa kirjautumisessa on se huono puoli,
ettei se tallennu mihinkään, sillä [HTTP-protokolla on tilaton]({{rootdir}}web-sovelluksista.html#tilatiedon-hallinta-ja-samanaikaiset-aineistopyynn%C3%B6t),
eikä aineistopyyntöjen välillä talleteta informaatiota.

Apuun ongelmaan tulee PHP:n istuntotuki. 
Istunnot ovat ikäänkuin pieniä, käyttäjä- ja selainkohtaisia tietokantoja,
joihin voi tallettaa olioita siten, että ne säilyvät sivulataukselta toiselle.

Kirjautumisen tapauksessa haluamme tallentaa tiedon siitä kuka on kirjautunut
sisään. Tieto tallennetaan istuntoon siinä vaiheessa, kun käyttäjä kirjautuu sisään
ja sitä käytetään aina kun halutaan tarkastella onko käyttäjä kirjautunut sivulle.

PHP:ssä istunto otetaan käyttöön kutsumalla siihen erikseen tarkoitettua funktiota
[session_start](http://www.php.net/manual/en/function.session-start.php). 
Metodi hakee PHP:n istuntotiedostosta käyttäjän istunnon tai mikäli sellaista ei vielä ole olemassa, luo sen.
Samalla se alustaa erityisen superglobaalin `$_SESSION`-muuttujan assosiaatiotaulukoksi,
johon voi tämän jälkeen tallentaa tietoa ja tarkastella siellä olevia tietoja siten
että ne automaattisesti tallettuvat istuntotiedostoon ja näkyvät seuraavillakin sivulatauksilla.

Esimerkki kirjautuneen käyttäjän tallentamisesta istuntoon:

~~~php
<?php
  session_start();

  $kayttaja = etsiKayttajaTunnuksilla('kalle', $_POST['salasana']));
  if ($kayttaja != null) {
    //Tallennetaan istuntoon käyttäjäolio
    $_SESSION['kirjautunut'] = $kayttaja;
  }
~~~

Myöhemmin jollain aivan toisella sivulla
voidaan tarkistaa onko joku kirjautunut seuraavasti:

~~~php
<?php
  session_start();
  if (isset($_SESSION['kayttaja']) {
    $kayttaja = $_SESSION['kayttaja'];
    //Koodia, jonka vain kirjautunut käyttäjä saa suorittaa
  }
~~~

Käytä istuntoa kirjautumiskontrollerissasi siten, että talletat
jokaisen onnistuneen kirjautumisen yhteydessä kirjautuneen käyttäjän tiedot istuntoon.
Useimmiten on järkevää tallentaa joko käyttäjätaulun pääavaimen arvo 
(id tai käyttäjätunnus) tai kerralla kokonainen käyttäjäolio
kaikkinen tietoineen. Kummankin tallentaminen istuntoon onnistuu
samalla tavalla sijoittamalla se `$_SESSION`-taulukkoon.

<alert>
Sivuja tehdessä `session_start`-funktion kutsuminen on yllättävän helppoa unohtaa.
Tällöin `$_SESSION`-muuttuja ei toimi erityisenä istuntomuuttujana, vaan on aivan normaali muuttuja ja lisäksi oletuksena tietenkin tyhjä.

Helpoin tapa estää tämä moka on kutsua `session_start`-funktiota samassa tiedostossa, johon
olet määritellyt yleiskäyttöisiä funktioitasi. Mieluiten niin, että tiedoston ensimmäinen rivi php-tägien jälkeen on `session_start();`,
jotta kaikki varmasti toimii.
</alert>

<alert>

Myöskään istunnot eivät toimi kunnolla, mikäli PHP on ehtinyt lähettää
selaimelle jotain sisältöä. Kannattaa siis varoa 
ylimääräisiä välilyöntejä ennen &lt;?php-tägiä tämänkin takia.

</alert>

## Kirjautumisen tarkistaminen

Lisää yleiskäyttöiseen kirjastotiedostoosi funktio, 
joka palauttaa arvon `true`, mikäli käyttäjä on kirjautunut ja istunnossa on tallennettuna käyttäjän kirjautumistiedot.
Funktio voi halutessasi myös ohjata käyttäjän kirjautumissivulle mikäli näin ei ole.
Näin kirjautumista vaativat sivut voivat kätevästi tarkistaa onko käyttäjä oikeasti kirjautunut.

Jos sovelluksessasi on monia erilaisia käyttöoikeustasoja tms., voit tehdä
vastaavan metodin myös käyttöoikeuden tarkistamiseen.

Käytä tekemääsi funktiota estääksesi käyttäjää pääsemästä kirjautumista vaativille sivuille ilman kirjautumista.

## Uloskirjautuminen

Kun olet lisännyt kirjautumistarkistuksen kaikille sivuille jotka sitä vaativat,
uloskirjautumisen toteuttamiseksi riittää poistaa istuntoon tallennetut
tiedot kirjautumisesta. Tämän jälkeen käyttäjä ei enää pääse sivuille sisään.

~~~php
<?php
  //Avataan istunto
  session_start();

  //Poistetaan istunnosta merkintä kirjautuneesta käyttäjästä -> Kirjaudutaan ulos
  unset($_SESSION["kirjautunut"]);

  //Yleensä kannattaa ulkos kirjautumisen jälkeen ohjata käyttäjä kirjautumissivulle
  header('Location: kirjautuminen.php');
?>
~~~

<last>

Kun olet toteuttanut kaikki näissä ohjeissa mainitut asiat, olet saanut valmiiksi viikon 3 palautuksen. Varmista vielä, että kaikki tiedostot löytyvät repositoriostasi.

Jos haluat jatkaa seuraavan viikon asiaa, voit siirtyä lukemaan 
[listauksen ja tietosivujen toteuttamisesta](listausnakymat.html).

</last>
