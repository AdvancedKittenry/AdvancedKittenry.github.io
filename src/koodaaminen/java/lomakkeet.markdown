% Lomakkeiden käyttö ja vastaanottaminen
<!-- order: 5 -->

<summary>
* Tehdään kirjautumisen vastaanottamista varten oma kontrolleri, joka käyttää aiemmin tehtyä kirjautumisen html-demokoodia näkymänään.
    * Saatat joutua muuttamaan html-tiedostosi JSP-tiedostoksi.
* Kontrollerin ottaa vastaan lomakkeen tiedot ja lähettää käyttäjän eteenpäin, jos kirjautuminen onnistuu.
* Jos tunnukset ovat väärät näytetään kirjautumislomake.
    * Käyttäjä näkee samalla virheviestin, joka kertoo mikä meni pieleen.
    * Jos käyttäjä syötti käyttäjätunnuskenttään jotakin, säilyy kentän sisältö myös virhesivulla. Niin käyttäjän ei tarvitse kirjoittaa nimeä uudestaan.
</summary>

Seuraavaksi tee servletti, joka näyttää
html-demoon tekemäsi kirjautumislomakkeen
JSP-tekniikalla. 
Voit laittaa servlettisi esim. osoitteeseen `/kirjautuminen`
tai `/login`. 

Laitetaan seuraavaksi tämä servlet-luokka ottamaan kirjautuminen myös vastaan.

## Lomakkeiden vastaanottaminen

Oletetaan, että kirjautumissivulla on suurinpiirtein allaolevan tapainen lomake.

~~~html
<form action="login" method="POST">
Käyttäjänimi: <input type="text" name="username" />
Salasana: <input type="password" name="password" />
<button type="submit">Kirjaudu</button>
</form>
~~~

HTML-kertauksena: `form`-elementin `action`-attribuutti määrittää 
mihin osoitteeseen lomakkeen tiedot lähetetään, 
`method` sensijaan kertoo lähetetäänkö tiedot GET- vai POST-parametreina.
Jokaisen `input`-elementin sisältö lähetetään parametrina, 
joka tunnistetaan `name`-attribuutissa annetulla nimellä.

Lähetetyn lomakkeen parametreja voidaan käsitellä hakemalla ne 
HttpServletRequest-olion
[getParameter-metodilla](http://docs.oracle.com/javaee/6/api/javax/servlet/ServletRequest.html#getParameter(java.lang.String)).

Hyvin yksinkertainen kirjautuminen voitaisiin sitä käyttäen toteuttaa suurinpiirtein seuraavasti:

~~~java
protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
  
  String salasana = request.getParameter("password");
  String kayttaja = request.getParameter("username");
  
  /* Muuten tarkistetaan onko parametrina saatu oikeat tunnukset */
  if ("svinhufvud".equals(kayttaja) && "kissakartano".equals(salasana)) {
    /* Jos tunnus on oikea, ohjataan käyttäjä HTTP-ohjauksella kissalistaan. */
    response.sendRedirect("kissalista");
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä kirjautumislomakkeen.
     * Tässä käytetään omassa kirjastotiedostossa määriteltyä näkymännäyttöfunktioita */
    naytaJSP("login.jsp", request, response);
  }
}
~~~

