% Tietokantahaku ja kyselyn parametrit
<!-- order: 4 -->

<summary>
* Lisätään aiemmin tehtyyn malliluokkaan haeKayttajaTunnuksilla-metodi.
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille. Tähän käytetään PDO:n *prepared statements* -tukia.
</summary>

Jotta sovellukseen voi kirjautua muillakin kuin yhdellä tunnuksella,
pitää kirjautumisen taustalle tehdä oikea tietokantaa käyttävä
malli, jolta voidaan kysyä ovatko käyttäjän antamat tunnukset oikeita.

## Turvallinen tietokantaohjelmointi

Olennainen osa järkevää tietokantaohjelmointia
on nk. [SQL-injektioiden](http://fi.wikipedia.org/wiki/SQL-injektio) välttäminen.

Sovellukseen on mahdollista tehdä SQL-injektio silloin, kun käyttäjän
antamia syötteitä ei tarkisteta kunnolla vaan ne upotetaan SQL-kyselyihin sellaisinaan.

**Esimerkki:**

~~~java
Connection yhteys = Tietokanta.getYhteys();
String nimi = request.getParameter("nimi");

//Etsitään käyttäjää nimellä
String sql = "SELECT * FROM users WHERE nimi = '"+nimi+"' LIMIT 1";
PreparedStatement kysely = yhteys.prepareStatement(sql);
ResultSet tulokset = kysely.executeQuery();
~~~

Nyt, mikäli nimeksi annetaankin vaikka merkkijono `' OR username = 'admin'`,
hakeekin kysely kannasta aivan eri käyttäjän kuin pitäisi!

Jos tälläinen virhe eksyy vaikkapa kirjautumislogiikkaan, on sovellus auttamatta haavoittuvainen murtautumisyrityksille.

Onneksi sekä PHP:llä että Javalla on olemassa hyvin helppokäyttöinen tapa
estää tälläisiä kyselyjä menemästä kantaan:
[Prepared statementit](http://en.wikipedia.org/wiki/Prepared_statement)
eli kankeasti suomennettuna esivalmistellut SQL-lauseet 
ovat ratkaisu ongelmaan.

Käytännössä kyseessä on tietokannalle etukäteen lähetetty 
SQL-kielinen kysely, johon on upotettu paikkoja parametreille.
Näiden parametrien paikalle voi sitten upottaa haluamiaan arvoja.

Näitä parametrien paikkoja ilmaistaan kysymysmerkeillä.
Java:lla parametrit ne asetetaan kyselylle jokainen erikseen erilaisilla metodikutsuilla. Joka tyypille on omansa, esim. merkkijonoille
[setString](http://docs.oracle.com/javase/7/docs/api/java/sql/PreparedStatement.html#setString(int, java.lang.String)).
Huomaa, että kyselyn parametrien indeksointi alkaa ykkösestä.

**Esimerkki** 

~~~java
Connection yhteys = null;
PreparedStatement kysely = null;
ResultSet tulokset = null;

String nimi = request.getParameter("nimi");
yhteys = Tietokanta.getYhteys()();

//Etsitään käyttäjää nimellä
String sql = "SELECT * FROM users WHERE nimi = ?";
kysely = yhteys.prepareStatement(sql);

//Annetaan yksi parametri array:n sisällä
kysely.setString(1, nimi);
tulokset = kysely.executeQuery();
~~~

## Yksittäisen käyttäjän hakeminen kannasta

Tehdään aiemmin tehtyyn käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se palauttaa käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa voidaan käyttää myös myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

**Ote tiedostosta kissalista/models/Kayttajat.java:**

~~~java
public static Kayttaja getKayttajaTunnuksilla(String kayttaja, String salasana) {
  String sql = "SELECT id,username, password from users where username = ? AND password = ?";
  Connection yhteys = Tietokanta.getYhteys();
  PreparedStatement kysely = yhteys.prepareStatement(sql);
  kysely.setString(1, kayttaja);
  kysely.setString(2, salasana);
  ResultSet rs = kysely.executeQuery();
  
  //Alustetaan muuttuja, joka sisältää löydetyn käyttäjän
  Kayttaja kirjautunut = null;

  //next-metodia on kutsuttava aina, kun käsitellään vasta kannasta saatuja ResultSet-olioita.
  //ResultSet on oletuksena ensimmäistä edeltävällä -1:llä rivillä.
  //Kun sitä kutsuu ensimmäisen kerran siirtyy se ensimmäiselle riville 0.
  //Samalla metodi myös palauttaa tiedon siitä onko seuraavaa riviä olemassa.
  if (rs.next()) { 
    //Kutsutaan sopivat tiedot vastaanottavaa konstruktoria ja asetetaan palautettava olio:
    kirjautunut = new Kayttaja(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
  }

  //Jos kysely ei tuottanut tuloksia käyttäjä on nyt vielä null.

  //Suljetaan kaikki resurssit:
  try { rs.close(); } catch (Exception e) {}
  try { kysely.close(); } catch (Exception e) {}
  try { yhteys.close(); } catch (Exception e) {}
  
  //Käyttäjä palautetaan vasta täällä, kun resurssit on suljettu onnistuneesti.
  return kirjautunut;
}
~~~

Tee omaan malliluokkaasi vastaava metodi ja laita kirjautumislomakkeesi käyttämään sitä. Testaa toimiiko kaikki oikein.

<next>

Seuraavaksi käytämme istuntoja [kirjautumisen tallentamiseen sivulatausten välillä](istunnot.html).

</next>
