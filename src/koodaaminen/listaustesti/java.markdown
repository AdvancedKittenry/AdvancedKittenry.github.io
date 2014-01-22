% Listaus Javalla

<summary>
* Servlettien käyttämisen alkeet
    * Javalla käytännössä kaikki nettisivut toteutetaan Servletteinä
    * Servletissä voi tulostaa HTML:ää suoraan samanlaisella rajapinnalla kuin `System.out.println`. Tämä on yksinkertaisin, mutta ei kuitenkaan paras mahdollinen tapa.
    * Myöhemmin HTML-sivut toteutetaan JSP-kielellä
* Tietokannan käsittely keskitetään omiin luokkiinsa eli *malleihin*.
* Käytännössä jokaista tietokohdetta vastaa yksi malliluokka.
    * Puhtaille välitauluille harvemmin tarvitaan omaa luokkaansa, vaan niiden toiminnot hoidetaan itse tietokohteiden kautta.
    * Luokka sisältää tarvittavat taulun käsittelyyn metodit.
</summary>

Varmista ensin, että sinulla on luokka tai funktio, jolla saat [yhteyden tietokantaan](../tietokantayhteys/index.html).
Nyt käytämme tietokantayhteyttä luodaksemme hyvin yksinkertaisen sivun, jolla listataan jonkun taulun sisältöä.
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

## Tietokannan käyttö ja mallit

Nyt kun meillä on tapa laittaa lista näkyville, voimme kirjoittaa koodia,
joka tuottaa meille listan tietokannassa olevista asioista, vaikkapa kissoista.

Aivan kuten tietokantayhteydenkin muodostamisenkin
kirjoitamme tietokantaa käsittelevän koodin omaan tiedostoonsa.
Tapana on jakaa tietokantaa käsittelevä koodi tietokohteittain
siten, että kutakin tietokantataulua käsittelevä koodi on 
omassa luokassaan. Näitä luokkia kutsutaan malleiksi.
(Malleista ja sovelluksen arkkitehtuurista voi lukea lisää 
[kolmosviikon materiaalista]({{rootdir}}koodaaminen/arkkitehtuuri/index.html))

Poikkeuksena tietokantataulujen ja malliluokkien vastaavuuteen
ovat tosin välitaulut, joille ei välttämättä aina tarvitse tehdä omaa tietokantatauluaan.

Tässä materiaalissa rakennamme mallit niin, että kunkin malliluokan
oliot vastaavat mallin kuvaaman tietokantataulun rivejä
ja mallissa on staattisia metodeja, joilla on mahdollista
hakea näitä olioita tietokannasta.

### Mallin tekeminen käyttäjille

Tehdän ensi viikon kirjautumisen toteuttamista silmälläpitäen
jo valmiiksi käyttäjille oma malliluokkansa.
Lisätään luokalle attribuuteiksi käyttäjätaulun kentät, sekä konstruktori:

~~~java
package Kissalista.Mallit;

public class Kayttaja {
  private int id;
  private String tunnus;
  private String salasana;

  public Kayttaja(int id, String tunnus, String salasana) {
    this.id = id;
    this.tunnus = tunnus;
    this.salasana = salasana;
  }

  /* Tähän gettereitä ja settereitä */
}
~~~

Tehdään seuraavaksi luokalle staattinen metodi, joka palauttaa 
kaikki tuon tietokohteen taulun rivit tuon luokan olioina.
Käytetään tähän aiemmin tekemäämme tietokantayhteysluokka, jolta kysymme `Connection`-oliota:

~~~java
Connection yhteys = Tietokanta.getYhteys();
~~~

Yhteysoliota voi pyytää valmistelemaan SQL-koodia suoritettavaksi kutsumalla sen `prepareStatement`-metodia.
Tuloksena saatavan `PreparedStatement`-olion voi taas käskeä sille annetun suorittamaan SQL:n
kutsumalla `executeQuery`-metodia.

~~~java
String sql = "SELECT id, tunnus, salasana from kayttajat";
PreparedStatement kysely = yhteys.prepareStatement(sql);
ResultSet rs = kysely.executeQuery();
~~~

Tuloksena on `ResultSet`-olio, joka kuvaa sarjaa tietokannasta haettuja rivejä.
Olio viittaa aina kerrallaan yhteen tuloksena saaduista riveistä,
jossa olevia arvoja siltä voi kysellä erinäköisillä tietotyyppikohtaisilal 
gettereillä. Seuraavan rivin saa kutsumalla `next`-metodia.
Aluksi `ResultSet`-olio on kuitenkin aina tuloksen ns. nollannella rivillä, jolla ei
ole arvoja ollenkaan. Se pitää siis heti kättelyssä siirtää ensimmäiselle oikealle riville.
Jos tuloksia odotetaan useita, tämä hoituu kätevästi while-loopilla:

~~~java
while(rs.next()) {
  //Haetaan tietoa riviltä
  int id = rs.getInt("id");
  String tunnus = rs.getString("tunnus");
  String salasana = rs.getString("salasana");
}
~~~

Nämä arvot voidaan nyt tallentaa olioihin, jotka voidaan tallentaa listaan
ja palauttaa metodin kutsujalle.
Lopuksi pitää muistaa sulkea kaikki kolme resurssia: ResultSet, PreparedStatement ja Connection.
Jos näin ei muisteta tehdä, sovellus lakkaa ennenpitkää toimimasta kunnolla, sillä yhteyksiä on mahdollista pitää yllä vain rajallinen määrä.

Alla on esimerkki valmiista metodista, joka palauttaa jokaisen käyttäjän.

~~~java
public static List<Kayttaja> getKayttajat() {
  String sql = "SELECT id, tunnus, salasana from kayttajat";
  Connection yhteys = Tietokanta.getYhteys();
  PreparedStatement kysely = yhteys.prepareStatement(sql);
  ResultSet rs = kysely.executeQuery();

  ArrayList<Kayttaja> kayttajat = new ArrayList<Kayttaja>();
  while (rs.next()) {
    //Kutsutaan sopivat tiedot vastaanottavaa konstruktoria ja palautetaan olio:
    Kayttaja k = new Kayttaja(rs.getInt("id"), rs.getString("tunnus"), rs.getString("salasana"));
    kayttajat.add(k);
  }   
  //Suljetaan kaikki resurssit:
  try { rs.close(); } catch (Exception e) {}
  try { kysely.close(); } catch (Exception e) {}
  try { yhteys.close(); } catch (Exception e) {}

  return kayttajat;
}
~~~

### Koodin käyttäminen servletissä

Malliluokan koodia käyttäen listaesimerkin alku voi näyttää esimerkiksi seuraavalta:

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
