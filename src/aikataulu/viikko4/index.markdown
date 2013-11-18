% Viikko 4
<!-- order: 1 -->

<deadline>{{deadline4}}</deadline>

Neljännen viikon pääteemana on kantarivien muokkaus ja lomakkeet.

Palautuspäivämäärään mennessä työn on täytettävä alla listatut vaatimukset.
Kunkin otsikon alla olevista asioista saa suluissa määritellyt aikataulupisteet.

## Täysipainoinen malliluokka (¾p)

Sovelluksessa on koodattu ainakin yksi täysi malliluokka, jonka toimintoina on täysi 
[CRUD-setti](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete): hakeminen, muokkaus, poisto, päivitys

Tehdyn koodin pitää toimia turvallisesti ja luotettavasti antoi sille parametriksi mitä vaan. 
Etenkään siinä ei saa olla [SQL-injektiohaavoituvuuksia](http://fi.wikipedia.org/wiki/SQL-injektio).

## Toimiva tiedon muokkaus ja lomakkeet (2p)

Neljännellä viikolla toteutetaan yhden kokonaisen tietokohteen CRUD-toiminnot
siten että meillä on tästä tietokohteesta olemassa:

* Listaus, jossa listataan tietokohteen alkioita (esim. kissoja) ja mahdollisesti näytetään hakutuloksia.
  Listauksen kustakin rivistä on linkit kohteen muokkaamiseen ja poistamiseen sekä vielä erikseen linkki lisäyslomakkeeseen.
* Lisäyslomake
* Muokkauslomake

Tässä vaiheessa on myös järkevää ottaa käyttöön sovelluksessa järkevä ja yleinen virheilmoitusmekanismi.

* Kaikki käyttäjän antamat syötteet tarkistetaan ja sovellus antaa ilmoitukset kaikista virheistä. 
* Virheiden näyttäminen kannattaa hoitaa jollain yleisellä metodilla/funktiolla ja mielellään sivun näkymien pohjatiedostossa, niin että jokainen sivu osaa tarvittaessa näyttää virheitä.
* Jos käyttäjä on syöttänyt lomakkeen virheellisesti, selain viedään takaisin lomakesivulle. 
  Sivulla on tällöin ne virheelliset tiedot, jotka käyttäjä syötti. Näin niiden korjaaminen on helpompaa.

Viimeisimpänä varmista että tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms.

## Dokumentaatio (¼p)

Lisää vielä lopuksi alustava dokumentaatio kappaleista 
[asennustiedot]({{rootdir}}dokumentaatio-ohje.html#asennustiedot) ja 
[käynnistys- / käyttöohje]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje)
repositoriosi dokumentaation PDF-tiedostoon.

<comment>
TODO:
* Tietokantayhteys toimii, ja sen luonti on sijoitettu omaan metodiinsa/funktioonsa.
* Luotu ainakin yksi täysi malliluokka.
* Sivuilla virheilmoitukset virhetilanteista ja syöttövirheistä. Ohjataan takaisin lomakesivulle, mikäli virheellisesti täytetty. 
* Virhellisesti täytetyillä lomakesivulla palatessa ne tiedot, jotka käyttäjä syötti.
* Tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms. eikä koodissa ole SQL-injektiopaikkoja
* Alustava: asennustiedot, käynnistys- / käyttöohje

* [Tietokannan kokeilu ja yhteydenotto]({{rootdir}}ohjeistus/tietokantaohjelmointi/tietokantayhteys/index.html)
* [Tietokantaa käyttävän mallin luominen](mallit.html)
* [Lomakkeiden ja sivujen toteuttaminen](nakymat.html)

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
    * Lomakkeen kontrolleri ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
        * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Väärin syötetyt tiedot kerrotaan virheilmoituksin.
    * Tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms.
</comment>

<ohje>
Aloita menemällä oman kielesi malliluokkaohjeistukseen ja seuraa vihreitä ohjelaatikoita:

* [PHP: Malliluokat ja tiedon muuttaminen]({{rootdir}}ohjeistus/tietokantaohjelmointi/php/mallit_muokkaustoiminnot.html)
* [Java: Malliluokat ja tiedon muuttaminen]({{rootdir}}ohjeistus/tietokantaohjelmointi/java/mallit_muokkaustoiminnot.html)

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät sekä GitHub-repositoriossasi, että testipalvelimella antamassasi osoitteessa.
</ohje>
