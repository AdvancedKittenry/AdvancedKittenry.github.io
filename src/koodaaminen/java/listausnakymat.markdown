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

## Listojen läpikäynti

Aiemmin [näkymien](nakymat.html) oheessa käsitellylle
request-olion `setAttribute`-metodille
voidaan servletin koodissa 
antaa käytännössä mitä tahansa olioita
mukaanlukien erilaisia listoja:

**Ote kissalistan servletistä**

~~~~java
/* Kissa-luokka hakee kaikki kissat 
 * tietokannasta getKaikkiKissat-metodilla.
 * Nimen saa kissasta ulos getNimi()-metodilla.
 */
List<Kissa> katit = Kissa.getKaikkiKissat();
request.setAttribute("kissat", katit);  
~~~~

Nämä listat ovat suoraan käytettävissä JSP-tiedostoissa.
Attribuutiksi määritellyn kissalistan voi näyttää seuraavanlaisella silmukalla:

~~~~jsp
<c:forEach var="kissa" items="${kissat}">
  <div class="kissa">{kissa.nimi}</div>
</c:forEach>
~~~~

Yllä oleva komento `${kissa.nimi}` kutsuu käsiteltävän Kissa-olion
`getNimi`-metodia, ja tulostaa sen palauttaman arvon.

Kannattaa huomata, että
listojenkin läpikäyntiä varten pitää 
ottaa käyttöön JSTL-tägikirjasto laittamalla JSP-sivun alkuun:

~~~~jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
~~~~

## Muut tietosivut

* Listauksesta halutaan päästä usein katselemaan tarkemmin jonkin asian tietoja.
* Nämä toteutetaan omana kontrolleri/näkymä-parinaan
    * Kontrolleri osaa hakea GET-parametrina annetun pääavaimen perusteella oikean olion malliluokalta.
    * Olio välitetään suoraan näkymälle, tai kerrotaan ettei kohdetta löytynyt.
* Listauksessa kannattaa olla asioiden nimen tms. kohdalla linkki näille sivuille tai suoraan muokkauslomakkeeseen. Muokkauslomakkeet toteutetaan hyvin samantapaisesti, niistä on enemmän [omalla sivullaan](muokkausnakymat.html)

Esimerkkisivu; 
Sivulle linkitetään muodossa `Kissa?id=3`.

~~~php
<?php
  String idParam = request.getParameter("id");
  int id;
  try {
    id = Integer.parseInt(idParam);
  } catch(Exception e) {
    // Id-numero nolla ei käytännössä koskaan löydy kannasta, 
    // joten koodin suoritus päätyy
    // alla olevan if-lauseen else-haaraan
    id = 0;
  }

  Kissa kissa = Kissa.etsi(id);

  if (kissa != null) {
    request.setAttribute("kissa", kissa);
    naytaJSP("kissa.jsp", request, response);
  } else {
    request.setAttribute("virhe", "Kissaa ei löytynyt!");
    naytaJSP("kissa.jsp", request, response);
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
