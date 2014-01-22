% Tietokantayhteyden pystytys
<!-- order: 3 -->

Seuraavaksi pyrimme luomaan tiedoston, jossa on tarvittava koodi
tietokantayhteyden luomiseen.
Samoin esitetään lyhyet testiohjelma, jolla yhteyttä voi testata. 

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Jotta tietokantaa pystyy käyttämään, pitää siihen ottaa yhteys
    * Yhteyttä mallinnetaan käytetyn kielen tietokantakirjaston tarjoamalla oliolla.
    * Luominen pitää sijoittaa omaan metodiinsa, jota käyttämällä muu voi ohjelmakoodi käyttää tietokantaoliota.
    * Metodi sijoitetaan omaan luokkaansa ja tiedostoonsa, joka sijoitetaan omaan tietokantakirjastoille tarkoitettuun pakettiinsa ja hakemistoonsa.
* Jos käytät tietokantayhteyden autentikointiin salasanaa, [älä laita sitä GitHubiin sellaisenaan](../git-ja-salasanat.html#salasanojen-tallentaminen-ja-github).
</summary>

Sekä Javalla että PHP:llä tietokantayhteyksiä edustaa erillinen luokka,
jonka olio muodostetaan kutsumalla sopivaa metodia/konstruktoria.
Kummallekin annetaan merkkijonona tietokantayhteyttä kuvaava osoite,
jonka perusteella yhteys muodostetaan. 

Alla esimerkit tietokantayhteyden muodostamisesta Javalla ja PHP:llä
tilanteessa, jossa työ pyörii users-palvelimella.

Tee itsellesi ohjeita noudattaen tiedosto, johon sijoitat 
tietokannan muodostamisen. 
Laita tämä tiedosto omaan pakettiinsa ja/tai kansioonsa.
Hyviä nimiä paketille/hakemistolle voivat olla esim. "Tietokanta" tai "Models".
Sovelluksesta tulee huomattavasti selkeämpi, jos kaikki tietokantaa käsittelevä
koodi on sijoitettu yhteen paikkaan.

<tabs>
<tab title="Java, JDBC ja context.xml">

Javalla tietokantayhteyksien avaamiseen
käytetään DataSource-tyyppistä tietokantayhteysvarastoa,
joka huolehtii koko sovelluksen yhteyksien ylläpidosta 
ja kierrättämisestä eri aineistopyyntöjen välillä.

Ensiksi pitää kuitenkin määritellä Java-koodin rinnalle context.xml-tiedostoon
tietokantayhteyttä kuvaava resurssi.

**web/META-INF/context.xml**

~~~xml<include src="../../suunnittelu/esimerkit/context.xml" />~~~

<alert>
Joudut syöttämään tiedostoon
tietokantatunnustesi salasanan, että saat koodin toimimaan.
Salasanoja ei kannata laittaa repositorioon sellaisenaan.
Käytä sen sijaan [nk. dist-tiedostoja](../git-ja-salasanat.html)
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
[muodostamaan ssh-tunnelin users-palvelimeen]({{rootdir}}pystytys/postgres-ssh-tunneli.html).
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
    String sql = "SELECT 1+1 as two";
    kysely = yhteys.prepareStatement(sql);
    tulokset = kysely.executeQuery();
    if(tulokset.next()) {
      int kakkonen = tulokset.getInt("two");
      out.println("Tulos: "+kakkonen"); 
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

Jos et käytä NetBeansia, voit katsoa kontrolleriesimerkkejä
[listauksen toteuttamisohjeista]({{rootdir}}koodaaminen/listaustesti/java.html).

Kun olet saanut saanut yhteyden toimimaan ja palauttamaan kannasta tietoa,
laita se omaan luokkaansa, jossa on metodi, joka palauttaa yhteyden. 
Voit sijoittaa luokkaan 
muitakin toistuvia tietokantaan liittyviä koodinpätkiä, 
kuten vaikkapa yhteyden sulkemisen toteuttavan metodin.

</tab>
<tab title="PHP ja PDO">

Sijoita allaolevat koodit ensiksi omaan
testausta varten tekemääsi tiedostoon, esim. `yhteystesti.php`.

Yhteyden avaaminen onnistuu seuraavalla tavalla.

**yhteystesti.php**

~~~php
<?php
//Tietokannan tunnukset:
$tunnus = "kayttajatunnuksesi";
$salasana= "psql-salasana";

//Yhteysolion luominen
$yhteys = new PDO("pgsql:host=localhost;port=5432;dbname=$tunnus", $tunnus, $salasana);

//Seuravaa komento pyytää PDO:ta tuottamaan poikkeuksen aina kun jossain on virhe.
//Kannattaa käyttää, oletuksena luokka ei raportoi virhetiloja juuri mitenkään!
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

Koodatessa PostgreSQL:llä users-palvelimella voidaan käyttää myös lyhyempää yhteysosoitetta, johon ei laiteta salasanaa:

~~~php
<?php
$yhteys = new PDO("pgsql:");
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

<alert>
Jos käytät koodista sitä versiota, joka tarvitsee salasanan, älä 
laita sitä repositorioosi suoraan.
Käytä sen sijaan [dist-tiedostoja](../git-ja-salasanat.html)
</alert>

## Yhteyden testaaminen

Tietokannan nopeaan testaamisen voi käyttää seuraavanlaista koodia,
jonka voi sijoittaa suoraan yllä esitetyn yhteyden muodotamisen perään:

**yhteystesti.php**

~~~inlinephp
$sql = "select 1+1 as two";
$kysely = $yhteys->prepare($sql);


if ($kysely->execute()) {
  $kakkonen = $kysely->fetchColumn();
  var_dump($kakkonen);
}
~~~

Koodin pitäisi tulostaa seuraava teksti debug-koodaukseen tarkoitettua
[var_dump](http://php.net/manual/en/function.var-dump.php)-funktiota käyttäen:

~~~
int(2)
~~~

Kun olet saanut saanut yhteyden toimimaan ja palauttamaan kannasta tietoa,
tee yhteyden muodostamista varten oma tiedostonsa ja luo sitä
ja muita tietokantaan liittyviä tiedostoja varten oma hakemistonsa,
jonka nimi voi olla vaikkapa `libs` tai `kirjastot`.
Tähän tiedostoon sijoitetaan joko luokkaan tai funktioon 
yllä esitetty yhteyskoodi.

Huomaa, että on tärkeää, että yhteys luodaan vain kerran, sillä sen luominen on verraten hidasta.

Voit tehdä yhteydelle halutessasi luokan, johon voi sijoittaa 
muitakin toistuvia tietokantaan liittyviä koodinpätkiä.
Jos et halua tehdä luokkaa, voit PHP:llä käyttää myös lyhyttä funktiota, jossa on funktion sisäinen
[staattinen muuttuja](http://php.net/manual/en/language.variables.scope.php#language.variables.scope.static):

**libs/tietokantayhteys.php**

~~~inlinephp
<?php
function getTietokantayhteys() {
  static $yhteys = null; //Muuttuja, jonka sisältö säilyy getTietokantayhteys-kutsujen välillä.

  if ($yhteys === null) { 
    //Tämä koodi suoritetaan vain kerran, sillä seuraavilla 
    //funktion suorituskerroilla $yhteys-muuttujassa on sisältöä.
    $yhteys = new PDO('pgsql:');
    $yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
  }

  return $yhteys;
}
~~~

Nyt jossain toisessa tiedostossa funktiota voi käyttää vaikkapa näin:

~~~php
<?php
  require 'libs/tietokantayhteys.php';
  $kysely = getTietokantayhteys()->prepare("SELECT 1");
  $kysely->execute();
  
  echo $kysely->fetchColumn();
~~~

</tab>
</tabs>

<next>
Kun olet saanut tietokantaan toimivan yhteyden ja laittanut sen omaan tiedostoonsa, 
voit jatkaa tietokantaohjelmointia
tekemällä [yksinkertaisen listauksen](../listaustesti/index.html).
</next>
