% Näkymien tekeminen
<!-- order: 4 -->
<!-- addHeaderNavigation -->

<summary>
* Laita sivusi käyttämään HTML:n tulostukseen näkymätiedostoa `views`-kansiossa.
* Tee toinen näkymätiedosto, ja laita sivujesi yhteinen HTML-runko siihen. Tee luokka, jolla voit käyttää runkoa ja näkymää yhdessä.
</summary>

## Näkymätiedostot

PHP:ssä näkyminä käytetään tiedostoja,
jotka koostuvat pääasiassa HTML-koodista, jonka seassa on 
<?php ?>-tägien välissä lyhyitä PHP-koodinpätkiä.
Yksinkertaisimmillaan PHP-näkymätiedosto näyttää tältä:

~~~~php<include src="esimerkit/rakenne/nakyma.php" />~~~~

Helpoin tapa käyttää näkymiä on käyttää
[include- ja require-funktiota](http://php.net/manual/en/function.include.php)
Nämä funktiot sisällyttävät parametrina annetun tiedostonimen php-koodin nykyisen
tiedoston suoritukseen siihen kohtaan, jossa include-suoritetaan.
Tällöin sisällytetyssä tiedostossa näkyvät samat muuttujat, kuin sen sisällyttäneessä tiedostossa.

<info>
Ero `include`:n ja `require`:n välillä on se, että
require ei anna skriptin suorituksen jatkua, mikäli 
haettua tiedostoa ei löydy. 

Funktioista on olemassa 
myös versiot `include_once` ja `require_once`, jotka 
varmistavat ettei samaa tiedostoa sisällytetä kahdesti.
Käytä näitä versioita sisällyttäessäsi yleiskäyttöistä kirjastokoodia (tiedostot `libs`-kansiosta).
</info>

Kokeile includea. Luo projektiisi `views`-kansio
ja kopioi sinne html-demosi kirjautumislomake php-tiedostopäätteellä.

Luo sitten sivu `login.php` tai suomeksi `kirjautuminen.php` projektisi juurikansioon ja 
laita sen sisällöksi seuraavanlainen koodinpätkä:

**testikasittelija.php**

~~~php
<?php 
  require 'views/login.php';
~~~

Kokeile avata tämä sivu selaimella.
Jos teet työtä usersilla URL on todennäköisesti 
[http://tunnuksesi.users.cs.helsinki.fi/login.php](http://tunnuksesi.users.cs.helsinki.fi/login.php).

Selaimeesi pitäisi tulla sama kirjautumislomake kuin aikaisemminkin. 
Tämä on vielä melko tylsää, mutta jatketaan tekemällä näkymien tekemisestä helpompaa.

## HTML-runko ja pohjatiedoston käyttö

Käytännössä suurin osa ohjelmaasi tulevista sivuista
tulee sisältämään samanlaisen HTML-rungon,
johon sisältyvät sivunavigaatio sekä 
head-tägin sisältämät otsakkeet ja tyylitiedostolinkit.

Tämän rungon koodia ei turhaan kannata toistaa, 
vaan se sijoitetaan omaan uudelleenkäytettävään tiedostoonsa.

PHP:llä tälläisille uudelleenkäytettävät HTML-pohjille
ei ole mitään yleisesti käytettyä standarditoteutusta.
Yleensä ne toteutetaan jonkinlaisella näkymäluokalla.

Eräs suhteellisen yksinkertainen tapa on toteuttaa pohja siten
että sijoitetaan pohjatiedostoon kaikki sivujen sisällön 
ympärillä pyörivä HTML-koodi ja laitetaan itse sisällön paikalle require-kutsu:

~~~php
<!DOCTYPE HTML>
<html>
...html-koodia...
  <?php 
    /* HTML-rungon keskellä on sivun sisältö, 
     * joka haetaan sopivasta näkymätiedostosta.
     * Oikean näkymän tiedostonimi on tallennettu muuttujaan $sivu.
     */
    require 'views/'.$sivu; 
  ?>
...html-koodia...
</html>
~~~

Nyt pohjan ja näkymätiedoston yhdessä käyttämiseen riittää, että tallennetaan näkymätiedoston nimi 
näkymää käyttävässä sivussa muuttujaan `$sivu` ja sisällytetään
pohjatiedosto `require`-funktiolla.

~~~php
<?php
  $sivu = 'login.php';

  //Pohjatiedosto huolehtii sekä HTML-rungon, 
  //että oikean näkymän näyttämisestä
  require 'views/pohja.php';
~~~

Kun sivupohja on käytössä, jokainen sivu rakentuu kerroksittain kuten tässä kaaviokuvassa:

![Sivupohjan, näkymän ja näkymän näyttävän koodin väliset suhteet]({{imgdir}}koodaaminen/template-selitys-php.png)

Kuvassa esiintyvä HTML-koodi vastaa melko tarkkaan sitä minkä PHP lähettää selaimelle.
Huomaa, että `<html>`-tägi, navigaatiot yms. toistuvat elementit tarvitsee kirjoittaa vain sivupohjanana toimivaan template.php-tiedostoon.
Jos ne vahingossa kirjoittaa myös näkymätiedostoon, tuloksena on rikkinäistä HTML:ää:

~~~html
<!DOCTYPE HTML>
<html>
<head>
  <title>Otsikko</title>
  </head>
  <body>
    <nav> .... </nav>
     <div id="content">
<!DOCTYPE HTML>
<html>
<head>
  <title>Otsikko</title>
  </head>
  <body>
    <nav> .... </nav>
     <div id="content">
       <h1>Otsikko</h1>
       ...
~~~

Käytännössä yllä esitetty `require`:een perustuva koodi on melko virhealtis muuttujanimien vaihdoksille ja kirjoitusvirheille,
joten se kannattaa sijoittaa funktioksi johonkin yksittäiseen paikkaan.
Tee itsellesi `libs`-kansioon tiedosto tälläisiä yleisiä funktioita varten
ja laita sinne sisällytyksemme funktioversio:

~~~php
<?php
  
  function naytaNakyma($sivu) {
    require 'views/pohja.php';
    exit();
  }
~~~

Kutsumme näkymän näyttämisen jälkeen PHP:n suorituksen lopettavaa  [exit-funktiota](http://www.php.net/manual/en/function.exit.php),
sillä mallin näyttämisen jälkeen emme käytännössä koskaan halua suorittaa sivun koodia loppuun.
Tästä on hyötyä tapauksissa, jossa haluamme kutsua funktiota ennen kuin sivun koodi on suoritettu loppuun.
Esimerkiksi silloin kun tapahtui jokin virhe ja haluamme näyttää virheviestin.

Tätä funktiota käyttäen riittää kirjoittaa tavalliselle sivulle:

~~~php
<?php
  require_once 'libs/common.php';

  naytaNakyma('login.php');
~~~

Seuraavaksi selvitämme miten voimme välittää näkymällemme tietoa.

### Muuttujien käyttö

Useimmat sovelluksemme näkymistä ovat 
hieman elävämpiä kuin yksinkertainen kirjautumislomake,
ja muuttuvat sen mukaan mitä tietokannasta löytyy.

Yhdellä sivulla voi olla esimerkiksi muuttuvina elementteinä
navigaatio, josta on valittu jokin linkki,
esitäytetty lomake ja tieto siitä millä hakusanalla käyttäjä on päätynyt
tälle sivulle.

Koska MVC-mallissa kontrollerien tehtävänä on selvittää mitä tietoja jollakin
sivulla näytetään ja näkymien tehtävänä näyttää se, tarvitaan jokin
tapa välittää  tietoa kontrollereiden
ja näkymien välillä. 

Tämä onnistuu helpoiten laittamalla
`naytaNakyma`-funktioon toinen parametri ja hieman lisää koodia.

~~~php
<?php
  
  /* Näyttää näkymätiedoston ja lähettää sille muuttujat */
  function naytaNakyma($sivu, $data = array()) {
    $data = (object)$data;
    require 'views/pohja.php';
    die();
  }
~~~

Ylimääräinen parametrimme on oletuksena tyhjä array,
ja koodin kutsuja voi sijoittaa sinne minkälaisen
assosiaatiotaulun haluaa. 
Funktion ensimmäinen rivi muuntaa array-tietotyypin
luokattomaksi olioksi, sillä olioiden kenttien käyttösyntaksi on huomattavasti miellyttävämpi.

Käyttäminen on yksinkertaista.
Voimme esimerkiksi asettaa näkymälle lähetettäväksi malliluokan olion, virheviestin ja hakusanan:

~~~~php
<?php 
  naytaNakyma('kissat.php', array(
    'virhe' => "Et voi ruokkia kissaa, joka on syönyt alle kolme tuntia sitten!",
    'kissa' => Kissat::hae($id),
    'hakusana' => $_GET['hakusana']
  ));
}
~~~~

Jolloin näkymässä voimme kirjoittaa HTML-koodin sekaan:

~~~php
<div class="alert alert-danger"><?php echo $data->virhe; ?></div>
~~~

<comment>
<info>

Vastaava koodinpätkä array-tietorakenteella on:

~~~php
<?php echo $data['virheViesti']; ?>
~~~

Tämä on ainakin ohjeiden kirjoittajan mielestä ikävä kirjoittaa monta kertaa.
</info>
</comment>

Näkymissä voi käyttää myös erilaisia koodirakenteita kuten ehtolausekkeita:

~~~~php
<?php if (!empty($data->virheViesti)): ?>
  <div class="alert alert-danger">Virhe! <?php echo $data->virheViesti; ?></div>
<?php endif; ?>
~~~~

Yllä oleva koodi näyttää virheviestin ja siihen liittyvän div-elementin
vain jos muuttuja `virheViesti` on asetettu. 
Huomaa, että PHP:ssä on HTML:än seassa käyttöä varten [kaksi himean erilaista syntaksia if-lauseelle](http://php.net/manual/en/control-structures.alternative-syntax.php).

<info>
Funktiot 
[empty](http://php.net/manual/en/function.empty.php) ja 
[isset](http://www.php.net/manual/en/function.isset.php) ovat 
PHP:ssä parivaljakko, jolla yleisimmin tarkistetaan, onko jollekin
muuttujalle asetettu arvo. 

`Isset` palauttaa `true`:n,
mikäli sille annettu muuttuja on olemassa eikä ole `null`.
Empty taas palauttaa true, mikäli muuttujaa ei ole asetettu,
tai sillä on arvo, jonka PHP rinnastaa `false`:een: 0, 0.0, false, null, tyhjä merkkijono tai 
tyhjä [array](http://php.net/manual/en/language.types.array.php).

Hyödyllisiä funktiot ovat etenkin sen takia, etteivät ne 
tee virhettä määrittelemättömien muuttujien kohdalla. 
Siksi niitä käytetään usein GET- ja POST-parametrien olemassaolon tarkistamiseen:

~~~php
<?php
  if (isset($_POST['salasana'])) {
    //Käyttäjä on syöttänyt lomakkeella ohjelmalle salasanan
  }
~~~
</info>

<next>
Seuraavaksi otamme käyttäjämallin ja tekemämme näkymäarkkitehtuurin käyttöön
[yksinkertaisen kirjautumisen](lomakkeet.html) toteuttamiseen.
</next>