Koodissa kannattaa huomata kutsu `response.sendRedirect("kissalista");`.
`HttpServletResponse`-olion 
[sendRedirect-metodi](http://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletResponse.html#sendRedirect(java.lang.String))
lähettää käyttäjän selaimen parametrina annettuun osoitteesen.
Tämä on kätevä tapa ohjata käyttäjä jonkin toisen servletin luo.
Voit halutessasi tehdä siitäkin metodin aiemmin tekemääsi servlet-yläluokkaan.

Testaa ylläolevan tapaista koodia omassa sovelluksessasi.
Voit tehdä lomakkeen vastaanottamisen joko niin, että se toimii samassa servletissä lomakkeen näyttämisen kanssa tai tehdä
kirjautumislomakkeen vastaanottolle oman servletin. 

Keskitytään tämän jälkeen tekemään koodista käyttäjäystävällisempi.

## Käytettävyys

Ylläolevassa kirjautumiskäsittelijässä on kaksi olennaista käytettävyysongelmaa.
Ensinnäkin, mikäli käyttäjä syöttää väärän tunnuksen tai salasana tai ei syötä jompaakumpaa ollenkaan, lomake vain palaa kirjautumisruutuun
kertomatta mitä tapahtui. 
Käyttäjälle jää hiipivä epäilys siitä, ottiko sovellus tunnuksia ollenkaan vastana, kun se ei kerro mitään tekemisistään.

Toinen, hieman pienempi, ongelma on, että salasanansa väärin syöttänyt käyttäjä joutuu syöttämään käyttäjätunnuksensa turhaan uudestaan.

Korjataan nämä ongelmat!

Jälkimmäisen ongelman korjaaminen on yksinkertaista, tarvitsee vain lisätä
näkymän näyttämiseen määrite, jossa lähetetään
käyttäjän syöttämä käyttäjätunnus näkymälle ja sitten näyttää se
näkymässä:

<sidebyside>
<column size="7">
**Servlet:**

~~~java
request.setAttribute("kayttaja", kayttaja);  
naytaJSP("login.jsp", request, response);
~~~

</column>
<column size="5">

**JSP-tiedosto:**

~~~jsp
Käyttäjänimi: <input type="text" name="username" value="${kayttaja}" />
~~~

</column>
</sidebyside>

Ensimmäinen ongelma eli virheviestien näyttäminen on niin yleinen, että
sitä varten kannattaa sijoittaa oma koodinsa template-tagiin,
sillä sitä tullaan oikeasti tarvitsemaan *lähes jokaisella sivulla*.
Idea on samanlainen kuin käyttäjäkentän esitäyttämisessä, mutta 
koodi sijaitsee tag-tiedostossa:

<sidebyside>
<column size="7">
**Servlet:**

~~~java
if (kayttaja.equals('svinhufvud') && salasana.equals('kissakartano')) {
  response.sendRedirect("kissalista");
} else {
  request.setAttribute("virheViesti", "Kirjautuminen epäonnistui! Antamasi tunnus tai salasana on väärä.");
  request.setAttribute("kayttaja", kayttaja);  
  naytaJSP("login.jsp", request, response);
}
~~~

</column>
<column size="5">

**Tag-tiedosto:**

~~~jsp
<c:if test="${virheViesti != null}">
  <div class="alert alert-danger">Virhe! ${virheViesti}</div>
</c:if>
~~~

</column>
</sidebyside>

On hyvä idea tehdä virheviestit myös sille, että joko
käyttäjää tai salasanaa ei ole syötetty ollenkaan.

Lopullinen kontrollerin koodi voi olla vaikkapa tämän näköinen.

~~~java
protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
  
  String salasana = request.getParameter("password");
  String kayttaja = request.getParameter("username");
  
  /* Jos kummatkin parametrit ovat null, käyttäjä ei ole edes yrittänyt vielä kirjautua. 
   * Näytetään pelkkä lomake */
  if (kayttaja == null || !kayttaja.equals("")) {
    naytaJSP("login.jsp", request, response);
    return;
  }

  //Tarkistetaan että vaaditut kentät on täytetty:
  if (kayttaja == null && !kayttaja.equals("")) {
    asetaVirhe("Kirjautuminen epäonnistui! Et antanut käyttäjätunnusta.", request);
    naytaJSP("login.jsp", request, response);
  }

  /* Välitetään näkymille tieto siitä, mikä tunnus yritti kirjautumista */
  request.setAttribute("kayttaja", kayttaja);  

  if (salasana == null && !salasana.equals("")) {
    asetaVirhe("Kirjautuminen epäonnistui! Et antanut käyttäjätunnusta.", request);
    naytaJSP("login.jsp", request, response);
  }
  
  /* Tarkistetaan onko parametrina saatu oikeat tunnukset */
  if (kayttaja.equals('svinhufvud') && salasana.equals('kissakartano')) {
    /* Jos tunnus on oikea, ohjataan käyttäjä HTTP-ohjauksella kissalistaan. */
    response.sendRedirect("kissalista");
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä lomakkeen ja virheen.
     * Tässä käytetään omalta yläluokalta perittyjä yleiskäyttöisiä metodeja.
     */
    asetaVirhe("Kirjautuminen epäonnistui! Antamasi tunnus tai salasana on väärä.", request);
    naytaJSP("login.jsp", request, response);
  }
}
~~~

Myös koodin alussa oleva muuttujien olemassaolon varmistamisesta huolehtiva koodi
on hyvä kandidaatti yleiskäyttöisen funktion sisällöksi,
sillä tuontapainen koodi toistuu lomakkeiden käsittelyssä hyvin usein.

<alert>
Muista aina testata koodiasi erilaisilla syötteillä niin varmistat ettei se kaadu missään tilanteessa.

Kannattaa huomioida etenkin tilanteet, joissa parametria
ei ole annettu, sillä `getParameter` palauttaa silloin arvon null.
Tästä seuraa usein ikävä `NullPointerException`, kun erehdytään 
kutsumaan null-arvolta esimerkiksi `equals`-metodia.
</alert>

## Salasanan tarkistaminen ja tallettaminen turvallisesti

Salasanankentän voi toteuttaa joko paljaana salasanan sisältävänä
tekstikenttänä tai käyttää salasanojen 
hashausta
jossa salasanan sijasta tietokantaan 
tallennetaan siitä kryptograafisella tiivistefunktiolla
muodostettu tiiviste. 

Menetelmä on huomattavasti turvallisempi tapa säilyttää salasanoja,
sillä silloin niitä ei ole mahdollista lukea kannasta suoraan.
Aiheesta voi lukea lisää mm. 
[tältä sivulta](https://crackstation.net/hashing-security.htm).

<next>
Toteuta ylläolevan kaltaiset käytettävyysparannukset myös omaan kirjautumisservlettiisi.

Lisää sitten kirjautumisen taustalle [käyttäjän hakeminen tietokannasta](mallit_tiedonhaku.html).
</next>
