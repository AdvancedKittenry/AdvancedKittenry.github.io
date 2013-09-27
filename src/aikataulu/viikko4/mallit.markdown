% Mallit ja tietokanta
<!-- order: 3 -->

<wip />

* Käytännössä jokaista tietokohdetta vastaa yksi malliluokka.
    * Puhtaille välitauluille harvemmin tarvitaan omaa luokkaansa, vaan niiden toiminnot hoidetaan tietokohteiden kautta.
    * Luokka sisältää tarvittavat metodit.
    * Käytetään sekä instanssimetodeja, että staattisia metodeja.
        * Instanssimetodit käsittelevät yksittäiseen taulun riviin liittyvää tietoa.
        * Staattiset metodit hakevat kannasta olioita sekä päivittävät tai poistavat kannasta useita olioita kerralla.
        * Oliolla kannattaa yleensä olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause).
            * Autogeneroituja id-numeroita (esim. PostgreSQL:n [SERIAL-tietotyyppi](http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL)) varten
              olemassa omat rajapintansa:
                * PHP:llä PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php).
                * Javalle olemassa [vastaava tekniikka](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).
                * SERIAL-tyyppiä käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.
        * Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen, samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille.
    * Tähän käytetään PDO:n ja javan JDBC:n prepared statements -tukia.
    * Kyselyihin upotetaan parametreja laittamalla SQL-komentojen sekaan kysymysmerkkejä, joiden sisällön voi täyttää ohjelmallisesti.
        * [Lyhyt esimerkki PDO:n ja JDBC:n käytöstä](../viikko1/ohjelmointikielet.html#tietokannan-käyttö)

<next>
Kun malli on toteutettu, sitä voi käyttää [näkymissä](nakymat.html).
</next>
