% Mallit ja tietokanta
<!-- order: 3 -->

<wip />

<summary>
* Käytännössä jokaista tietokohdetta vastaa yksi malliluokka.
    * Puhtaille välitauluille harvemmin tarvitaan omaa luokkaansa, vaan niiden toiminnot hoidetaan itse tietokohteiden kautta.
    * Luokka sisältää tarvittavat metodit.
    * Käytetään sekä instanssimetodeja, että staattisia metodeja.
        * Instanssimetodit käsittelevät yksittäiseen taulun riviin liittyvää tietoa.
        * Staattiset metodit hakevat kannasta olioita sekä päivittävät tai poistavat kannasta useita olioita kerralla.
        * Oliolla kannattaa yleensä olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause).
        * Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen, samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille. Tähän käytetään PDO:n ja javan JDBC:n prepared statements -tukia.

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
Kielien 

Esimerkki:

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
kysely.setString(1, "Lehtonen");
tulokset = kysely.executeQuery();
~~~

</column>
</sidebyside>

### Olion syöttäminen kantaan

* Autogeneroituja id-numeroita (esim. PostgreSQL:n [SERIAL-tietotyyppi](http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL)) varten
olemassa omat kikkansa:
    * PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
    * MySQL:llä olemassa PHP:llä PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php).
    * Javalle olemassa [vastaava tekniikka](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).
    * SERIAL-tyyppiä käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.


<comment>
## Staattisia ja instanssimetodeja

<wip />
</comment>

<next>
Kun malli on toteutettu, sitä voi käyttää [näkymissä](nakymat.html).
</next>
