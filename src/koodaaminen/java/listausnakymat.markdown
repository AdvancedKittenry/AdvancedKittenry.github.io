% Listaus- ja tietonäkymät
<!-- order: 8 -->

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

~~~jsp
<a href="Kissa?id=${kissa.id}">${kissa.nimi}</a>
~~~

Parametri otetaan vastaan `request`-olion `getParameter`-metodilla.
Koska haluamme id-numeron, pitää parametrina saatu merkkijono erikseen parsia:

~~~java
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
~~~

Kun id-numero on parsittu pyydetään malliluokkaa etsimään 
numeroa vastaava rivi kannasta ja palauttamaan se oliona.

Malliluokkaan täytyy tätä varten rakentaa 
metodi, joka hakee pääavaimen perusteella olion kannasta,
tai palauttaa arvon `null`, jos tietoa ei löytynyt.

~~~java
Kissa kissa = Kissa.etsi(id);

if (kissa != null) {
  request.setAttribute("kissa", kissa);
  naytaJSP("kissa.jsp", request, response);
} else {
  request.setAttribute("kissa", null);
  request.setAttribute("virhe", "Kissaa ei löytynyt!");
  naytaJSP("kissa.jsp", request, response);
}
~~~

Kun olio on välitetty JSP-näkymälle, voidaan sen tiedot näyttää 
tai vaihtoehtoisesti näyttää pelkkä tyhjä virhesivu, jos
haluttua oliota ei löytynyt.

<next>
Jos listalla näytettäviä kohteita on paljon, lisää listallesi 
[sivutus tai hakutoiminto](sivutusjahaut.html).

Tämän jälkeen voit toteuttaa 
[lisäystoiminnon](mallit_lisays.html).
</next>
