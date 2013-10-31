% Tietokantayhteyden pystytys
<!-- order: 1 -->

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Tietokantayhteyden luonti.
    * Luominen pitää sijoittaa omaan metodiinsa, josta muut tiedostot sitä käyttävät.
    * Java-kielen NetBeans-ohjeita käyttäneille tarpeen on myös: [PostgreSQL-ssh-tunnelin luonti]({{rootdir}}ohjeistus/users/postgres-ssh-tunneli.html). 
      Sama pätee kaikkiin projekteihin, joissa käytetään users:in tietokantaa etänä.
    * Tietokantaa kannattaa tässä vaiheessa testata jollain hyvin yksinkertaisella testikoodilla.
* Javalla tietokantayhteydet pitää vielä sulkea aineistopyynnön käsittelyn lopuksi. Tätä varten kannattaa tehdä oma metodi.
* Jos käytät tietokantayhteyden autentikointiin salasanaa, [älä laita sitä GitHubiin sellaisenaan](#salasanojen-tallentaminen-ja-github).
</summary>

Seuraavaksi pyrimme luomaan tietokantaan yhteyden ja lyhyen testiohjelman, 
jolla sitä voi testata. 
Sekä Javalla että PHP:llä tietokantayhteyksiä edustaa erillinen luokka,
jonka olio muodostetaan kutsumalla sopivaa metodia/konstruktoria.
Kummallekin annetaan merkkijonona tietokantayhteyttä kuvaava osoite,
jonka perusteella yhteys muodostetaan. 

<alert>
Viimeistään tässä vaiheessa kannattaa varmistaa, että kirjoittamasi SQL-tiedostot saa
ajettua tietokantaan virheettä.
</alert>

Alla esimerkit tietokantayhteyden muodostamisesta Javalla ja PHP:llä
tilanteessa, jossa tietokantapalvelin on samalla koneella eli osoitteessa `localhost`.
Mikäli tietokantapalvelin on toisella tietokoneella, laita `localhost`:in
tilalle koneen osoite. 

Users.cs.helsinki.fi-palvelimen kanssa tämä ei tosin valitettavasti onnistu,
sillä tietokantapalvelin on palomuurin takana.
Joudut tällöin käyttämään [ssh-tunnelia](ssh-tunnelit.html)

Jos olet noudattanut kurssin NetBeans-ohjetta Java-kielellä, 
tutustu [ssh-tunnelin](ssh-tunnelit.html) muodostamiseen nyt.
Et saa kantaan yhteyttä ilman sitä (ellet asenna omaa palvelinta).

<tabs>
<tab title="Java, JDBC ja context.xml">

Javalla suosittu tapa tietokantayhteyksien avaamiseen
on käyttää DataSource-tyyppistä tietokantayhteysvarastoa,
joka huolehtii koko sovelluksen yhteyksien ylläpidosta 
ja kierrättämisestä eri aineistopyyntöjen välillä.

Ensiksi pitää kuitenkin määritellä Java-koodin rinnalle context.xml-tiedostoon
tietokantayhteyttä kuvaava resurssi.

**web/META-INF/context.xml**

~~~xml<include src="../viikko1/esimerkit/context.xml" />~~~

Kun resurssi on määritelty, voidaan Javan kirjastoilla hakea
se:

**Yhteysvaraston pystytyskoodi**

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

Kun olet suorittanut haluamasi SQL-kyselyn, yhteys pitää sulkea, 
jolloin se palaa takaisiin varastoon käytettäväksi:

~~~java
try { yhteys.close(); } catch (Exception e) {  }
~~~

Itse varasto-oliota ei tarvitse erikseen sulkea, sillä
Tomcat huolehtii sen hallinnoinnista.

</tab>
<tab title="PHP ja PDO">

Yhteyden avaaminen:

~~~inlinephp
//Yleinen muoto
$tunnus = "kayttajatunnuksesi";
$salasana= "psql-salasana";
$yhteys = new PDO("pgsql:host=localhost;port=5432;dbname=$tunnus", $tunnus, $salasana);
//Seuravaa komento pyytää PDO:ta tuottamaan poikkeuksen aina kun jossain on virhe.
//Kannattaa käyttää, oletuksena luokka ei raportoi virhetiloja juuri mitenkään!
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

Koodatessa PostgreSQL:llä users-palvelimella voidaan käyttää myös lyhyempää yhteysosoitetta:

~~~inlinephp
//Lyhyempi muoto, joka mm. toimii usersin sisällä
$yhteys = new PDO("pgsql:");
$yhteys->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
~~~

</tab>
</tabs>

Tee itsellesi testiluokka/tiedosto, johon sijoitat 
sellaisenaan tietokannan muodostamisen. Koeta
ajaa tiedostosi ja katso muodostuuko yhteys.

Tietokannan nopeaan testaamisen voi käyttää esim. seuraavanlaista koodia:

<sidebyside>
<column>
**Java** 

~~~java
PreparedStatement kysely;
ResultSet tulokset;

String sql = "SELECT 1 as one";
kysely = yhteys.prepareStatement(sql);
tulokset = kysely.executeQuery();

if(tulokset.next()) {
  int ykkonen = tulokset.getInt("one");
  request.setAttribute('tulos', ykkonen)
}

tulokset.close(); kysely.close();
new RequestDispatcher('index.jsp').forward(request, response);
~~~

Koodin pitäisi sijoittaa attribuuttiin `tulos` arvo 1. Jos sijoittaa index.jsp-tiedostoon lauseen `${tulos}`, pitäisi sivulle ilmaantua tuo samainen ykkönen.

</column>
<column>
**PHP** 

~~~inlinephp



$sql = "select 1 as one";
$kysely = $yhteys->prepare($sql);


if ($kysely->execute()) {
  $ykkonen = $kysely->fetchColumn();
  var_dump($ykkonen);
}


~~~

Koodin pitäisi tulostaa seuraava teksti debug-koodaukseen tarkoitettua
[var_dump](http://php.net/manual/en/function.var-dump.php)-funktiota käyttäen:

~~~
int(1)
~~~
</column>
</sidebyside>

Kun olet saanut saanut yhteyden toimimaan ja palauttamaan kannasta tietoa,
laita se omaan metodiinsa, joka palauttaa yhteyden. 
Voit tehdä yhteydelle halutessasi myös oman luokan, johon sijoitat
muitakin toistuvia tietokantaan liittyviä koodinpäktiä.

PHP:llä voidaan käyttää myös lyhyttä funktiota, jossa on funktion sisäinen
[staattinen muuttuja](http://php.net/manual/en/language.variables.scope.php#language.variables.scope.static):

~~~inlinephp
function annaYhteys() {
  static $yhteys = null; //Muuttuja, jonka sisältö säilyy annaYhteys-kutsujen välillä.

  if ($yhteys === null) { 
    //Tämä koodi suoritetaan vain kerran, sillä seuraavilla 
    //funktion suorituskerroilla $yhteys-muuttujassa on sisältöä.
    $yhteys = new PDO('pgsql:');
  }

  return $yhteys;
}

//Funktiota voi käyttää näin
$kysely = annaYhteys()->prepare("SELECT 1");
~~~

PHP:llä koodatessa on tärkeää, että yhteys luodaan vain kerran, sillä sen luominen on verraten hidasta. 
Javalla Tomcat huolehtii tästä, mutta yhteys pitää erikseen sulkea.
Javaa käyttäessä sinun kannattaa siis tehdä myös apumetodi, joka sulkee yhteyden.

## Java ja tietokanta-ajurin lisääminen

Java-koodarit huomio! Joudut todennäköisimmin tässä vaiheessa lisäämään projektiisi 
PostgreSQL-kannan ajurikirjaston.
NetBeansia käyttäessäsi tämä hoituu samasta kohtaa, kuin JSTL-kirjaston lisääminen:
avaa valikosta `File->Project Properties`,
paina _Libraries_-kategoriassa nappia _Add Library_ ja 
lisää listasta projektiin kirjasto nimeltä `PostgreSQL JDBC Driver`.

![PostgreSQL-ajurin asennus]({{myimgdir}}postgres-ajuri.png)

Samanlaiset huomiot koskevat MySQL-tietokantaa.

## Salasanojen tallentaminen ja GitHub

Yksityiseksi tarkoitettujen salasanojen tallentaminen
versionhallintaan ei ole ikinä kovin hyvä idea.
Salasanoja sisältäviä tiedostoja ei useimmiten kuitenkaan
kannata jättää versionhallinnasta poiskaan, sillä useimmiten niihin sisältyy 
muutakin oleellista informaatiota projektista.

Yksinkertainen ja hyvin yleisesti käytetty tapa hoitaa ongelma, on 
luoda tarvittava salasanan sisältävä tiedosto kahdesti:
ensiksi normaalina tiedostona, jossa on salasana, mutta jota ei laiteta versionhallintaan
ja sitten salasanattomana .dist-tiedostopäätteellisenä versiona, joka laitetaan versionhallintaan.

Esimerkiksi Javalla koodatessa voidaan tiedosto `web/META-INF/context.xml` 
sijoittaa `.gitignore`-tiedostoon siten, ettei se mene versionhallintaan
ja sensijaan tehdä tiedostosta kopio, `web/META-INF/context.xml.dist`,
joka on muuten samanlainen kuin alkuperäinen `context.xml`, mutta ei sisällä salasanaa,
eikä ole mainittu `.gitignore` tiedossa. 

Näin repositorion kloonannut pystyy kopioimaan tiedoston paikalleen ja 
laittamaan siihen tarvittavan salasanan käsin.

<alert>
Kun käytät `.dist`-päätteisiä tiedostoja, laita dokumentaation asennusohjeisiin maininta niiden sijainnista
ja siitä mitä niihin pitää sijoittaa ohjelman käyttämiseksi.
</alert>
