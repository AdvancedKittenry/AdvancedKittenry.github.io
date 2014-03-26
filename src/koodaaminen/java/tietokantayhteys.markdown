% Tietokantayhteyden pystytys
<!-- order: 1 -->
<!-- tags: viikko2-java -->

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Jotta tietokantaa pystyy käyttämään, pitää siihen ottaa yhteys
    * Yhteyttä mallinnetaan Javan JDBC-kirjaston tarjoamalla Connection-oliolla.
    * Luominen pitää sijoittaa omaan metodiinsa, jota käyttämällä muu voi ohjelmakoodi käyttää tietokantaoliota.
    * Metodi sijoitetaan omaan luokkaansa, joka sijoitetaan omaan tietokantakirjastoille tarkoitettuun pakettiinsa.
* Toteuta ensiksi mahdollisimman yksinkertainen testiohjelma, joka hakee tietokannasta tietoa
* Jos käytät tietokantayhteyden autentikointiin salasanaa, [älä laita sitä GitHubiin sellaisenaan](../git-ja-salasanat.html).
</summary>

Sekä Javalla että PHP:llä tietokantayhteyksiä edustaa erillinen luokka,
jonka olio muodostetaan kutsumalla sopivaa metodia/konstruktoria.
Kummallekin annetaan merkkijonona tietokantayhteyttä kuvaava osoite,
jonka perusteella yhteys muodostetaan. 

Alla on esimerkkikoodia tietokantayhteyden muodostamisesta 
tilanteessa, jossa työ pyörii users-palvelimella.
Koodin tarkoituksena on toteuttaa mahdollisimman yksinkertainen
ohjelma, joka ottaa yhteyden tietokantaan ja suorittaa siellä
SQL-muotoisen SELECT-lauseen, jonka tulos näytetään käyttäjälle.

Tee itsellesi ohjeita noudattaen luokka, johon sijoitat 
tietokannan muodostamisen. 
Laita tämä luokka omaan pakettiinsa ja/tai kansioonsa.
Hyviä nimiä paketille voivat olla esim. "Tietokanta" tai "Models".
Sovelluksesta tulee huomattavasti selkeämpi, jos kaikki tietokantaa käsittelevä
koodi on sijoitettu yhteen paikkaan.

## Tietokantayhteys: Java Database Connectivity (JDBC) ja context.xml

Javalla tietokantayhteyksien avaamiseen
käytetään Java Database Connectivity -kirjaston eli JDBC:n tarjoamaa 
DataSource-tyyppistä tietokantayhteysvarastoa,
joka huolehtii koko sovelluksen yhteyksien ylläpidosta 
ja kierrättämisestä eri aineistopyyntöjen välillä.

Ensiksi pitää kuitenkin määritellä Java-koodin rinnalle context.xml-tiedostoon
tietokantayhteyttä kuvaava resurssi.

**web/META-INF/context.xml**

~~~xml<include src="../../suunnittelu_ja_tyoymparisto/esimerkit/context.xml" />~~~

Viimeinen attribuuttti, `url` 
kertoo Tomcatille tietokannan sijainnin ja nimen. 
Users-palvelimella tietokannan nimi on aina oma käyttäjätunnuksesi.

<alert>
Joudut syöttämään tiedostoon
tietokantatunnustesi salasanan, että saat koodin toimimaan.
Salasanoja ei kannata laittaa repositorioon sellaisenaan.
Käytä sen sijaan [nk. dist-tiedostoja](../git-ja-salasanat.html)

Salasanojen laittaminen julkiseen git-repositorioon on yleisesti ottaen tietoturvan
kannalta paha tapa, joten sitä kannattaa välttää aina kun mahdollista.
</alert>

Kun resurssi on määritelty, voidaan Javan kirjastoilla hakea
se:

**Yhteysvaraston pystytyskoodi, sijoitetaan omaan luokkansa, esim. Kissalista.Tietokanta.Yhteys**

~~~java
//Haetaan context-xml-tiedostosta tietokannan yhteystiedot
//HUOM! Tämä esimerkki ei toimi sellaisenaan ilman Tomcat-palvelinta!
InitialContext cxt = new InitialContext();
DataSource yhteysVarasto = (DataSource) cxt.lookup("java:/comp/env/jdbc/tietokanta");
~~~

<expandable title="Yllä olevan koodin vaatimat importit">
~~~java
import java.sql.Connection;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
~~~
</expandable>

Kun yhteysvarasto on kerran luotu, saa siltä uusia yhteyksiä 
suorittamalla getConnection-metodin:

~~~java
Connection yhteys = yhteysVarasto.getConnection(); 
~~~

