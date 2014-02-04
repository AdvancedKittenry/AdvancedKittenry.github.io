% Listaus- ja tietonäkymät
<!-- order: 8 -->

<wip />

Viikon neljä aluksi otetaan kolmosviikon listaustesti, ja laajennetaan se täysipainoiseksi
sivuksi muiden joukossa. Tehtävää on ainakin:

* Sivupohjan ja näkymän käyttöönotto
* Jos listattavia kohteita on paljon, voi olla järkevää toteuttaa joko haku tai sivutustoiminto
* Sivulla tulee näyttää viesti, jos lista on täysin tyhjä.

## Listojen läpikäynti

Aiemmin [näkymien](nakymat.html) oheessa käsitellylle
request-olion `setAttribute`-metodille
voidaan antaa käytännössä mitä tahansa olioita
mukaanlukien erilaisia listoja.

**Servletin processRequest-koodia**

~~~~java
/* Kissa-luokka hakee kaikki kissat 
 * tietokannasta getKaikkiKissat-metodilla.
 * Nimen saa kissasta ulos getNimi()-metodilla.
 */
List<Kissa> katit = Kissa.getKaikkiKissat();
request.setAttribute("kissat", katit);  
~~~~

Nämä listat ovat suoraan käytettävissä JSP-tiedostoissa.
Niiden läpikäyntiä varten pitää tosin 
jälleen ottaa käyttöön JSTL-tägikirjasto:

~~~~jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
~~~~

Kun kirjasto on käytössä yllä attribuutiksi määritellyn kissalistan voi näyttää seuraavanlaisella silmukalla:

~~~~jsp
<c:forEach var="kissa" items="${kissat}">
  <div class="kissa">{kissa.nimi}</div>
</c:forEach>
~~~~

Yllä oleva komento `${kissa.nimi}` kutsuu käsiteltävän Kissa-olion
`getNimi`-metodia, ja tulostaa sen palauttaman arvon.

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
