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

~~~java
/* Haetaan tietokannasta kasa kissoja */
Connection yhteys = Tietokanta.getYhteys();
int montako = 10;

String sql = "SELECT * FROM kissat LIMIT ?";
PreparedStatement kysely = yhteys.prepareStatement(sql);

kysely.setInt(1, montako);
ResultSet tulokset = kysely.executeQuery();
~~~

Yleensä halutaan määrän rajoittamisen lisäksi myös kertoa
mistä kohtaa listaaminen aloitetaan eli monettako sivua 
haetaan. Tätä varten lista on pakko järjestää,
sillä ilman järjestämistä SQL palauttaa tietokantarivit mielivaltaisessa
järjestyksessä, mikä tietenkin tekee sivutuksesta täysin hyödyttömän.

Sivun kertomisen ja järjestämisen saa aikaan 
`OFFSET`- ja `ORDER BY`-käskyillä:

~~~java
int montako = 10;
int sivu = 2;

String sql = "SELECT * FROM kissat LIMIT ? OFFSET ? ORDER by nimi";
PreparedStatement kysely = yhteys.prepareStatement(sql);

kysely.setInt(1, montako);
kysely.setInt(2, (sivu-1)*montako);

ResultSet tulokset = kysely.executeQuery();
~~~

Malliluokkaan kannattaa koodata myös metodi, joka kertoo listauksessa olevien olioiden kokonaismäärän, näin on mahdollista laskea montako sivua listaan tulee:

~~~java
public static int lukumaara() {
  String sql = "SELECT count(*) as lkm FROM kissat";
  PreparedStatement kysely = yhteys.prepareStatement(sql);
  ResultSet tulokset = kysely.executeQuery();

  // Tuloksia on aina yksi, mikäli kissat-taulu on olemassa.
  // Kelataan ensimmäiseen tulokseen:
  tulokset.next(); 
  return tulokset.getInt("lkm");
}
~~~

### Sivutus kontrollerissa ja näkymässä

Kun malliluokkaan on koodattu sopivat metodit, voidaan 
niitä käyttää kontrollerissa.
Se millä sivulla ollaan voidaan ottaa vastaan GET-parametrina
ja käyttää sitä määrittämään millä sivulla ollaan:

~~~java
int montakokissaasivulla = 10;
String sivuParametri = request.getParameter("sivu");
int sivu = 1;

//Tarkistetaan että parametri on olemassa, ja että se on numeromuotoinen
if (sivuParametri != null && sivuParametri.matches("\\d+")) {
  sivu = Integer.parseInt(sivuParametri);
}

//Kysytään mallilta kissoja sivulla $sivu, 
List<Kissa> kissat = Kissa.getKissatSivulla(sivu, montakokissaasivulla);

//Kissojen kokonaislukumäärä haetaan, jotta tiedetään montako sivua kissoja kokonaisuudessa on:
int kissaLkm = Kissa.lukumaara();
int sivuja = Math.ceil((double)kissaLkm/montakokissaasivulla);
~~~
Itse sivunavigaatio voi koostua aivan tavallisista linkeistä:

~~~jsp
<c:if test="${sivu > 0}">
<a href="kissalista.php?sivu=${sivu - 1}; ?>">Edellinen sivu</a>
</c:if>
<c:if test="${sivu < sivuja}">
<a href="kissalista.php?sivu=${sivu + 1}">Seuraava sivu</a>
</c:if>
~~~

On myös hyödyllistä kertoa käyttäjälle monennellako sivulla ollaan 
ja paljonko kissoja on:

~~~jsp
Yhteensä ${kissaLkm} kissaa. 
Olet sivulla ${sivu}/${sivuja}.
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
