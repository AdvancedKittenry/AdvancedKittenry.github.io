% Mihin eri tiedostot kannattaa laittaa?
<!-- order: 1 -->
<!-- addHeaderNavigation -->

<summary>

* Luo ensin projektillesi koeluontoinen index.php-sivu repositoriosi juureen.
* Laita sitten sivusi käyttämään HTML:n tulostukseen näkymätiedostoa `views`-kansiossa.
* Tee toinen näkymätiedosto, ja laita sivujesi yhteinen HTML-runko siihen. Tee luokka, jolla voit käyttää runkoa ja näkymää yhdessä.
* Tee sovelluksesi yleisesti käytetyille toiminnoille kirjastotiedosto, johon voi sijoittaa yleiskäyttöisiä toimintoja.
    * Sijoita kirjastotiedostot omaan kansioonsa, esim. `libs`.
* Tee käyttäjien käsittelyä varten alustava malliluokka.
    * Sijoita kaikki mallit omaan kansioonsa. Esim. `libs/models`.

</summary>

PHP on historialtaan ja luonteeltaan selkeä [skriptikieli](http://fi.wikipedia.org/wiki/Komentosarjakieli). 
Toisin kuin useimmat käännettävien ohjelmointikielien
ohjelmat, PHP-ohjelmalla ei ole erityistä nimettyä alkukohtaa,
vaan suoritus alkaa tiedoston alusta ja jatkuu siitä tiedoston loppuun,
ellei sitä erikseen keskeytetä.

Lisäksi PHP eroaa hieman useimmista muista web-ohjelmointikielistä
suoraviivaisessa lähestymisessään URL-osoitteiden ja 
suoritettavan ohjelmakoodin väliseen riippuvuuteen.

Perussääntö on hyvin yksinkertainen, jokainen 
tiedosto näkyy oman URL:insa takana sillä palvelimella,
minne tiedostot on sijoitettu. 
On periaatteessa täysin mahdollista tehdä php-sivuja, joissa
jokainen ladattava sivu tuotetaan tasan yhdellä php-tiedostolla.

Tästä johtuen yksinkertaisin tapa toteuttaa yksittäisen toiminnon käsittelijä PHP:llä
ei oikeastaan vaadi muuta kuin sopivaan osoitteeseen sijoitetun PHP-tiedoston,
joka kutsuu tarvitsemiaan kirjastoja tuottaakseen 
käyttäjälle halutun vastauksen aineistopyyntöön.

## Spagettikoodi ja käsittelijä

Tiiviimmillään ja rumimmillaan tämä näkyy vieläkin ikävän yleisenä _spagettikoodina_,
jossa sovelluksen kaikki kolme osaa: käsittelijä, näkymä ja malli
ovat sulassa sovussa ja sekasotkussa samassa tiedostossa. 
Lopputulos on usein sekava ja vaikea muuttaa, varsinkin suuremmissa sovelluksissa.

**spagettikoodi.php**

~~~~php<include src="esimerkit/spagettikoodi.php" />~~~~

Tällä kurssilla pyrimme hieman selkeämpään [arkkitehtuuriin](../arkkitehtuuri.html),
jossa mallit ja näkymät määritellään omissa tiedostoissaan.
Tämä ei kuitenkaan varsinaisesti estä käyttämästä PHP:n suoraviivaista luonnetta
siihen, että käytämme varsinaisissa käsittelijätiedostoissa
melko suoraa tyyliä. Esimerkkinä kuvitteellisen kissalistan käsittelijä:

**kissalista.php**

~~~~php<include src="esimerkit/kasittelija.php" />~~~~

Jotta yllä oleva esimerkki toimisi, on luotava sen tueksi malliluokat,
näkymät ja muutama yleiskäyttöinen luokka ja funktio. Tehdään ensiksi tuki näkymille.

## Näkymätiedostot

PHP:ssä näkyminä käytetään tiedostoja,
jotka koostuvat pääasiassa HTML-koodista, jonka seassa on 
<?php ?>-tägien välissä lyhyitä PHP-koodinpätkiä.
Yksinkertaisimmillaan PHP-näkymätiedosto näyttää tältä:

~~~~php<include src="esimerkit/nakyma.php" />~~~~

Helpoin tapa käyttää näkymiä on käyttää
[include- ja require-funktiota](http://php.net/manual/en/function.include.php)
Nämä funktiot sisällyttävät parametrina annetun tiedostonimen php-koodin nykyisen
tiedoston suoritukseen siihen kohtaan, jossa include-suoritetaan.
Tällöin sisällytetyssä tiedostossa näkyvät samat muuttujat, kuin sen sisällyttäneessä tiedostossa.

Kokeile tätä. Luo projektiisi views-kansio, 
johon jatkossa sijoitat kaikki sovelluksesi näkymät
ja kopioi sinne jokin html-demosi tiedostoista php-tiedostopäätteellä.

Tee sitten lyhyt käsittelijätiedosto projektisi juurikansioon ja 
laita sen sisällöksi 
seuraava koodinpätkä:

**testikasittelija.php**

~~~php
<?php 
  require 'views/nakyma.php';
~~~

Kun tämä käsittelijätiedosto ajetaan, palautuu käyttäjän selaimelle
näkymäkansiossa olevan tiedoston sisältö. Mutta ei siinä vielä kaikki.

### Muuttujien käyttö

Käsittelijöiden ja näkymien välillä on mahdollista välittää muuttujia ja käyttää näkymissä mm. ehtolausekkeita.
esimerkiksi virheviestin näyttämisen voi toteuttaa seuraavasti:

~~~~php
<?php 
  /* Haetaan omia yleiskäyttöisiä funktioita kirjastosta */
  require_once 'libs/common.php';

  if (kissavirhetilanne()) {
    /* Asetetaan virheviesti */
    $virheViesti = "Et voi ruokkia kissaa, joka on syönyt alle kolme tuntia sitten!"
  }

  /* Näytetään näkymä */
  require 'views/nakyma.php';
}
~~~~

näkymätiedostossa on nyt mahdollista näyttää käsittelijässä asetettuja
muuttujia suoraan syntaksilla `<?php echo $attribuutin_nimi; ?>`.
Myös erilaisia koodirakenteita kuten ehtolausekkeita
voi käyttää:

~~~~php
<?php if (!empty($virheViesti)): ?>
  <div class="alert alert-danger">Virhe! <?php echo $virheViesti; ?></div>
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

### Listojen läpikäynti

PHP:ssä listojen ja erilaisten assosiaatiotaulujen virkaa hoitaa yleiskäyttöinen
[array](http://php.net/manual/en/language.types.array.php)-tietotyyppi.
Arraytä käytetään hieman kuin javan taulukoita, mutta avaimena voi käyttää sekä kokonaislukuja, että merkkijonoja.
Yleensä erityyppisiä avaimia ei kuitenkaan kannata sekoittaa. Esimerkkejä:

~~~php
<?php 
  $a = array();
  $a[0] = "arvo";
  $a[1] = "toinen arvo";

  //Taulukkoja voi myös alustaa luodessa. Oletuksena indeksointi alkaa nollasta.
  $m = array(1,2,3,4);
  $m[0] == 1; //tosi

  //Taulukon perään voi lisätä arvoja jättämällä avaimen pois.
  $m[] = 5; //Sama kuin sanoisi: $m[4] = 5;

  //Alustaessa voi myös antaa avaimia.
  $kissa = array("nimi" => "Kasper", "rotu" => "Siamilainen");
  echo $kissa["nimi"]; //Tulostaa nimen Kasper.
~~~

Käsittelijässä luotuja taulukoita voi käyttää 
näkymässä tiedon näyttämiseen. 
Oletetaan että käsittelijä on asettanut muuttujaan `$kissat` listan nimiä:

~~~php
<?php
  $kissat = array("Matleena", "Iiris", "Inari");
~~~

Nyt jos tämä muuttuja on käytettävissä näkymätiedostossa, voimme näyttää nimet näin:

~~~php
<?php foreach($kissat as $kissa): ?>
<div class="kissa">
  Kissan nimi on
  <?php echo $kissa; ?>
</div>
<?php endforeach; ?>
~~~

## Template-pohjatiedoston käyttö

Käytännössä suurin osa ohjelmaasi tulevista sivuista
tulee sisältämään samanlaisen HTML-rungon,
johon sisältyvät sivunavigaatio sekä 
head-tägin sisältämät otsakkeet ja tyylitiedostolinkit.

Tämän rungon koodia ei turhaan kannata toistaa, 
vaan se kannattaa sijoittaa omaan uudelleenkäytettävään tiedostoonsa.

PHP:llä tälläisille uudelleenkäytettävät HTML-pohjille
ei ole mitään yleisesti käytettyä standarditoteutusta.
Yleensä ne toteutetaan jonkinlaisella näkymäluokalla.

Eräs suhteellisen yksinkertainen tapa on toteuttaa pohja näkymäluokan
ja pohjana toimivan tiedoston yhteistyönä,
siten että näkymäluokka sisällyttää pohjan, joka kutsuu
sopivassa kohdassa näkymäluokan metodia, joka sisällyttää
taas varsinaisen sisällön oikeaan kohtaan pohjassa.

Alla on esitetty esimerkkitoteutus, jota saa käyttää työssään.
Se koostuu neljästä tiedostosta, joista kaksi 
`libs/view.php` ja `views/template.php` käyttävät 
kaikki sovelluksen sivut, kun taas kaksi jälkimmäistä
tiedostoa: näkymätiedosto `views/helloworld.php` ja käsittelijä `hello.php` kuuluvat vain yhteen sivuun.

**Näkymäluokka libs/view.php**

~~~~php<include src="esimerkit/view.php" />~~~~

**Yleinen HTML-runkotiedosto views/template.php**

~~~~php<include src="esimerkit/template.php" />~~~~

**Näkymätiedosto views/helloworld.php**

~~~~php<include src="esimerkit/view_using_template.php" />~~~~


**Käsittelijä: hello.php**

Käsittelijässä kaikki aiemmat kolme tiedostoa yhdistetään
niin että lopputuloksena on Hello World! -otsikolla ja rungossa olevalla
HTML-koodilla varustettu kissalista:

~~~php
<?php 
  /* Haetaan omia yleiskäyttöisiä funktioita kirjastosta */
  require_once 'libs/common.php';
  
  //Luodaan näkymäluokasta olio, joka osaa näyttää näkymätiedoston
  $view = new View('helloworld.php');
  //Oliolle on mahdollista asettaa mielivaltaisia attribuuteja, jotka näkyvät näkymätiedostossa $this-muuttujan attribuutteina.
  $view->title = "Hello World!";
  $view->kissat = array("Mirri", "Mauku", "Minni");
  //Viimeinen komento näyttää olion
  $view->display();
~~~

------- 

Eräs toinen ratkaisu on jakaa runkotiedosto kahteen
osaan: sivukohtaista sisältöä edeltävään ja seuraavaan osaan.
Osat voi sijoittaa eri tiedostoihin, mistä ne voi
include-funktiolla sisällyttää. Esimerkki tästä löytyy 
mm. [Sami Saadan ostoslista-esimerkkisovellukesta](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/blob/php-raaka/listat.php).

----------

Ota käyttöön mieleisesi ratkaisu näkymän esittämiseen haluamallasi rungolla.

<comment>

## Usein toistuvan koodin sijoittelu

Siinä vaiheessa kun sivuja alkaa tulla projektiin
useampia alkavat tietyt toiminnot toistua luokasta toiseen.
Hyvänä esimerkkinä ovat irheilmoitusten lähettäminen näkymälle näkyviin, ja kirjautumisen tarkistaminen.

Tee itsellesi uusi luokka, ja lähde rakentamaan siihen yleisiä toiminnallisuuksia omina metodeinaan.

Kehittele tapa näyttää sivupohjassasi sovelluksen virheitä
ja tee metodi joka aktivoi tuon tavan. 

</comment>

## Etusivut

Sivujen etusivu tallennetaan aina nimellä `index.php` (tai `index.html`).
Muun nimisiä etusivuja ei ole mahdollista määrittää.
Bonuksena on, että jos syöttää osoitekenttään pelkän hakemiston osoitteen,
esim. `http://tunnus.users.cs.helsinki.fi` on se sama kuin kirjoittaisi
`http://tunnus.users.cs.helsinki.fi/index.php`, kunhan htdocs-kansiossa on kyseinen tiedosto.

## Mallien luominen

Luodaan vielä projektille yksi malliluokka, joka kuvaa sovelluksesi käyttäjää.
Sijoita projektin mallit omaan kansioonsa kirjastokansiosi alle,
siten että kussakin tiedostossa on yksi malliluokka.

Tee mallitiedostoosi luokka, joka vastaa käyttäjää.
Sijoita luokkaan kentät käyttäjäsi tietokantataulun kenttiä varten
ja luo kentille getterit ja setterit sekä halutessasi konstruktori, joka ottaa kenttien arvot vastaan.

Esimerkkinä mallikoodille voit käyttää ensimmäisen viikon ohjelmointikielioppaan Kahvikuppia:

~~~php<include src="../../viikko1/esimerkit/kahvikuppi.php" />~~~

<comment>
<next>
Seuraavaksi otamme käyttäjämallin ja tekemämme näkymäarkkitehtuurin käyttöön
[yksinkertaisen kirjautumisen](lomakkeet.html) toteuttamiseen.
</next>
</comment>