Menetelmän etuna on, ettei yhteyksien avaamisia tarvitse
erikseen hallinnoida, vaan varasto avaa niitä 
lisää sitä mukaa kun tarvetta on. 

Kannattaa huomata, että ylläoleva koodi voi ongelmatapauksissa johtaa sekä
`NamingException`:iin, että `SQLException`:iin. 
Suurin osa Javan tietokantakirjastojen toiminnoista
johtaa ongelmatapauksisa poikkeuksiin, joten niiden hallintaa varten kannattaa
kehittää sovelluksessa aivan oma koodinsa.

## Yhteyden sulkeminen

Kun olet suorittanut haluamasi SQL-kyselyn, yhteys pitää sulkea, 
jolloin se palaa takaisiin varastoon käytettäväksi:

~~~java
try { yhteys.close(); } catch (Exception e) {  }
~~~

Itse varasto-oliota ei tarvitse erikseen sulkea, sillä
Tomcat huolehtii sen hallinnoinnista.

<alert>
Jos yhteyttä ei suljeta aina käytön jälkeen, kasautuu 
avoimia yhteyksiä varatoon niin kauan kunnes tietokanta ei enää
anna ottaa useampia yhteyksiä jolloin sovellus kaatuu.
</alert>

## Kannan etäkäyttö NetBeansin kanssa

Jos haluat testata kantaa omalta koneeltasi käsin 
joudut
[muodostamaan ssh-tunnelin users-palvelimeen]({{rootdir}}suunnittelu_ja_tyoymparisto/users/postgres-ssh-tunneli.html).
Et saa kantaan yhteyttä ilman sitä (ellet asenna omaa palvelinta).

Tämän lisäksi
joudut lisäämään projektiisi 
PostgreSQL-kannan ajurikirjaston.
NetBeansia käyttäessäsi tämä hoituu samasta kohtaa, kuin JSTL-kirjaston lisääminen:
avaa valikosta `File->Project Properties`,
paina _Libraries_-kategoriassa nappia _Add Library_ ja 
lisää listasta projektiin kirjasto nimeltä `PostgreSQL JDBC Driver`.

![PostgreSQL-ajurin asennus]({{myimgdir}}postgres-ajuri.png)

Samanlaiset huomiot koskevat MySQL-tietokantaa.

Jos koodaat suoraan Users-palvelimella, sinun ei tarvitse tehdä tietokanta-ajurin käyttämiseksi mitään.

## Yhteyden testaaminen

Kun yhteys on muodostettu, sitä voi käyttää SQL-kyselyjen suorittamiseen.
Tehdään tätä varten lyhyt testiohjelma.

Javalla yhteyden testaamista varten pitää luoda
oma Servlet-luokka.
NetBeans sisältää niitä varten varsin toimivan
mallirungon, josta riittää vaihtaa `processRequest`-metodin
sisältö:

~~~java
//HttpServlet-luokan perivään servlettiin menevä metodi:
protected void processRequest(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
  Connection yhteys = Tietokanta.getYhteys(); //Haetaan tietokantaluokalta yhteysolio
  PreparedStatement kysely;
  ResultSet tulokset;
  PrintWriter out = response.getWriter(); 
  response.setContentType("text/plain;charset=UTF-8");

  try {
    //Alustetaan muuttuja jossa on Select-kysely, joka palauttaa lukuarvon:
    String sqlkysely = "SELECT 1+1 as two";

    kysely = yhteys.prepareStatement(sqlkysely);
    tulokset = kysely.executeQuery();
    if(tulokset.next()) {
      //Tuloksen arvoksi pitäisi tulla numero kaksi.
      int tulos = tulokset.getInt("two");
      out.println("Tulos: "+tulos"); 
    } else {
      out.println("Virhe!"); 
    }
  } catch (Exception e) {
    out.println("Virhe: "+e.getMessage()"); 
  }

  tulokset.close(); kysely.close();
}
~~~

Koodin pitäisi lähettää selaimelle teksti "Tulos: 2".

Jos et käytä NetBeansia, voit katsoa koodiesimerkkejä
[listauksen toteuttamisohjeista](listaustesti.html).

Kun olet saanut saanut yhteyden toimimaan ja palauttamaan kannasta tietoa,
laita se omaan luokkaansa, jossa on metodi, joka palauttaa yhteyden. 
Voit sijoittaa luokkaan 
muitakin toistuvia tietokantaan liittyviä koodinpätkiä, 
kuten vaikkapa yhteyden sulkemisen toteuttavan metodin.

<next>
Kun olet saanut tietokantaan toimivan yhteyden ja laittanut sen omaan tiedostoonsa, 
voit jatkaa tietokantaohjelmointia
tekemällä [yksinkertaisen listauksen](listaustesti.html).
</next>
