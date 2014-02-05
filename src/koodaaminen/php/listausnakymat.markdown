% Listaus- ja tietonäkymät
<!-- order: 8 -->

<wip />

Viikon neljä aluksi otetaan kolmosviikon listaustesti, ja laajennetaan se täysipainoiseksi
sivuksi muiden joukossa. Tehtävää on ainakin:

* Sivupohjan ja näkymän käyttöönotto
* Listattavat asiat kannattaa aina järjestää 
  [`ORDER BY`-käskyllä](http://www.postgresql.org/docs/9.2/static/queries-order.html)
* Jos listattavia kohteita on paljon, voi olla järkevää toteuttaa joko [haku tai sivutustoiminto](sivutusjahaut.html)
* Sivulla tulee näyttää viesti, jos lista on täysin tyhjä.

## Array

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

## Listojen läpikäynti

Kontrollerissa luotuja taulukoita voi käyttää 
näkymässä tiedon näyttämiseen. 
Oletetaan että kontrolleri on asettanut muuttujaan `$kissat` listan nimiä
ja lähettää sen näkymälle:

~~~php
<?php
  $kissat' => array("Matleena", "Iiris", "Inari");
  naytaNakyma('kissalista.php', array(
    'kissat' => $kissat
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

## Muut tietosivut

* Listauksesta halutaan päästä usein katselemaan tarkemmin jonkin asian tietoja.
* Nämä toteutetaan omana kontrolleri/näkymä-parinaan
    * Kontrolleri osaa hakea GET-parametrina annetun pääavaimen perusteella oikean olion malliluokalta.
    * Olio välitetään suoraan näkymälle, tai kerrotaan ettei kohdetta löytynyt.
* Listauksessa kannattaa olla asioiden nimen tms. kohdalla linkki näille sivuille tai suoraan muokkauslomakkeeseen. Muokkauslomakkeet toteutetaan hyvin samantapaisesti, niistä on enemmän [omalla sivullaan](muokkausnakymat.html)

Esimerkkisivu; 
Sivulle linkitetään muodossa `kissa.php?id=3`.

~~~php
<?php
  $id = $_GET['id'];
  $kissa = Kissa::etsi($id);

  if ($kissa != null) {
    naytaNakymä("kissa", array(
      'kissa' => $kissa,
    ));
  } else {
    naytaNakymä("kissa", array(
      'kissa' => null
      'virheet' => array('Kissaa ei löytynyt!')
    ));
  }
~~~

Malliluokkaan voi tätä varten rakentaa kirjautumismetodin tapaisen `etsi`-metodin, joka hakee pääavaimen perusteella olion kannasta,
tai palauttaa arvon `null`, jos tietoa ei löytynyt.

<next>
Jos näytettäviä asioita on paljon, lisää listallesi 
[sivutus tai hakutoiminto](sivutusjahaut.html).

Tämän jälkeen voit toteuttaa 
[lisäystoiminnon](mallit_lisays.html).
</next>
