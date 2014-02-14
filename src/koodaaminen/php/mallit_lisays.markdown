% Tietojen syöttäminen kantaan
<!-- order: 9 -->

<summary>
* Malliluokan oliolla kannattaa olla metodi, jolla se osaa syöttää itsensä kantaan (INSERT-lause), sekä metodit, joilla tarkistetaan ovatko syötettävät arvot oikeanlaisia.
* Lomakkeen kontrolleri ohjaa takaisin esitäytetylle lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään virheilmoituksin. 
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
* Jos lomakkeessa käsitellään viiteavaimia, käytä [SELECT-tägiä](#selecttag)
* Lomake ohjaa lisäyksen onnistuessa selaimen listaussivulle.
  * Onnistumisesta onnistumisviesti
  * Viesti kannattaa välittää [istunnossa](#sessionmessages)
</summary>

## Tietojen syöttäminen malliluokan olioon

Paras tapa toteuttaa jonkin tietokohteen olion, esimerkiksi kissan, syöttäminen tietokantaan, on tehdä siitä oliopohjaista:
Ensiksi luodaan kissaolio, jonka jälkeen asetetaan sille 
settereillä sopivat arvot. 

**Esimerkki lisäyskontrollerin alusta**

~~~php
<?php
$uusikatti = new Kissa();
$uusikatti->setNimi($_POST['nimi']);
$uusikatti->setVari($_POST['vari']);
$uusikatti->setRotuId($_POST['rotu_id']);
~~~

### Olion syöttäminen kantaan

Kun olio on luotu, kutsutaan varta vasten tätä tarkoitusta varten
tehtyä metodia, joka lisää olion kantaan. 
Malliin kannattaa rakentaa seuraavankaltainen [INSERT-lausetta][insert] kutsuva koodinpätkä:

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

Huomaa miten 
[SERIAL-tyyppistä][serial] pääavainta käytettäessä INSERT-lauseeseen ei laiteta id-avaimelle lainkaan arvoa, jolloin kanta laittaa kenttään seuraavan vapaan arvon.
Tämän numeroon noutamista varten on olemassa omat kikkansa:

* PostgreSQL:llä voidaan INSERT-lauseen jälkeen laittaa käsky `RETURNING id`, jolloin kysely palauttaa kentän `id` arvon ikään kuin se olisi SELECT-kysely.
* MySQL:llä olemassa PDO:n [lastInsertId-metodi](http://php.net/manual/en/pdo.lastinsertid.php), joka palauttaa juuri luodun serial-kentän arvon.

[serial]: http://www.postgresql.org/docs/9.2/static/datatype-numeric.html#DATATYPE-SERIAL
[insert]: http://www.postgresql.org/docs/8.4/static/sql-insert.html

## Virheiden tarkistaminen

Yllä esitetyssä koodissa on yksi puute: virheellisiä syötteitä ei tarkisteta
mitenkään ja pahimmassa tapauksessa kysely saattaa jopa kaatua, jos kantaan
syötetään jotakin, mikä sinne ei kuulu.

Tarvitaan mekanismi, joka tarkistaa ovatko olioon syötetyt
tiedot järkeviä. Tiedoista riippuen
pitää olio joko syöttää kantaan, tai näyttää käyttäjälle
virheilmoituksin varustettu lisäyslomake, jotta käyttäjä 
voi korjata virheensä.

Selkeä tapa toteuttaa tämä on lisätä malliluokan
rajapintaan kaksi metodia, jotka voi nimetä vaikkapa
`onkoKelvollinen` ja `getVirheet`.
Näistä 
ensimmäinen kertoo, ovatko olioon asetetut tiedot tiedot oikeat ja
jälkimmäinen palauttaa kaikki olion tietoihin liittyvät virheet.

Virheentarkistusmetodeja voi sitten kontrollerissa käyttää näin:

~~~inlinephp
//Pyydetään Kissa-oliota tarkastamaan syötetyt tiedot.
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

Virheentarkistusmetodit voi toteuttaa käytännössä kahdella tavalla riippuen siitä
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

**Ote kissojen malliluokasta**

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
### Numeerisen datan vastaanottaminen

Kaikki `$_GET`- ja `$_POST`-taulukoissa oleva data on merkkijonomuotoista.
Numerokenttiä tarkistaessa pitää tämän takia aina 
tarkistaa onko syötetty arvo oikeasti luku.

Tähän on muutamakin tapa: PHP:n sisäänrakennettu
[`is_numeric`-funktio][isnumeric] osaa kertoa
onko merkkijono jokin luku. 

[isnumeric]: http://fi2.php.net/is_numeric

~~~inlinephp
public function setPituus($uusipituus) {
  $this->pituus = $uusiPituus;

  if (!is_numeric($uusipituus) {
    $this->virheet['pituus'] = "Kissan pituuden tulee olla numero.";
  } else if ($uusiPituus <= 0) {
    $this->virheet['pituus'] = "Kissalla täytyy olla positiivinen pituus.";
  } else {
    unset($this->virheet['pituus']);
  }
}
~~~

`is_numeric` ei valitettavasti tosin
kerro onko kyseessä kokonaisluku vai desimaaliluku.
Kokonaislukuja varten voi käyttää esim. säännöllisiä lausekkeita:

~~~inlinephp
if (!preg_match('/^\d+$/', $uusipituus) {
  $this->virheet['pituus'] = "Kissan pituuden tulee olla kokonaisluku.";
}
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
rakentaa siten, että oliolle annnetaan setterissä toisen taulun 
olioita, joista poimitaan id.

### Virhemetodien toteutus

onkoKelvollinen-metodin toteutukseksi riittää käytetyn virhelistan
tyhjyyden tarkistava [`empty`](http://www.php.net/empty):

~~~inlinephp
  /* Palauttaa true, jos Kissaan syötetyt arvot ovat järkeviä. */
  public function onkoKelvollinen() {
    return empty($this->virheet);
  }
~~~

## Käytettävä lisäyslomake

Lomakkeen kontrolleri ohjaa aina takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
Lomakkeessa on tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.

Tämän takia lomake kannatta toteuttaa siten, että sille annetaan aina jokin olio, jonka
tietoja lomakkeen input-tägit näyttävät. 

~~~php
<input type="text" class="form-control" name="nimi" placeholder="Kissan nimi" 
value="<?php echo $data->kissa->getNimi(); ?>">
~~~

Silloin kun käyttäjä ei ole vielä laittanut lomakkeeseen mitään, voi siinä
näyttää vain tyhjän olion:

~~~inlinephp
naytaNakymä("kissalomake", array(
  'kissa' => new Kissa(),
));
~~~

Jos käyttäjä taas on syöttänyt tietoja, mutta tiedot eivät ole käypiä,
näytetään olio, johon tietoja on koetettu syöttää, sekä
samalla olion kelpoisuuden tarkistamisesta saadut virheviestit.

~~~inlinephp
naytaNakymä("kissalomake", array(
  'kissa' => $uusikatti,
  'virheet' => $uusikatti->getVirheet()
));
~~~

### Syötteiden sanitointi

Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät
käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms. sotke sivujen
rakennetta.

Tähän ongelmaan autttaa parhaiten [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php):

~~~php
<?php echo htmlspecialchars($muuttuja); ?>
~~~

### Viiteavaimet lomakkeissa {#selecttag}

Jos muokattavassa oliossa on viite johonkin toiseen tauluun
täytyy käyttäjälle näyttää lomakkeessa jonkinlainen valinta
eri vaihtoehtojen välillä. Helpoin tapa on käyttää [select-elementin][htmlselect]
kautta tehtävää pudotusvalikkoa:

~~~php
<label>Rotu</label>
<select name="rotu_id">
<?php foreach(Kissarodut::haeKaikki() as $rotu): ?>
  <option value="<?php echo $rotu->getId(); ?>"><?php echo $rotu->getNimi(); ?></option>
<?php endforeach; ?>
</select>
~~~

Lopputulos näyttää osapuilleen seuraavalta ja on hyvin helppokäyttöinen:

<label>Rotu</label>
<select name="rotu_id">
  <option value="1">Maatiaiskissa</option>
  <option value="2">Persialainen</option>
  <option value="3">Kissabussi</option>
  <option value="4">Siperiankissa</option>
  <option value="5">Pyhä birma</option>
  <option value="6">Elävä lelutiikeri</option>
</select>

[htmlselect]: http://www.w3schools.com/TAGS/tag_select.asp

### Viestien näyttäminen lisäyksen jälkeen {#sessionmessages}

Lisäyksen onnistuttua lomake ohjaa selaimen listaussivulle. 
Onnistumisesta näytetään tällöin käyttäjälle viesti.

Jos käytät `Location`-otsaketta siirtymiseen sivulta toiselle,
tarvitset tavan välittää siirryttävälle sivulle
viestejä. Tähän tarkoitukseen istunto on mitä kätevin työkalu:

**Kontrollerissa**

~~~inlinephp
  //Lisätään kantaan kissa:
  $uusikatti->lisaaKantaan();
  
  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty:
  $_SESSION['ilmoitus'] = "Kissa lisätty onnistuneesti.";

  //Lähetetään käyttäjä eteenpäin listasivulle:
  header('Location: kissalista.php');
~~~

Kun istuntoon on asetettu virhe, näkyy se seuraavalla
käyttäjän avaamalla sivulla.
Toteutuksen voi tehdä esim. pohjatiedostossa olevalla koodilla:

**Näkymien pohjatiedostossa**

~~~php
<?php if (!empty($_SESSION['ilmoitus'])): ?>
  <div class="alert alert-danger">
    <?php echo $_SESSION['ilmoitus']; ?>
  </div>
<?php
  // Samalla kun viesti näytetään, se poistetaan istunnosta,
  // ettei se näkyisi myöhemmin jollain toisella sivulla uudestaan.
  unset($_SESSION['ilmoitus']); 
  endif;
?>
~~~

Viestin näyttämisen jälkeen on tietenkin huolehdittava siitä, ettei viesti jää
istuntoon roikkumaan, joten se poistetaan istunnosta heti näyttämisen jälkeen.
Tämänkaltaisen koodin ympärille kannattaa yleensä rakentaa jonkinlainen oma rajapintansa.

<next>
Kun lisäys on toteutettu, sen pohjalta voidaan toteuttaa myös
[muokkauslomake](muokkausnakymat.html).
</next>
