% Tietojen syöttäminen kantaan
<!-- order: 7 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta. Samat suunitteluperiaatteet pätevät kuitenkin kummallakin kielellä.

<summary>
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause), sekä metodit, joilla tarkistetaan ovatko syötettävät arvot oikeanlaisia.
* Lomakkeen kontrolleri ohjaa takaisin esitäytetylle lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään virheilmoituksin. 
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
    * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`
* Lomake ohjaa lisäyksen onnistuessa selaimen listaussivulle.
  * Onnistumisesta onnistumisviesti
</summary>

## Tietojen syöttäminen olioon

Paras tapa toteuttaa jonkin tietokohteen olion, esimerkiksi kissan, syöttäminen tietokantaan, on tehdä siitä oliopohjaista:
Ensiksi luodaan kissaolio, jonka jälkeen asetetaan sille 
settereillä sopivat arvot. 
Kun olio on luotu, kutsutaan varta vasten tätä tarkoitusta varten
tehtyä metodia, joka lisää olion kantaan. Mallia kutsuva koodi voisi näyttää seuraavanlaiselta:

**Esimerkki lisäyskontrollerista**

~~~php
<?php
$uusikatti = new Kissa();
$uusikatti->setNimi($_POST['nimi']);
$uusikatti->setVari($_POST['vari']);
$uusikatti->setRotuId($_POST['rotu_id']);

//Pyydetään Kissa-oliota tarkastamaan syötetyt tiedot.
if ($uusikatti->onkoKelvollinen()) {
  $uusikatti->lisaaKantaan();
} else {
  $virheet = $uusikatti->getVirheet();
}
~~~

Huomaa käytetyt metodi `onkoKelvollinen` ja `getVirheet`, joista
ensimmäinen kertoo, ovatko olioon asetetut tiedot tiedot oikeat ja
jälkimmäinen palauttaa kaikki olion tietoihin liittyvät virheet.

Etenkin jälkimmäisen toteuttamisesta on paljon hyötyä lisäyslomakkeen
virheviestien toteuttamisessa.

Nämä metodit voi toteuttaa käytännössä kahdella tavalla riippuen siitä
missä tarkistuksen haluaa tehdä:

1. Laitetaan tarkistukset suoraan settereihin ja pidetään jatkuvasti yllä
   tietorakennetta siitä mitkä tiedot ovat kelvollisia. 
2. Laitetaan tarkistukset `onkoKelvollinen`-metodiin ja tarkistetaan 
   kaikki kentät kerralla.

Ensimmäinen toteutustapa on usein selkeämpi, sillä yhtä kenttää koskevat
toiminnot pysyvät yhdessä paikassa, mutta jälkimmäisellä tavalla on joskus
mahdollista automatisoida toistuvia tarkistuksia hieman paremmin
laittamalla toisteista koodia luuppeihin.

Alla esimerkki siitä miten virheentarkistuksen voi toteuttaa
settereillä, jotka muokkaavat privaattikentäksi määriteltyä virhetaulukkoa.

~~~inlinephp
class Kissa {
  private $virheet = array();

  public function setNimi($uusinimi) {
    $this->nimi = $uusinimi;

    if (trim($this->nimi) == '') {
      $this->virheet['nimi'] = "Nimi ei saa olla tyhjä.";
    } else { 
      unset($this->virheet['nimi']);
    }
  }
  
  ...
~~~

Kentissä, jotka viittaavat toisiin tauluihin, voi olla 
järkevää tehdä tarkistuksia siitä onko viitattu olento olemassa.
Tämän voi helposti tehdä tekemällä viitattuun tauluun sopivan
hakumetodin, jolla voi hakea tietueita pääavaimen perusteella: 

~~~inlinephp
  //Tarkistetaan, että rotu on olemassa
  if (Kissarotu::etsi($uusirotu_id) == null) {
    $this->virheet['rotu_id'] = "Kissan rotua ei löytynyt tietokannasta";
  } else { 
    unset($this->virheet['rotu_id']);
  }
~~~

Mallien välinen viittailu on myös mahdollista
rakentaa siten, että sille voidaan antaa setterissä toisen taulun 
olioita, joista poimitaan id.

onkoKelvollinen-metodin toteutukseksi riittää käytetyn virhelistan
tyhjyyden tarkistava [`empty`](http://www.php.net/empty):

~~~inlinephp
  /* Palauttaa true, jos Kissaan syötetyt arvot ovat järkeviä. */
  public function onkoKelvollinen() {
    return empty($this->virheet);
  }
~~~

### Olion syöttäminen kantaan

* Autogeneroituja id-numeroita (esim. PostgreSQL:n [SERIAL-tietotyyppi](http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL)) varten
olemassa omat kikkansa:
    * PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
    * MySQL:llä olemassa PHP:llä PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php).
    * Javalle olemassa [vastaava tekniikka](http://www.technicalkeeda.com/details/how-to-get-mysql-auto-increment-key-value-using-java-jdbc).
    * SERIAL-tyyppiä käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.

**Esimerkkikoodia:**

~~~inlinephp
  public function lisaaKantaan() {
    $sql = "INSERT INTO Kissat(nimi, vari, rotu_id) VALUES(?,?,?) RETURNING id";
    $kysely = getTietokantayhteys()->prepare($sql);

    $ok = $kysely->execute(array($this->getNimi(), $this->getVari(), $this->getRotuId()));
    if ($ok) {
      //Haetaan RETURNING-määreen palauttama id.
      //HUOM! Tämä toimii ainoastaan PostgreSQL-kannalla!
      $this->id = $kysely->fetchColumn();
    }
    return $ok;
  }
~~~

## Käytettävä lisäyslomake

* Lomakkeen kontrolleri ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään vielä virheilmoituksin. Mieluiten kaikki kerrallaan.
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
    * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`
