% Tietojen syöttäminen kantaan
<!-- order: 9 -->

<summary>
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause), sekä metodit, joilla tarkistetaan ovatko syötettävät arvot oikeanlaisia.
* Lomakkeen kontrolleri ohjaa takaisin esitäytetylle lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään virheilmoituksin.
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`
* Jos lomakkeessa käsitellään viiteavaimia, käytä [SELECT-tägiä](#selecttag)
* Lomake ohjaa lisäyksen onnistuessa selaimen listaussivulle.
  * Onnistumisesta onnistumisviesti
  * Viesti kannattaa välittää [istunnossa](#sessionmessages)
</summary>

## Tietojen syöttäminen malliluokan olioon

Paras tapa toteuttaa jonkin tietokohteen olion, esimerkiksi kissan, syöttäminen tietokantaan, on tehdä siitä oliopohjaista:
Ensiksi luodaan kissaolio, jonka jälkeen asetetaan sille
settereillä sopivat arvot.

**Esimerkki lisäyskontrollerin alusta**

~~~java
Kissa uusikatti = new Kissa();
uusikatti.setNimi(request.getParameter("nimi"));
uusikatti.setVari(request.getParameter("vari"));
uusikatti.setRotuId(request.getParameter("rotu_id"));
~~~

### Olion syöttäminen kantaan

Kun olio on luotu, kutsutaan varta vasten tätä tarkoitusta varten
tehtyä metodia, joka lisää olion kantaan.
Malliin kannattaa rakentaa seuraavankaltainen [INSERT-lausetta][insert] kutsuva koodinpätkä:

~~~java
public void lisaaKantaan() throws NamingException, SQLException {
  String sql = "INSERT INTO Kissat(nimi, vari, rotu_id) VALUES(?,?,?) RETURNING id";
  Connection yhteys = Tietokanta.getYhteys();
  PreparedStatement kysely = yhteys.prepareStatement(sql);

  kysely.setString(1, this.getNimi());
  kysely.setString(2, this.getVari());
  kysely.setInt(3, this.getRotuId());

  ResultSet ids = kysely.executeQuery();
  ids.next();

  //Haetaan RETURNING-määreen palauttama id.
  //HUOM! Tämä toimii ainoastaan PostgreSQL-kannalla!
  this.id = ids.getInt(1);

  try { ids.close(); } catch (Exception e) {}
  try { kysely.close(); } catch (Exception e) {}
  try { yhteys.close(); } catch (Exception e) {}

}
~~~

Huomaa miten
[SERIAL-tyyppistä][serial] pääavainta käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.
Tämän numeroon noutamista varten on olemassa omat kikkansa:

* PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
* MySQL:llä olemassa [oma tekniikkansa](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).

[serial]: http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL
[insert]: http://www.postgresql.org/docs/8.4/static/sql-insert.html

## Virheiden tarkistaminen

Yllä esitetyssä koodissa on yksi puute: virheellisiä syötteitä ei tarkisteta
mitenkään ja pahimmassa tapauksessa kysely saattaa jopa kaatua, jos kantaan
syötetään jotakin, mikä sinne ei kuulu.

Tarvitaan mekanismi, joka tarkistaa ovatko olioon syötetyt
tiedot järkeviä. Tiedoista riippuen
pitää olio joko syöttää kantaan, tai näyttää käyttäjälle
virheilmoituksin varustettu lisäyslomake, jotta käyttäjä
voi korjata virheensä.

Selkeä tapa toteuttaa tämä on lisätä malliluokan
rajapintaan kaksi metodia, jotka voi nimetä vaikkapa
`onkoKelvollinen` ja `getVirheet`.
Näistä
ensimmäinen kertoo, ovatko olioon asetetut tiedot tiedot oikeat ja
jälkimmäinen palauttaa kaikki olion tietoihin liittyvät virheet.

Virheentarkistusmetodeja voi sitten kontrollerissa käyttää näin:

~~~java
//Pyydetään Kissa-oliota tarkastamaan syötetyt tiedot.
if (uusikatti.onkoKelvollinen()) {
  uusikatti.lisaaKantaan();

  //Kissa lisättiin kantaan onnistuneesti, lähetetään käyttäjä eteenpäin
  response.sendRedirect("kissalista");

  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty.
  //Tästä tekniikasta kerrotaan lisää kohta
  HttpSession session = request.getSession();
  session.setAttribute("ilmoitus", "Kissa lisätty onnistuneesti.");

} else {
  Collection<String> virheet = uusikatti.getVirheet();

  request.setAttribute("virheet", virheet);
  request.setAttribute("kissa", uusikatti);
  naytaJSP("kissalomake.jsp", request, response);
}
~~~

Virheentarkistusmetodit voi toteuttaa käytännössä kahdella tavalla riippuen siitä
missä tarkistuksen haluaa tehdä:

1. Laitetaan tarkistukset suoraan settereihin ja pidetään jatkuvasti yllä
   tietorakennetta siitä mitkä tiedot ovat kelvollisia.
2. Laitetaan tarkistukset `onkoKelvollinen`-metodiin ja tarkistetaan
   kaikki kentät kerralla.

Ensimmäinen toteutustapa on usein selkeämpi, sillä yhtä kenttää koskevat
toiminnot pysyvät yhdessä paikassa, mutta jälkimmäisellä tavalla on joskus
mahdollista automatisoida toistuvia tarkistuksia hieman paremmin
laittamalla toisteista koodia luuppeihin.

Alla esimerkki siitä miten virheentarkistuksen voi toteuttaa
settereillä, jotka muokkaavat privaattikentäksi määriteltyä virhetaulukkoa.

**Ote kissojen malliluokasta**

~~~java
class Kissa {
  private Map<String,String> virheet = new HashMap<String,String>();

  public void setNimi(String uusinimi) {
    this.nimi = uusinimi;

    if (uusinimi.trim().length() == 0) {
      virheet.put("nimi", "Nimi ei saa olla tyhjä.");
    } else {
      virheet.remove("nimi");
    }
  }

  ...
~~~

### Numeerisen datan vastaanottaminen

Kaikki `request`-oliolta saatu data on merkkijonomuotoista.
Numeroiden vastaanottaminen on siksi astetta hankalampaa.

Numeromuotoisille kentille voi olla siksi järkevää tehdä erillinen merkkijonoja vastaanottava setteri,
joka käyttää normaalia setteriä hyväkseen:

~~~java
public void setPituus(int uusiPituus) {
  this.pituus = uusiPituus;

  if (uusiPituus <= 0) {
    virheet.put("pituus", "Kissalla täytyy olla positiivinen pituus.");
  } else {
    virheet.remove("pituus");
  }
}
public void setPituus(String uusipituus) {
  try {
    setPituus(Integer.parseInt(uusiPituus));
  } catch(NumberFormatException e) {
    virheet.put("pituus", "Kissan pituuden tulee olla kokonaisluku.");
  }
}
~~~

Kentissä, jotka viittaavat toisiin tauluihin, voi olla
järkevää tehdä tarkistuksia vielä siitä onko viitattu olento olemassa.
Tämän voi helposti tehdä tekemällä viitattuun tauluun sopivan
hakumetodin, jolla voi hakea tietueita pääavaimen perusteella:

~~~java
  //Tarkistetaan, että rotu on olemassa
  if (Kissarotu.etsi(uusirotu_id) == null) {
    this.virheet.put("rotu_id", "Kissan rotua ei löytynyt tietokannasta");
  } else {
    virheet.remove("rotu_id");
  }
~~~

Mallien välinen viittailu on myös mahdollista
rakentaa siten, että oliolle annnetaan setterissä toisen taulun
olioita, joista poimitaan id.

### Virhemetodien toteutus

onkoKelvollinen-metodin toteutukseksi riittää käytetyn virhetaulukon
tyhjyyden tarkistava [`isEmpty`-metodi](http://docs.oracle.com/javase/7/docs/api/java/util/HashMap.html#isEmpty()):

~~~java
  /* Palauttaa true, jos Kissaan syötetyt arvot ovat järkeviä. */
  public boolean onkoKelvollinen() {
    return this.virheet.isEmpty();
  }
~~~

getVirheet taas voi palauttaa virheet-assosiaatiotaulun arvojoukon sellaisenaan:

~~~java
  public Collection<String> getVirheet() {
    return virheet.values();
  }
~~~

## Käytettävä lisäyslomake

Lomakkeen kontrolleri ohjaa aina takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
Lomakkeessa on tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.

Tämän takia lomake kannatta toteuttaa siten, että sille annetaan aina jokin olio, jonka
tietoja lomakkeen input-tägit näyttävät.

~~~java
request.setAttribute("kissa", uusikatti);
naytaJSP("kissalomake.jsp", request, response);
~~~

~~~jsp
<input type="text" class="form-control" name="nimi" placeholder="Kissan nimi"
value="${kissa.nimi}">
~~~

Silloin kun käyttäjä ei ole vielä laittanut lomakkeeseen mitään, ei oliota
tarvitse välittää ollenkaan.

<info>
Jos oliollasi on numerokenttiä, on hyvä välittää niiden `value`-attribuuttiin suoraan käyttäjältä saatu syöte, jotta
käyttäjän mahdollisesti syöttämät kelvottomat numeromerkkijonot näkyvät sellaisenaan. 
Näin käyttäjän on helpompi korjata ne.

Tämän voi toteuttaa joko omana kenttänään suoraan malliluokassa tai erikseen kontrollerissa.
</info>

Jos käyttäjä taas on syöttänyt tietoja, mutta tiedot eivät ole käypiä,
näytetään olio, johon tietoja on koetettu syöttää, sekä
samalla olion kelpoisuuden tarkistamisesta saadut virheviestit.

~~~java
Collection<String> virheet = uusikatti.getVirheet();

request.setAttribute("virheet", virheet);
request.setAttribute("kissa", uusikatti);
naytaJSP("kissalomake.jsp", request, response);
~~~

### Syötteiden sanitointi

Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät
käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms. sotke sivujen
rakennetta.

Tähän ongelmaan autttaa parhaiten JSTL-kirjaston [out-tägi](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/):

~~~jsp
<c:out value="${muuttuja}"/>
~~~

### Viiteavaimet lomakkeissa {#selecttag}

Jos muokattavassa oliossa on viite johonkin toiseen tauluun
täytyy käyttäjälle näyttää lomakkeessa jonkinlainen valinta
eri vaihtoehtojen välillä. Helpoin tapa on käyttää [select-elementin][htmlselect]
kautta tehtävää pudotusvalikkoa:

~~~jsp
<label>Rotu</label>
<select name="rotu_id">
<c:forEach var="rotu" items="${kissarodut}">
  <option value="${rotu.id}">${rotu.nimi}</option>
</c:forEach>
</select>
~~~

Jotta esimerkki toimisi, on näkymälle tietenkin välitettävä kaikki kissarodut:

~~~java
request.setAttribute("kissarodut", Kissarodut.haeKaikki());
~~~

Lopputulos näyttää osapuilleen seuraavalta ja on hyvin helppokäyttöinen:

<label>Rotu</label>
<select name="rotu_id">
  <option value="1">Maatiaiskissa</option>
  <option value="2">Persialainen</option>
  <option value="3">Kissabussi</option>
  <option value="4">Siperiankissa</option>
  <option value="5">Pyhä birma</option>
  <option value="6">Elävä lelutiikeri</option>
</select>

[htmlselect]: http://www.w3schools.com/TAGS/tag_select.asp

### Viestien näyttäminen lisäyksen jälkeen {#sessionmessages}

Lisäyksen onnistuttua lomake ohjaa selaimen listaussivulle.
Onnistumisesta näytetään tällöin käyttäjälle viesti.

Jos käytät `sendRedirect`-metodia siirtymiseen sivulta toiselle,
tarvitset tavan välittää siirryttävälle sivulle
viestejä. Tähän tarkoitukseen istunto on mitä kätevin työkalu:

**Kontrollerissa**

~~~java
  //Lisätään kantaan kissa:
  uusikatti.lisaaKantaan();

  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty:
  HttpSession session = request.getSession();
  session.setAttribute("ilmoitus", "Kissa lisätty onnistuneesti.");

  //Lähetetään käyttäjä eteenpäin listasivulle:
  response.sendRedirect("kissalista");
~~~

Istuntoon asetettu virhe näytetään seuraavalla
käyttäjän avaamalla sivulla.
Toteutuksen voi tehdä esim. omana kirjastofunktionaan

~~~java
public void haeIlmoitus(HttpServletRequest request) {
  HttpSession session = request.getSession();
  String ilmoitus = session.getAttribute("ilmoitus");

  if (ilmoitus != null) {
    // Samalla kun viesti haetaan, se poistetaan istunnosta,
    // ettei se näkyisi myöhemmin jollain toisella sivulla uudestaan.
    session.removeAttribute("ilmoitus");

    request.setAttribute("ilmoitus", ilmoitus);
  }
}
~~~

Viestin hakemisen jälkeen on tietenkin huolehdittava siitä, ettei viesti jää
istuntoon roikkumaan, joten se poistetaan istunnosta heti.
Itse virhe taas näytetään pohjatiedostossa olevalla koodilla:

**Näkymien pohjatiedostossa**

~~~jsp
<c:if test="${ilmoitus != null}">
  <div class="alert alert-info">${ilmoitus}</div>
</c:if>
~~~

Tämänkaltaisen koodin ympärille kannattaa yleensä rakentaa jonkinlainen oma rajapintansa.

<next>
Kun lisäys on toteutettu, sen pohjalta voidaan toteuttaa myös
[muokkauslomake](muokkausnakymat.html).
</next>
