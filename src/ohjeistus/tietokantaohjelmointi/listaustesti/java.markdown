% Listaus Javalla

<wip />

Varmista ensin, että sinulla on luokka tai funktio, jolla saat [yhteyden tietokantaan](../tietokantayhteys/index.html).
Nyt käytämme tietokantayhteyttä luokaksemme hyvin yksinkertaisen sivun, jolla listataan jonkun taulun sisältöä.
Teemme tämän kahdessa vaiheessa: 
Ensin luomme yksinkertaisen sivun, joka näyttää listan asioista
sitten luomme koodin, joka hakee tuon listan tietokannasta.

## Asioiden listaaminen

Tarkempien ohjeiden puuttuessa näkymien toteutuksen esimerkkikoodia voi noukkia
[viikon 3 materiaaleista]({{rootdir}}aikataulu/viikko3/java/rakenne.html).

## Tietokannan käyttö


Esimerkki metodista joka hakee kaikki käyttäjät kannasta.

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

<vinkki title="Hyvä tietää">
Tällä viikolla tehtävä listaus on tahallaan melko yksinkertainen, sillä tarkoitus on vain testata tietokantaohjelmointia.
Lopulliset sivut tulevat noudattamaan läheisemmin [MVC-arkkitehtuuria][mvc].
</vinkki>
[mvc]: {{rootdir}}ohjeistus/arkkitehtuuri/index.html
