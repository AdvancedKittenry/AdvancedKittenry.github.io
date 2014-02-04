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
* Poistotoiminto

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

<ohje>
Aloita menemällä oman kielesi malliluokkaohjeistukseen ja seuraa vihreitä ohjelaatikoita:

* [PHP: Listausnäkymien luominen]({{rootdir}}koodaaminen/php/listausnakymat.html)
* [Java: Listausnäkymien luominen]({{rootdir}}koodaaminen/java/listausnakymat.html)

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät sekä GitHub-repositoriossasi, että testipalvelimella antamassasi osoitteessa.
</ohje>
