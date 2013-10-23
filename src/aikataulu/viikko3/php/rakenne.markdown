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

Projektissa pitäisi tällöin olla seuraavanlainen kansiorakenne:

~~~~<include src="kansiorakenne.txt" />~~~~

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

Tästä johtuen yksinkertaisin tapa toteuttaa yksittäisen toiminnon kontrolleri PHP:llä
ei oikeastaan vaadi muuta kuin sopivaan osoitteeseen sijoitetun PHP-tiedoston,
joka kutsuu tarvitsemiaan kirjastoja tuottaakseen 
käyttäjälle halutun vastauksen aineistopyyntöön.

## Spagettikoodi ja kontrolleri

Tiiviimmillään ja rumimmillaan tämä näkyy vieläkin ikävän yleisenä _spagettikoodina_,
jossa sovelluksen kaikki kolme osaa: kontrolleri, näkymä ja malli
ovat sulassa sovussa ja sekasotkussa samassa tiedostossa. 
Lopputulos on vähänkään monimutkaisemmissa sovelluksissa sekava ja vaikea muuttaa.

**spagettikoodi.php**

~~~~php<include src="esimerkit/spagettikoodi.php" />~~~~

Tällä kurssilla pyrimme hieman selkeämpään [arkkitehtuuriin]({{rootdir}}mvc-opas.html),
jossa mallit ja näkymät määritellään omissa tiedostoissaan.

Tämä ei kuitenkaan varsinaisesti estä käyttämästä PHP:n suoraviivaista luonnetta
siihen, että jätämme varsinaiset kontrollerit paljaaksi koodiksi,
joka vain suoraan kutsuu erilaisia kirjastoja ja näyttää lopulta näkymän.
Käytämme tästä lähtien näistä kontrolleritiedostoja myös yksinkertaisempaa nimitystä "sivu".

Esimerkkinä kuvitteellisen kissalistan sivu:

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

<info>
Ero `include`:n ja `require`:n välillä on se, että
require ei anna skriptin suorituksen jatkua, mikäli 
haettua tiedostoa ei löydy. 

Funktioista on olemassa 
myös versiot `include_once` ja `require_once`, jotka 
varmistavat ettei samaa tiedostoa sisällytetä kahdesti.
Käytä näitä versioita sisällyttäessäsi yleiskäyttöistä kirjastokoodia (tiedostot `libs`-kansiosta).
</info>

Kokeile includea. Luo projektiisi views-kansio
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

Eräs suhteellisen yksinkertainen tapa on toteuttaa pohja siten
että sijoitetaan pohjatiedostoon kaikki sivujen sisällön 
ympärillä pyörivä HTML-koodi ja laitetaan itse sisällön paikalle koodi:

~~~php
<?php require $sivu; ?>
~~~

Nyt pohjan ja näkymätiedoston yhdessä käyttämiseen riittää, että tallennetaan näkymätiedoston nimi 
näkymää käyttävässä sivussa muuttujaan `$sivu` ja sisällytetään
pohjatiedosto `require`-funktiolla.

~~~php
<?php
  
  $sivu = 'login.php';
  requre 'views/pohja.php';
~~~

Käytännössä ylläoleva koodi on melko virhealtis muuttujanimien vaihdoksille ja kirjoitusvirheille,
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

Tätä varten haluamme pystyä välittämään tietoa kontrollereiden
ja näkymien välillä. Tämä onnistuu helpoiten laittamalla
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
Voimme esimerkiksi asettaa näkymälle lähetettävän virheviestin näin:

~~~~php
<?php 
  naytaNakyma('kissat.php', array(
    'virheViesti' => "Et voi ruokkia kissaa, joka on syönyt alle kolme tuntia sitten!"
  ));
}
~~~~

Jolloin näkymässä voimme kirjoittaa HTML-koodin sekaan:

~~~php
<?php echo $data->virheViesti; ?>
~~~

<info>

Vastaava koodinpätkä array-tietorakenteella on:

~~~php
<?php echo $data['virheViesti']; ?>
~~~

Tämä on ainakin ohjeiden kirjoittajan mielestä ikävä kirjoittaa monta kertaa.
</info>

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
Oletetaan että kontrolleri on asettanut muuttujaan `$kissat` listan nimiä:

~~~php
<?php
  naytaNakyma('kissalista.php', array(
    'kissat' => array("Matleena", "Iiris", "Inari");
  ));
~~~

Nyt jos tämä muuttuja on käytettävissä näkymätiedostossa, voimme näyttää nimet näin:

~~~php
<?php foreach($data->kissat as $kissa): ?>
<div class="kissa">
  Kissan nimi on
  <?php echo $kissa; ?>
</div>
<?php endforeach; ?>
~~~

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

Myöhemmin työn edetessä teemme tähän luokkaan staattisia metodeja, 
jotka osaavat hakea näihin olioihin sisältöä tietokannasta.

Esimerkkinä mallikoodille voit käyttää ensimmäisen viikon ohjelmointikielioppaan Kahvikuppia:

~~~php<include src="../../viikko1/esimerkit/kahvikuppi.php" />~~~

<comment>
<next>
Seuraavaksi otamme käyttäjämallin ja tekemämme näkymäarkkitehtuurin käyttöön
[yksinkertaisen kirjautumisen](lomakkeet.html) toteuttamiseen.
</next>
</comment>
