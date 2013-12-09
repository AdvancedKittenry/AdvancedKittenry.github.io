% Listaus Javalla

Varmista ensin, että sinulla on luokka tai funktio, jolla saat [yhteyden tietokantaan](../tietokantayhteys/index.html).
Nyt käytämme tietokantayhteyttä luokaksemme hyvin yksinkertaisen sivun, jolla listataan jonkun taulun sisältöä.
Teemme tämän kahdessa vaiheessa: 
Ensin luomme yksinkertaisen servletin, joka lähettää selaimelle yksinkertaista HTML:ää,
sitten laitamme tämän servletin näyttämään listan.
Lopulta luomme koodin, joka hakee tuon listan tietokannasta.

Tässä vaiheessa ymmärtämistä saattaa helpottaa [MVC-mallin rakenteen tunteminen](../arkkitehtuuri/index.html).

## Servletit

Tomcatille koodatessa kaikki dynaamista toiminnallisuutta vaativat sivut
koodataan *Servletteinä*.

Servletit ovat Java EE:ssä eli Javan nettipuolessa 
käytettäviä luokkia, jotka edustavat jonkin nettisivun tai toiminnon
_kontrollereita_. 
Servletit ja kontrollerit ovat Javan näkökulmasta useimmiten käytännössä sama asia. 

Jokainen Servlet-luokka on sidottu johonkin URL-osoitteeseen,
johon ohjattu aineistopyyntö aktivoi sen.
Sitomiset on käyttämässämme Java-ympäristön versiossa
määritelty XML-pohjaisesti tiedostossa `web/WEB-INF/web.xml`.
Tiedoston muokkaus on hieman monimutkaista, mutta esimerkiksi
NetBeans osaa muokata tämän tiedoston määrityksiä
kätevällä käyttöliittymällä ja liittää esimerkiksi uusien Servlettien 
URL-osoitteet sinne samalla kun Servlettiä luodaan, 
jolloin käytännössä tiedostoon tarvitsee koskea käsin aika harvoin.

### Servletin toiminta

Servletin toiminnan ytimessä ovat `doGet`- ja `doPost`-metodit,
jotka ottavat vastaan servletin osoitteeeseen
[GET- ja POST-metodeilla]({{rootdir}}web-sovelluksista.html#get-ja-post)
tehtyjä aineistopyyntöjä. 
NetBeansin vakiopohja Servlet-luokille luo nämä metodit automaattisesti
ja laittaa ne molemmat kutsumaan samaa `processRequest`-metodia.
Metodilla on parametreina HttpServletRequest-olio, joka sisältää pyynnön tiedot, ja HttpServletResponse-olio, johon voidaan määrittää pyynnölle vastaus.

**Esimerkki Netbeansillä tuotetusta Servlet-luokasta:**

~~~~java<include src="../java/esimerkit/rakenne/TestiServlet.java" />~~~~

Valmiin pohjan sisältämä vastauksen tuottava koodi sisältää 
suoraan kontrolleriin upotettua HTML-koodia. 
Tälläistä koodia ei pidemmän päälle kannata käyttää, mutta testitiedoston 
luomisen kannalta voimme muokata sen tuottamaan seuraavanlaisen listan:

~~~java
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
  List<String> asiat = new ArrayList<String>();
  asiat.add("Kirahvi");
  asiat.add("Trumpetti");
  asiat.add("Jeesus");
  asiat.add("Parta");

  response.setContentType("text/html;charset=UTF-8");
  PrintWriter out = response.getWriter(); 
  try {
    out.println("<html>"); 
    out.println("<head><title>Servlet TestiServlet</title></head>");
    out.println("<body>");
    out.println("<ul>");
    for (String asia : asiat) {
      out.println("<li>"+asia+"</li>");
    }
    out.println("</ul>");
    out.println("</body>");
    out.println("</html>");
  } finally {            
    out.close();
  }
}
~~~

Ohjeisen servletin pitäisi tuottaa selaimelle lista, jossa on asiat-listaan lisätyt
neljä asiaa.
Testaa tätä selaimessa nyt.

HTML:n upottaminen Java-koodiin on melko kömpelöä. 
Jatkossa kurssilla käytetään hieman edistyneempiä tekniikoita, 
mutta tietokantatestin kannalta tämä on yksinkertaisempaa.

Voit halutessasi katsoa miten esimerkki toteutetaan oikein
[viikon 3 materiaaleista](../java/rakenne.html).

## Tietokannan käyttö

Nyt kun meillä on tapa kirjoitaa lista, voimme kirjoittaa koodia,
joka palauttaa meille listan.

Aivan kuten tietokantayhteydenkin muodostamisen
kirjoitamme tietokantaa käsittelevän koodin omaan luokkaansa.
Tee jostakin sovelluksesi tietokohteesta, esim. käyttäjistä, oma luokkansa
ja tee sille staattinen metodi, joka palauttaa kaikki tuon tietokohteen taulun rivit
tuon luokan olioina.

Alla on esimerkki käyttäjäluokasta, jolla on metodi, joka palauttaa jokaisen käyttäjän.
Koodissa oletetaan, että Tietokanta-luokan metodi `getTietokanta` palauttaa 
sovelluksen tietokantaa vastaavan Connection-olion.


~~~java
public static List<Kayttaja> getKayttajat() {
  String sql = "SELECT id,username, password from users";
  Connection yhteys = Tietokanta.getTietokanta();
  PreparedStatement kysely = yhteys.prepareStatement(sql);
  ResultSet rs = kysely.executeQuery();

  ArrayList<Kayttaja> kayttajat = new ArrayList<Kayttaja>();
  while (rs.next()) {
    //Kutsutaan sopivat tiedot vastaanottavaa konstruktoria ja palautetaan olio:
    Kayttaja k = new Kayttaja(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
    kayttajat.add(k);
  }   
  //Suljetaan kaikki resurssit:
  try { rs.close(); } catch (Exception e) {}
  try { kysely.close(); } catch (Exception e) {}
  try { yhteys.close(); } catch (Exception e) {}

  return kayttajat;
}
~~~

Nyt listaesimerkin alku voi näyttää esimerkiksi seuraavalta:

~~~java
List<Kayttaja> kayttajat = Kayttaja.getKayttajat();
~~~

Ja koska kyseessä ovat oliot, pitää niitä listatessa tulostaa jokin merkkijono
eikä itse oliota:

~~~php
for (Kayttaja kayttaja : kayttajat) {
  out.println("<li>"+kayttaja.getUsername()+"</li>");
}
~~~

<vinkki title="Hyvä tietää">
Tällä viikolla tehtävä listaus on tahallaan melko yksinkertainen, sillä tarkoitus on vain testata tietokantaohjelmointia.
Lopulliset sivut tulevat noudattamaan läheisemmin [MVC-arkkitehtuuria][mvc].
</vinkki>

<next>
Testisovelluksen tehtyäsi voit tustustua tarkemmin viikon 3 materiaaliin:
[MVC-arkkitehtuuriin][mvc]
ja sen jälkeen [kirjautumisen toteuttamiseen](../java/index.html).
</next>

[mvc]: {{rootdir}}koodaaminen/arkkitehtuuri/index.html
