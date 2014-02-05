% Sivutus ja hakulomakkeet
<!-- order: 8.5 -->

Jos tietokannassa on paljon kohteita, kannattaa useimmiten
yhdellä sivulla näyttää vain rajattu osajoukko kaikista kohteista.
Tähän on käytännössä kaksi tapaa: sivutus ja hakutoiminnon tekeminen.
Tavat voi myös yhdistää.

## Sivutus

Sivutukseen käytetään tietokantatasolla `LIMIT`-käskyä.
Jos halutaan hakea tietokannasta kymmenen kissaa,
mallikoodiin laitetaan:

~~~inlinephp
/* Haetaan tietokannasta kasa kissoja */
$montako = 10;

$sql = "SELECT * FROM kissat LIMIT ?";
$kysely = getTietokantayhteys()->prepare($sql);
$kysely->execute(array($montako));
~~~

Yleensä halutaan määrän rajoittamisen lisäksi myös kertoa
mistä kohtaa listaaminen aloitetaan eli monettako sivua 
haetaan. Tätä varten lista on pakko järjestää,
sillä ilman järjestämistä SQL palauttaa tietokantarivit mielivaltaisessa
järjestyksessä, mikä tietenkin tekee sivutuksesta täysin hyödyttömän.

Sivun kertomisen ja järjestämisen saa aikaan 
`OFFSET`- ja `ORDER BY`-käskyillä:

~~~inlinephp
$montako = 10;
$sivu = 2;

$sql = "SELECT * FROM kissat LIMIT ? OFFSET ? ORDER by nimi";
$kysely = getTietokantayhteys()->prepare($sql);
$kysely->execute(array($montako, ($sivu-1)*$montako));
~~~

Malliluokkaan kannattaa koodata myös metodi, joka kertoo listauksessa olevien olioiden kokonaismäärän, näin on mahdollista laskea montako sivua listaan tulee:

~~~inlinephp
public static function lukumaara() {
  $sql = "SELECT count(*) FROM kissat";
  $kysely = getTietokantayhteys()->prepare($sql);
  $kysely->execute();
  return $kysely->fetchColumn();
}
~~~

### Sivutus kontrollerissa ja näkymässä

Kun malliluokkaan on koodattu sopivat metodit, voidaan 
niitä käyttää kontrollerissa.
Se millä sivulla ollaan voidaan ottaa vastaan GET-parametrina
ja käyttää sitä määrittämään millä sivulla ollaan:

~~~php
<?php
  $sivu = 1;
  if (isset($_GET['sivu'])) {
    $sivu = (int)$_GET['sivu'];

    //Sivunumero ei saa olla pienempi kuin yksi
    if ($sivu < 1) $sivu = 1;
  }
  $montakokissaasivulla = 10;
  
  //Kysytään mallilta kissoja sivulla $sivu, 
  $kissat = Kissa::getKissatSivulla($sivu, $montakokissaasivulla);

  //Kissojen kokonaislukumäärä haetaan, jotta tiedetään montako sivua kissoja kokonaisuudessa on:
  $kissaLkm = Kissa::lukumaara();
  $sivuja = ceil($kissaLkm/$montakokissaasivulla);
~~~
Itse sivunavigaatio voi koostua aivan tavallisista linkeistä:

~~~php
<?php if ($data->sivu > 0): ?>
<a href="kissalista.php?sivu=<?php echo $data->sivu - 1; ?>">Edellinen sivu</a>
<?php endif; ?>
<?php if ($data->sivu < $data->sivuja): ?>
<a href="kissalista.php?sivu=<?php echo $data->sivu + 1; ?>">Seuraava sivu</a>
<?php endif; ?>
~~~

On myös hyödyllistä kertoa käyttäjälle monennellako sivulla ollaan 
ja paljonko kissoja on:

~~~php
Yhteensä <?php echo $kissaLkm; ?> kissaa. 
Olet sivulla <?php echo $data->sivu; ?>/<?php echo $data->sivuja; ?>.
~~~

## Hakulomakkeet

* Useimmiten on parasta sijoittaa hakulomake samalle sivulle listauksen kanssa.
* Haku on kätevä toteuttaa GET-parametrina. 
* Jos käytetään sekä hakua, että sivutusta, joudutaan sivutuslinkkehiin sisällyttämään hakusana, ettei sivulta toiselle siirtyminen kadottaisi hakua.
* Vastaavasti hausta huolehtivan malliluokan metodin pitää tarvittaessa tukea sivutusta.

<next>
Listausnäkymän viimeistelyn jälkeen toteuta 
[lisäystoiminto](mallit_lisays.html).
</next>
