% Malliluokat ja tiedon muuttaminen
<comment>% Malliluokat II: tiedon muuttaminen</comment>
<!-- order: 6 -->

<wip />

<summary>
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille. Tähän käytetään PDO:n tai Javan JDBC:n prepared statements -tukia.
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause).
* Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen
* samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.

</summary>


## Turvallinen tietokantaohjelmointi

Olennainen osa järkevää tietokantaohjelmointia
on nk. [SQL-injektioiden](http://fi.wikipedia.org/wiki/SQL-injektio) välttäminen.

Sovellukseen on mahdollista tehdä SQL-injektio silloin, kun käyttäjän
antamia syötteitä ei tarkisteta kunnolla vaan ne upotetaan SQL-kyselyihin sellaisinaan.
Esimerkki PHP:llä:

~~~inlinephp
$nimi = $_POST['nimi'];

$yhteys = Tietokanta::getYhteys();
$kysely = $yhteys->prepare("SELECT * FROM users WHERE nimi = '$nimi'");
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

Sekä PHP:ssä että Javassa parametrien paikkoja ilmaistaan kysymysmerkeillä.
Kielien tapa syöttää kyselylle parametrejä on hieman erilainen:
PHP:llä parametrit annetaan array-tyyppisenä listana [kyselyä suoritettaessa](http://php.net/manual/en/pdostatement.execute.php)
Java:lla ne asetetaan kyselylle jokainen erikseen erilaisilla metodikutsuilla. Joka tyypille on omansa, esim. merkkijonoille
[setString](http://docs.oracle.com/javase/7/docs/api/java/sql/PreparedStatement.html#setString(int, java.lang.String)).
Huomaa, että Javalla kyselyn parametrien indeksointi alkaa ykkösestä.

<sidebyside>
<column>

**PHP** 

~~~inlinephp
$nimi = $_POST['nimi'];
$yhteys = Tietokanta::getYhteys();

//Etsitään käyttäjää nimellä
$sql = "SELECT * FROM users WHERE nimi = ?";
$kysely = $yhteys->prepare($sql);

//Annetaan yksi parametri array:n sisällä
$tulokset = $kysely->execute(array($nimi));
~~~

</column>
<column>

**Java** 

~~~java
Connection yhteys = null;
PreparedStatement kysely = null;
ResultSet tulokset = null;

String nimi = request.getParameter("nimi");
yhteys = TietokantaYhteydet.getYhteys();

//Etsitään käyttäjää nimellä
String sql = "SELECT * FROM users WHERE nimi = ?";
kysely = yhteys.prepareStatement(sql);

//Annetaan yksi parametri array:n sisällä
kysely.setString(1, nimi);
tulokset = kysely.executeQuery();
~~~

</column>
</sidebyside>

## Mallien rakentaminen

* Tähän on olemassa monia tapoja.
* Selkeä: Joka tietokantataululle oma luokkansa.
    * Jokainen olio edustaa yhtä taulunsa riviä.
    * Poikkeus: liitostauluille ei välttämättä tarvita omaa luokkaansa, mikäli niiden toiminnot voi loogisesti sijoittaa muihinkin luokkiin.
* Luokalla staattisia metodeja, joilla voi hakea olioita eli rivejä kannasta.
    * Voi tehdä myös instassimetodeja, jotka hakevat johonkin olioon liittyviä rivejä toisista tietokantatauluista.
* Tarvitaan myös metodit, joka syöttävät olion kantaan tai päivittävät kannassa olevia tietoja olion perusteella.
    * Näitä mahdollista tehdä ilman oliotakin.
    * Voivat olla staattisia tai instassimetodeja.
* Lopuksi metodi(t), jolla voi poistaa rivejä.
    * Instanssimetodi poistaa kyseisen olion kannasta.
    * Staattisella metodilla voi poistaa useitakin olioita.

### Olion syöttäminen kantaan

* Autogeneroituja id-numeroita (esim. PostgreSQL:n [SERIAL-tietotyyppi](http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL)) varten
olemassa omat kikkansa:
    * PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
    * MySQL:llä olemassa PHP:llä PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php).
    * Javalle olemassa [vastaava tekniikka](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).
    * SERIAL-tyyppiä käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.

<comment>
# Tietojen päivittäminen ja poistaminen



<next>
Kun malli on toteutettu, sitä voi käyttää [näkymissä](nakymat.html).
</next>
</comment>
