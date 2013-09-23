% Viikko 4
<!-- order: 1 -->

<deadline>{{deadline4}}</deadline>

Työaiheet neljännellä viikolla lyhyesti:

**Tietokannan kokeilu ja yhteydenotto**

* Varmista että aikaisemmin kirjoittamasi sql-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa.
* Tietokantayhteyden luonti.
    * Luominen pitää sijoittaa omaan tiedostoonsa/luokkaansa, josta muut tiedostot sitä käyttävät.
    * Javalle NetBeans-ohjeita käyttäneille hyödyllistä on myös: [PostgreSQL-ssh-tunnelin luonti](http://www.postgresql.org/docs/8.2/static/ssh-tunnels.html).
        * Windowsilla ssh-tunnelin saa aikaan Puttyllä.
    * Tietokantaa kannattaa tässä vaiheessa testata jollain hyvin yksinkertaisella testikoodilla.
* Javalla tietokantayhteydet pitää vielä sulkea aineistopyynnön käsittelyn lopuksi
    * Tätä varten kannattaa tehdä oma metodi
    * Kutsu metodia servletistä käsin vasta sitten, kun kaikki tietokantakutsut on tehty. 
        * Tietokantayhteyttä ei kannata avata ja sulkea monta kertaa per aineistopyyntö. Yhteyksien availu ja sulkeminen on usein varsin hidasta.
    * PHP:llä asiasta ei tarvitse huolehtia, sillä kieli sulkee yhteyden automaattisesti skriptin suorituksen lopuksi. 

**Tietokantaa käyttävän mallin luominen**

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

**Lomakkeiden ja sivujen toteuttaminen**

* Lisäys- ja muokkauslomakkeet kannattaa toteuttaa samalla tai ainakin hyvin samanlaisella koodilla.
* Muokkaustoiminnot kannattaa toteuttaa niin, että sivun käsittelijä ottaa muokattavan tietokohteen id:n tai muun avaimen GET-parametrina ja näyttää sen perusteella oikean kohteen.
    * Poisto ym. vastaavat toiminnot toimivat käytännössä samoin. Usein niiden aktivointii kannattaa tosin käyttää lomakkeisiin upotettuja nappeja ja POST-metodia.
* Muokkauslomake koodataan näyttämään GET-parametrin määrittämän olion tiedot valmiina kentissä. 
    * Olio haetaan mallilta sopivalla metodilla.
    * Malli ei koskaan käsittele GET- tai POST-parametreja suoraan vaan ne käsittelijä välittää ne mallin metodeille.
* Lomakkeen käsittelijä ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään vielä virheilmoituksin. Mieluiten kaikki kerrallaan.
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
    * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`

<comment>
Tehdään koko setti:
  Listaus
  Tietosivu
  Lomake
    Lisäys
    Muokkaus
    Käytettävyys!!
  Poisto
</comment>

## Nelosviikon deadline

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset:

* Tietokantayhteys toimii, ja sen luonti on sijoitettu omaan metodiinsa/funktioonsa.
* Luotu ainakin yksi malliluokka, joka:
    1. Sisältää staattisia metodeja, jotka hakevat kannasta eri kriteerein rivejä olioiksi. (Esim. kissalistan hakutoiminto, yksittäisen kissan hakeminen id-numerolla yms.)
    2. Sisältää metodin, joka lisää olion kantaan (INSERT-lause).
    3. Sisältää metodin, joka päivittää olion tiedot kantaan (UPDATE-lause).
    4. Sisältää metodin joka poistaa olion kannasta, voidaan toteuttaa myös staattinen metodi, joka poistaa hakuehdolla rivejä taulusta.
* Käytetty SQL-koodi on turvallinen, eikä tarjoa mahdollisuuksia SQL-injektioille.
* Luotu sivut, jossa edellä mainittuja malliluokan toimintoja käytetään hyväksi. Käytettävyyden pitää olla kohdallaan:
    * Sivuilla selkeät virheilmoitukset kaikista virhetilanteista ja lomakkeiden syöttövirheistä.
    * Lomakkeen käsittelijä ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
        * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Väärin syötetyt tiedot kerrotaan virheilmoituksin.
    * Tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms.

<comment>
<ohje>
Aloita [tästä](404.html) ja seuraa vihreitä ohjelaatikoita.

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>
</comment>
