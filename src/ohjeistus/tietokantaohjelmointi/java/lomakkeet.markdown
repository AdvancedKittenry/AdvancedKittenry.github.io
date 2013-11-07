% Lomakkeiden käyttö ja vastaanottaminen
<!-- order: 3 -->

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
  
  /* Tarkistetaan mallilta onko parametrina saatu oikeat tunnukset */
  if (Kissalista.Mallit.Kayttaja.getKayttaja(kayttaja, salasana) != null) {
    /* Jos tunnus on oikea, ohjataan käyttäjä HTTP-ohjauksella kissalistaan. */
    response.sendRedirect("kissalista");
  } else {
    /* Väärän tunnuksen syöttänyt saa eteensä lomakkeen ja virheen.
     * Tässä käytetään omalta yläluokalta perittyjä yleiskäyttöisiä metodeja.
     */
    asetaVirhe("Kirjautuminen ei onnistunut. Käyttäjää ei löytynyt", request);
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

Toteuta ylläolevan kaltainen tarkastus omaan kirjautumisservlettiisi.
Voit tehdä tarkistuksen joko niin, että se toimii samassa servletissä tai tehdä
kirjautumislomakkeen vastaanottolle oman servletin. 
Tee myös aiemmin tekemääsi käyttäjää mallintavaan luokkaan metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se palauttaa käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa käytetään myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

**Ote tiedostosta kissalista/models/Kayttajat.java:**

~~~java
public static Kayttaja getKayttaja(String kayttaja, String salasana) {
  String sql = "SELECT id,username, password from users where username = ? AND password = ?";
  Connection yhteys = Tietokanta.getTietokanta();
  PreparedStatement kysely = yhteys.prepareStatement(sql);
  kysely.setString(1, kayttaja);
  kysely.setString(2, salasana);
  ResultSet rs = kysely.executeQuery();

  if (rs.next()) {
    //Kutsutaan sopivat tiedot vastaanottavaa konstruktoria ja palautetaan olio:
    return new Kayttaja(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
  } else {
    return null;
  }
  
  //Suljetaan kaikki resurssit:
  try { rs.close(); } catch (Exception e) {}
  try { kysely.close(); } catch (Exception e) {}
  try { yhteys.close(); } catch (Exception e) {}
}
~~~

Varmista, että kirjautumislomake näyttää käyttäjälle järkevän virheviestin
mikäli kirjautuminen ei onnistu.

<next>

Seuraavaksi käytämme istuntoja [kirjautumisen tallentamiseen sivulatausten välillä](istunnot.html).

</next>