* Lomake ohjaa lisäyksen onnistuessa selaimen listaussivulle.
  * Onnistumisesta onnistumisviesti

~~~inlinephp
if ($uusikatti->onkoKelvollinen()) {
  $uusikatti->lisaaKantaan();
  //Kissa lisättiin kantaan onnistuneesti, lähetetään käyttäjä eteenpäin
  header('Location: kissalista.php');
  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty.
  //Tästä tekniikasta kerrotaan lisää kohta
  $_SESSION['ilmoitus'] = "Kissa lisätty onnistuneesti.";
} else {
  $virheet = $uusikatti->getVirheet();

  //Virheet voidaan nyt välittää näkymälle syötettyjen tietojen kera
  naytaNakymä("kissalomake", array(
    'kissa' => $uusikatti,
    'virheet' => $virheet
  ));
}
~~~

### Istunnon käyttäminen ilmoitusten ja virheiden näyttämiseen

Lyhyt esimerkki, selitykset tulossa:

**Kontrollerissa**

~~~inlinephp
  $uusikatti->lisaaKantaan();
  
  //Äsken lisättiin kantaan onnistuneesti kissa,
  //lähetetään käyttäjä eteenpäin listasivulle:
  header('Location: kissalista.php');
  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty:
  $_SESSION['ilmoitus'] = "Kissa lisätty onnistuneesti.";
~~~

**Näkymien pohjatiedostossa**

~~~php
<?php if (!empty($_SESSION['ilmoitus'])): ?>
<?php
  // Samalla kun viesti näytetään, se poistetaan istunnosta,
  // ettei se näkyisi myöhemmin jollain toisella sivulla uudestaan.
  unset($_SESSION['ilmoitus']); 
?>
  <div class="alert alert-danger">
    <?php echo $_SESSION['ilmoitus']; ?>
  </div>
<?php endif; ?>
~~~


## Muuta

* Luokalla voi olla staattisia metodeja, joilla voi hakea olioita eli rivejä kannasta.
    * Voi tehdä myös instassimetodeja, jotka hakevat johonkin olioon liittyviä rivejä toisista tietokantatauluista.

<next>
Kun lisäys on toteutettu, sen pohjalta voidaan toteuttaa myös
[muokkauslomake](muokkausnakymat.html).
</next>
