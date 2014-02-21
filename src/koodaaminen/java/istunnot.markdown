% Istunnot ja kirjautumisen tallentaminen
<!-- order: 7 -->
<!-- tags: viikko3-java -->

Edellä toteutetussa kirjautumisessa on se huono puoli,
ettei se tallennu mihinkään, sillä [HTTP-protokolla on tilaton]({{rootdir}}web-sovelluksista.html#tilatiedon-hallinta-ja-samanaikaiset-aineistopyynn%C3%B6t),
eikä aineistopyyntöjen välillä talleteta informaatiota.

Apuun ongelmaan tulee Javan istuntotuki. 
Istunnot ovat ikäänkuin pieniä, käyttäjä- ja selainkohtaisia tietokantoja,
joihin voi tallettaa olioita siten, että ne säilyvät sivulataukselta toiselle.

Kirjautumisen tapauksessa haluamme tallentaa tiedon siitä kuka on kirjautunut
sisään. Tieto tallennetaan istuntoon siinä vaiheessa, kun käyttäjä kirjautuu sisään
ja sitä käytetään aina kun halutaan tarkastella onko käyttäjä kirjautunut sivulle.

Javassa istunto otetaan käyttöön kutsumalla HttpServletRequest-olion
[getSession-metodia](http://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#getSession(boolean)). 
Metodi palauttaa käyttäjän istunnon tai mikäli sellaista ei vielä ole olemassa, luo sen.
Istunto-olioon voi tämän jälkeen tallentaa tietoa ja tarkastella siellä olevia tietoja.

Esimerkki kirjautuneen käyttäjän tallentamisesta istuntoon:

~~~java
HttpSession session = request.getSession();
Kayttaja kayttaja = etsiKayttajaTunnuksilla("kalle", request.getParameter("salasana")));

if (kayttaja != null) {
  //Tallennetaan istuntoon käyttäjäolio
  session.setAttribute("kirjautunut", kayttaja);
}
~~~

Myöhemmin jollain aivan toisella sivulla
voidaan tarkistaa onko joku kirjautunut seuraavasti:

~~~java
Kayttaja kirjautunut = (Kayttaja)session.getAttribute("kirjautunut");
if (kirjautunut != null) {
  //Koodia, jonka vain kirjautunut käyttäjä saa suorittaa
}
~~~

Käytä istunto-oliota kirjautumisservletissäsi siten, että talletat
jokaisen onnistuneen kirjautumisen yhteydessä kirjautuneen käyttäjän tiedot istuntoon. 
Useimmiten on järkevää tallentaa joko käyttäjätaulun pääavaimen arvo 
(id tai käyttäjätunnus) tai kerralla kokonainen käyttäjäolio
kaikkinen tietoineen. Kummankin tallentaminen istuntoon onnistuu samalla `setAttribute`-metodilla.

## Kirjautumisen tarkistaminen

Lisää yleiskäyttöiseen servlet-yläluokkaasi metodi, 
joka palauttaa arvon `true`, mikäli käyttäjä on kirjautunut ja istunnossa on tallennettuna käyttäjän kirjautumistiedot.
Metodi voi halutessasi myös ohjata käyttäjän kirjautumissivulle mikäli näin ei ole.
Näin kirjautumista vaativat sivut voivat kätevästi tarkistaa onko käyttäjä oikeasti kirjautunut.

Jos sovelluksessasi on monia erilaisia käyttöoikeustasoja tms., voit tehdä
vastaavan metodin myös käyttöoikeuden tarkistamiseen.

Käytä tekemääsi metodia estääksesi käyttäjää pääsemästä kirjautumista vaativille sivuille ilman kirjautumista.

## Uloskirjautuminen

Kun olet lisännyt kirjautumistarkistuksen kaikille sivuille jotka sitä vaativat,
uloskirjautumisen toteuttamiseksi riittää poistaa istuntoon tallennetut
tiedot kirjautumisesta. Tämän jälkeen käyttäjä ei enää pääse sivuille sisään.

~~~java
//Kirjaudutaan ulos
session.removeAttribute("kirjautunut");
~~~

<last>

Kun olet toteuttanut kaikki näissä ohjeissa mainitut asiat, olet saanut valmiiksi viikon 3 palautuksen. Varmista vielä, että kaikki tiedostot löytyvät repositoriostasi.

</last>
