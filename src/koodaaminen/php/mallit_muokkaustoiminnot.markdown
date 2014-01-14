% Malliluokat ja tiedon muuttaminen
<!-- order: 6 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta.

<summary>
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause), sekä metodit, joilla tarkistetaan ovatko syötettävät arvot oikeanlaisia.
* Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen
* samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.
</summary>

## Tietojen syöttäminen olioon

Paras tapa toteuttaa jonkin tietokohteen olion, esimerkiksi kissan, syöttäminen tietokantaan, on tehdä siitä oliopohjaista:
Ensiksi luodaan kissaolio, jonka jälkeen asetetaan sille 
settereillä sopivat arvot. 
Kun olio on luotu, kutsutaan varta vasten tätä tarkoitusta varten
tehtyä metodia, joka lisää olion kantaan. Mallia kutsuva koodi voisi näyttää seuraavanlaiselta:

~~~inlinephp
$uusikatti = new Kissa();
$uusikatti->setNimi($_POST['nimi']);
$uusikatti->setVari($_POST['vari']);
$uusikatti->setRotuId($_POST['rotu_id']);

//Pyydetään Kissa-oliota tarkastamaan syötetyt tiedot.
if ($uusikatti->onkoKelvollinen()) {
  $uusikatti->lisaaKantaan();
  
  //Kissa lisättiin kantaan onnistuneesti, lähetetään käyttäjä eteenpäin
  header('Location: kissalista.php');
  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty.
  //Tästä tekniikasta kerrotaan lisää seuraavalla sivulla
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
  public function setVari($uusivari) {
    $this->vari = $uusivari;

    if (trim($this->vari) == '') {
      $this->virheet['vari'] = "Kissalla on oltava väri.";
    } else { 
      unset($this->virheet['vari']);
    }
  }
  public function setRotuId($uusirotu_id) {
    $this->rotu_id = $uusirotu_id;
    
    //Tarkistetaan, että rotu on olemassa
    if (Kissarotu::etsi($uusirotu_id) == null) {
      $this->rotu_id = null;
    }

    if ($this->rotu_id == null) {
      $this->virheet['rotu_id'] = "Kissan rotua ei löytynyt tietokannasta";
    } else { 
      unset($this->virheet['rotu_id']);
    }
  }

  /* Palauttaa true, jos Kissaan syötetyt arvot ovat järkeviä. */
  public function onkoKelvollinen() {
    return empty($this->virheet);
  }
  public function getVirheet() {
    return this->virheet;
  }
~~~

Huomaa toiseen tauluun viittaavan tiedon setterissä (`setRotuId`)
oleva toista mallia käyttävä tietokantahaku, joka tarkistaa,
että viitattu tieto on olemassa. 

Mallien välinen viittailu on myös mahdollista
rakentaa siten, että sille voidaan antaa setterissä toisen taulun 
olioita, joista poimitaan id.

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
    $kysely = getTietokanta()->prepare($sql);

    $ok = $kysely->execute(array($this->getNimi(), $this->getVari(), $this->getRotuId()));
    if ($ok) {
      //Haetaan RETURNING-määreen palauttama id.
      //HUOM! Tämä toimii ainoastaan PostgreSQL-kannalla!
      $this->id = $kysely->fetchColumn();
    }
    return $ok;
  }
~~~

## Muokkauksen toteuttaminen

Tämä tapahtuu pitkälti samalla tavalla kuin tiedon lisääminen.
Toteutukseessa on järkevää käyttää samaa tietojen kelpoisuuden tarkistamismekanismia, kuin lisäämisen kanssa.

## Muuta

* Luokalla voi olla staattisia metodeja, joilla voi hakea olioita eli rivejä kannasta.
    * Voi tehdä myös instassimetodeja, jotka hakevat johonkin olioon liittyviä rivejä toisista tietokantatauluista.
* Tarvitaan myös metodi(t), jolla voi poistaa rivejä.
    * Instanssimetodi poistaa kyseisen olion kannasta.
    * Staattisella metodilla voi poistaa useitakin olioita.


<next>
Kun malli on toteutettu, sitä voi käyttää 
[muokkaus- ja lisäyslomakkeiden tekemiseen](muokkausnakymat.html).
</next>
