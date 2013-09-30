% Tietokantayhteyden pystytys
<!-- order: 1 -->

<summary>
* Varmista että aikaisemmin kirjoittamasi SQL-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Tietokantayhteyden luonti.
    * Luominen pitää sijoittaa omaan tiedostoonsa/luokkaansa, josta muut tiedostot sitä käyttävät.
    * Java-kielen NetBeans-ohjeita käyttäneille tarpeen on myös: [PostgreSQL-ssh-tunnelin luonti](ssh-tunnelit.html). 
      Sama pätee kaikkiin projekteihin, joissa käytetään users:in tietokantaa etänä.
    * Tietokantaa kannattaa tässä vaiheessa testata jollain hyvin yksinkertaisella testikoodilla.
* Javalla tietokantayhteydet pitää vielä sulkea aineistopyynnön käsittelyn lopuksi
    * Tätä varten kannattaa tehdä oma metodi
    * Kutsu metodia servletistä käsin vasta sitten, kun kaikki tietokantakutsut on tehty. 
        * Tietokantayhteyttä ei kannata avata ja sulkea monta kertaa per aineistopyyntö. Yhteyksien availu ja sulkeminen on usein varsin hidasta.
    * PHP:llä sulkemisesta ei tarvitse huolehtia, sillä kieli sulkee yhteyden automaattisesti skriptin suorituksen lopuksi. 
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
<tab title="Java ja JDBC">

Yhteyden avaaminen:

~~~java
Connection yhteys = null;
final String tunnus = "kayttajatunnuksesi";
final String salasana = "psql-salasana";

try {
  //Etsitään mysql-ajuri ja otetaan yhteys tietokantaan
  Class.forName("jdbc:postgresql://localhost:5432/");
  yhteys = DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+tunnus,tunnus,salasana);
} catch (Exception e) {
  throw e;
} 
~~~

Kun olet suorittanut kaikki haluamasi SQL-kyselyt, yhteys pitää sulkea:

~~~java
try { yhteys.close(); } catch (Exception e) {  }
~~~


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
  System.out.println(ykkonen);
}

tulokset.close(); kysely.close();
~~~

Voit käyttää System.out:in sijaan JSP:tä ja sopivia attribuutteja.
Koodin pitäisi tulostaa seuraava teksti:

~~~
1
~~~
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
laita se omaan tiedostoonsa ja luokkaansa, johon lisäät kentän yhteyttä varten
ja metodin, joka palauttaa yhteyden. 

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

Pääasia on, että yhteys luodaan vain kerran, sillä sen luominen on 
verraten hidasta. 
Javalla sinun kannattaa tehdä luokkaasi myös metodi, joka sulkee yhteyden.

Javaa käytettäessä toimi niin, että alustat tietokantayhteyden tietokantaluokkaasi käyttäen
servletin käsittelijäkoodissa ja suljet sen aivan tuon koodin suorituksen lopuksi.
Tietokantayhteyden säilyttämiseen ei Javalla kannata käyttää staattisia 
kenttiä, sillä ne ovat Tomcat-sovellksissa koko sovelluksen yhteisiä, jolloin törmätään nopeasti samanaikaisusongelmiin.

## Java ja tietokanta-ajurin lisääminen

Java-koodarit huomio! Joudut todennäköisimmin tässä vaiheessa lisäämään projektiisi 
PostgreSQL-kannan ajurikirjaston.
NetBeansia käyttäessäsi tämä hoituu samasta kohtaa, kuin JSTL-kirjaston lisääminen:
avaa valikosta `File->Project Properties`,
paina _Libraries_-kategoriassa nappia _Add Library_ ja 
lisää listasta projektiin kirjasto nimeltä `PostgreSQL JDBC Driver`.

![PostgreSQL-ajurin asennus]({{myimgdir}}postgres-ajuri.png)

<next>
Seuravaaksi laitamme malliluokan [käyttämään tietokantaa](mallit.markdown).
</next>
