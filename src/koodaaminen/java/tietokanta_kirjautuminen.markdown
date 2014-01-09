% Tietokannan käytön alkeet
<!-- order: 4 -->

Tehdään nyt aiemmin tehtyyn käyttäjää mallintavaan luokkaan staattinen metodi
käyttäjän hakemiseen käyttäjätunnuksella ja salasanalla. Käytä tätä
metodia kirjautumisen toteuttamiseen. 

Metodi kannattaa toteuttaa sellaisen SQL-kyselyn ympärille, joka 
hakee kannasta tietoja salasanan ja käyttäjänimen perusteella.
Se palauttaa käyttäjäluokan olion,
jolloin siitä on järkevää tehdä luokan staattinen metodi.

Palautettua arvoa käytetään myöhemmin kirjautuneen käyttäjän tallentamiseen istuntoon.

**Ote tiedostosta kissalista/models/Kayttajat.java:**

~~~java
public static Kayttaja getKayttajaTunnuksilla(String kayttaja, String salasana) {
  String sql = "SELECT id,username, password from users where username = ? AND password = ?";
  Connection yhteys = Tietokanta.getTietokanta();
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
