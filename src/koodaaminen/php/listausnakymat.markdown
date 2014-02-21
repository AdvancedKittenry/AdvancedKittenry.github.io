% Listaus- ja tietonäkymät
<!-- order: 8 -->
<!-- tags: viikko4-php -->

Viikon neljä aluksi otetaan kolmosviikon listaustesti, ja laajennetaan se täysipainoiseksi
sivuksi muiden joukossa. Tehtävää on ainakin:

* Sivupohjan ja näkymän käyttöönotto
* Listattavat asiat kannattaa aina järjestää 
  [`ORDER BY`-käskyllä](http://www.postgresql.org/docs/9.2/static/queries-order.html)
* Jos listattavia kohteita on paljon, voi olla järkevää toteuttaa joko haku tai sivutustoiminto
* Sivulla tulee näyttää viesti, jos lista on täysin tyhjä.

## Array, PHP:n lista- ja assosiaatiotaulutietorakenne

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
Oletetaan että kontrolleri on asettanut muuttujaan 
`$kissat` listan kissaluokan olioita
ja lähettää sen näkymälle:

~~~php
<?php
  /* Kissa-luokka hakee kaikki kissat 
   * tietokannasta etsiKaikkiKissat-metodilla.
   * Nimen saa kissasta ulos getNimi()-metodilla.
   */
  $kissat' => Kissa::etsiKaikkiKissat();
  naytaNakyma('kissalista.php', array(
    'kissat' => $kissat
  ));
~~~

Nyt jos tämä muuttuja on käytettävissä näkymätiedostossa, voimme näyttää nimet näin:

~~~php
<?php foreach($data->kissat as $kissa): ?>
<div class="kissa">
  Kissan nimi on
  <?php echo $kissa->getNimi(); ?>
</div>
<?php endforeach; ?>
~~~

## Muut tietosivut {#tietosivut}

Listauksesta halutaan päästä usein katselemaan tarkemmin jonkin asian tietoja, siten että nämä yksityiskohtaisemmat tiedot
ovat omalla sivullaan.

Nämä sivut toteutetaan omana kontrolleri/näkymä-parinaan,
jotka ottavat GET-parametrina vastaan tiedon
siitä mitä asiaa tarkkaanottaen halutaan sivulla näytettävän.
Parametrissa välitetään tietokohteen pääavaimen arvo,
eli yleensä jonkinsorttinen id-numero

Alla esimerkki linkistä tietosivulle. Usein linkit tietosivuille
sijoitetaan listauksessa siihen, missä listatun asian nimi näkyy:

~~~php
<a href="Kissa?id=<?php echo $kissa->getId() ?>"><?php echo $kissa->getNimi() ?></a>
~~~

Parametri otetaan vastaan `$_GET`-taulukosta.
Koska haluamme id-numeron, kannattaa parametrina saatu merkkijono erikseen tyyppimuuntaa sellaiseksi:


~~~inlinephp
$id = (int)$_GET['id'];
~~~

Kun id-numero on parsittu pyydetään malliluokkaa etsimään 
numeroa vastaava rivi kannasta ja palauttamaan se oliona.

Malliluokkaan täytyy tätä varten rakentaa 
metodi, joka hakee pääavaimen perusteella olion kannasta,
tai palauttaa arvon `null`, jos tietoa ei löytynyt.

~~~inlinephp
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

Kun olio on välitetty näkymälle, voidaan sen tiedot näyttää 
tai vaihtoehtoisesti näyttää pelkkä tyhjä virhesivu, jos
haluttua oliota ei löytynyt.

<next>
Jos listalla näytettäviä kohteita on paljon, lisää listallesi 
[sivutus tai hakutoiminto](sivutusjahaut.html).

Tämän jälkeen voit toteuttaa 
[lisäystoiminnon](mallit_lisays.html).
</next>
