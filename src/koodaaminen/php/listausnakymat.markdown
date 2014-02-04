% Listaus- ja tietonäkymät
<!-- order: 8 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta. Samat suunitteluperiaatteet pätevät kuitenkin kummallakin kielellä.

Viikon neljä aluksi otetaan kolmosviikon listaustesti, ja laajennetaan se täysipainoiseksi
sivuksi muiden joukossa. Tehtävää on ainakin:

* Sivupohjan ja näkymän käyttöönotto
* Jos listattavia kohteita on paljon, voi olla järkevää toteuttaa joko haku tai sivutustoiminto
* Sivulla tulee näyttää viesti, jos lista on täysin tyhjä.

## Sivutus

* Sivutukseen käytetään tietokantatasolla `LIMIT`-käskyä
* se millä sivulla ollaan voidaan ottaa vastaan GET-parametrina
    * Esim. sivulle kolme voidaan linkata näin: `kissalista.php?sivu=3`.
    * Sivutuksen sivunvaihtonapit voivat olla tavallisia linkkejä.
* Malliluokkaan kannattaa koodata myös metodi, joka kertoo listauksessa olevien olioiden kokonaismäärän, niin tiedetään montako sivullista esim. kissoja meillä on listassa.

## Hakulomakkeet

* Useimmiten on parasta sijoittaa hakulomake samalle sivulle listauksen kanssa.
* Myös haku on kätevä toteuttaa GET-parametrina. 
* Jos käytetään sekä hakua, että sivutusta, joudutaan sivutuslinkkehiin sisällyttämään hakusana, ettei sivulta toiselle siirtyminen kadottaisi hakua.

## Muut tietosivut

* Listauksesta halutaan päästä usein katselemaan tarkemmin jonkin asian tietoja.
* Nämä toteutetaan omana kontrolleri/näkymä-parinaan
    * Kontrolleri osaa hakea GET-parametrina annetun pääavaimen perusteella oikean olion malliluokalta.
    * Olio välitetään suoraan näkymälle, tai kerrotaan ettei kohdetta löytynyt.
* Listauksessa kannattaa olla asioiden nimen tms. kohdalla linkki näille sivuille tai suoraan muokkauslomakkeeseen. Muokkauslomakkeet toteutetaan hyvin samantapaisesti, niistä on enemmän [omalla sivullaan](muokkausnakymat.html)

Esimerkkisivu; 
Sivulle linkitetään muodossa `kissa.php?kissa_id=3`.

~~~php
<?php
  $id = $_GET['kissa_id'];
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
Listausnäkymien jälkeen on paras toteuttaa 
[lisäystoiminto](mallit_lisays.html).
</next>
