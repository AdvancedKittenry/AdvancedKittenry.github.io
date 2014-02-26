% Ohjeet tietokantasovelluksen ohjaajalle
<!-- hidden! -->

Sivujen sisällöstä osa vapaasti mukailtu [vuoden 2006 ohjeesta](http://www.cs.helsinki.fi/u/laine/tikas/ohjaus.html).
Kurssisivujen muokkaamista varten on [omat ohjeensa](muokkaaminen.html).

[etusivu]: {{rootdir}}index.html
[arvosteluperusteet]: {{rootdir}}arvosteluperusteet.html
[codereview]: {{rootdir}}aikataulu/codereview.html

## Aloitusluento

Kurssi alkaa aloitusluennolla, jossa opiskelijoille kerrotaan 
kurssin perusasiat ja annetaan mahdollisuus kysyä kysymyksiä.
Luennolla käydään läpi käytännössä samat asiat, kuin kurssisivujen
[etusivulla][etusivu] ja 
[arvosteluperusteet-sivulla][arvosteluperusteet]
lukee. Kannattaa itsekin tutustua näihin sivuihin,
ja etenkin kurssin [aikatauluun](#aikataulu).

## Työaiheet ja sopiva työn laajuus

Ensimmäisellä viikolla opiskelijoiden tehtävänä on lähinnä valita itselleen aihe ja toteutustekniikat.

Harjoitustöiden aiheita löytyy kurssisivuilta. 
Aiheita voi vapaasti muunnella opiskelijan toiveiden ja
omien mieltymystesi mukaan.

<include src="../suunnittelu_ja_tyoymparisto/aiheet/maksimiarvosana.markdown" />

Opiskelijalle kannattaa painottaa, 
mikä hänen aihevalintansa maksimiarvosana on ja miksi,
mikäli se ei ole viisi.

### Oma aihe tai toteutustekniikka

Jos joku haluaa tehdä työn itse keksimästään aiheesta ja työ täyttää
kurssille asetettavat vaatimukset (tietokanta jossa noin 4-7 taulua,
yksinkertainen käyttöliittymä, järkevä maksimiarvosana), voit antaa hänen tehdä oman aiheensa. Omasta aiheesta
täytyy laatia aihekuvaus laitoksen aiheiden tapaan. 

Jos opiskelija haluaa
tehdä työn eri valineillä kuin laitoksella on tarjolla, voit harkintasi
mukaan suostua tähän. Lähtökohtana on kuitenkin Javan Servletteihin tai PHP-kieleen perustuva toteutus. Työssä ei kuitenkaan koskaan saa käyttää tietokantaa abstraktoivia kirjastoja, vaan tietokantakyselyt on tehtävä ns. käsin. Yleensä ei myöskään kannata antaa opiskelijan tehdä tekniikalla, josta 
hänellä ei ole merkittävästi kokemusta. Yleensä tälläiset työt epäonnistuvat.

Perusedellytys on, että opiskelija pystyy tekemään työnsä ja että pystyt *itse testaaman ja
tarkistamaan työn*. Sinun on syytä todeta, että opiskelija ei saa opastusta
muiden välineiden käytössä. Kysy ohjeita toisilta ohjaajilta tai kurssin
vastuuhenkilöltä.

### Vanhan työn jatkaminen

Pääsääntöisesti jokainen opiskelija aloittaa uuden työn työryhmässäsi.
Aikaisemman työn jatkamiseen tulee olla todella hyvät perustelut esim.
osoitettavissa oleva sairastuminen. Kysy kurssin vastuuhenkilöltä ohjeita
tarvittaessa.

## Työn ohjaaminen

Työn ohjaus perustuu normaaliin pajaohjaukseen ja kurssisivuilla annettuun aikataulun.

Puutu ajoissa selvästi ylisuuriksi paisuviin töihin. Jos työ
ei etene, tiivistä ohjaustapahtumia ja määritelle pienempiä tavoitteita.
Älä päästä opiskelijaa tekemään toteutusta selvästi virheellisen tai
puutteellisen tietokantaratkaisun pohjalta. Ratkaisua on vaikea nopeasti
muuttaa toimivaksi.

### Pajojen ulkopuolinen neuvominen

Voit sopia henkilökohtaisen ohjauksen hoidettavaksi myön muulla tavoin kuin
viikottaisella pajaohjauksella. 

Ennalta sovitut henkilökohtaiset ohjaukset voit hoitaa harjoitussalissa,
labrassa tai omassa työhuonessasi. Omistaudu silloin vain kyseiselle
opiskelijalle. Henkilökohtaisia neuvonpitoja ei saa sopia
päivystysajoiksi. Päivystysaikoina sinulta voivat tulla kysymään neuvoa
myös muiden ryhmien opiskelijat. Näille annat kuitenkin vain teknisiä
neuvoja. On suotavaa että päivystysajat eivät ole samana päivänä kuin
henkilökohtainen ohjaus.

Työaikaasi on laskettu aikaa sähköpostivastauksiin. Kerro siis
opiskelijoille sähköpostiosoitteesi ja vastaa opiskelijoiden kysymyksiin.
Sähköpostitse ei ole järkevää laatia pitkiä vastauksia. Jos ongelma
edellyttää sellaista sovi tapaaminen.


## Viikottaiset arvostelut {#aikataulu}

<include src="../aikataulu/viikkopalautukset/index.markdown" />

Kurssin viikottaiset arvostelut tehdään [labtooliin](http://tsoha-labtool.herokuapp.com/).
Arvostelun antamisessa käytetään työkaluna checklist-nimikkeellä
kulkevia tarkistuslistoja. Järjestelmä antaa opiskelijan
tekemien asioiden perusteella viikkopisteet ja alustavia palautetekstejä.
Pisteitä ja palautteita voi ja kannattaakin hieman kustomoida sen mukaan miltä opiskelijan työ muuten vaikuttaa.

## Demotilaisuus

Kaikkien opiskelijoiden on osallistuttava demotilaisuuksiin. Näiden
päätarkoitus on, että opiskelijat oppisivat esittelemään tuotettaan
julkisesti eri vaiheissa prosessia. 

Demoista kannattaa meilata opiskelijoille etukäteen, että
opiskelijat varmasti muistavat osallitua niihin.
Yleensä demot on pidetty samaan aikaan pajojen kanssa.
Paikkakin voi olla sama, mutta usein on kätevämpää varata
tilaisuutta varten oma luokkansa. Esim. 
[luokka A217](https://www.cs.helsinki.fi/booking/?room=1)
tai [A218](https://www.cs.helsinki.fi/booking/?room=7).

Varmista että opiskelijat esittelevät työstään sekä 
sen käyttöliittymää, että koodia tasapuolisesti.
Opiskelijoille voi ja kannattaakin esittää täsmentäviä kysymyksiä,
sekä yleisiä kysymyksiä kurssin sujumisesta.

## Työn valmistuminen

Jokaisen työn pitää noudattaa kurssilla annettua aikataulua. 
Aikataulut voivat erityistapauksissa olla kuitenkin myös
henkilökohtaisia. 
Viikkoaikataulu ja deadlinet tietenkin luovat
puitteet henkilökohtaisille aikatauluille. Välitavoitteet edistävät
valmistumista. 


Lopuksi opiskelijat esittelevät lopputuloksensa muille.
Tällöin työn pitäisi olla pitkälti valmis. Valmistumispäivä on aina
kiinnitettävä ennakolta. 

Aikataulua ei ole syytä muuttaa kevein perustein.
On kuitenkin syytä säätää aikatauluja siten, ettei työn välttämättä pidä
olla valmis esimerkiksi samana tai edellisenä päivänä kun opiskelijalla on
tentti. 

Anna jatkoaikaa vain hyvästä
syystä (sairaana yli viikon, kertausharjoitus, lapsen synnytys tms.).
Tekniset ongelmat - koneet pitkään nurin kriitisessä vaiheessa,
käyttäjätunnus viivästynyt- ovat hyviä perusteita jatkoajalle. Valmiina
palautetun, mutta todella huonon työn voi joko suoraan hylätä tai
palauttaa korjattavaksi. Jos työ palautetaan korjattavaksi, niin
opiskelijalle tulee antaa tarkat ohjeet ja aikataulu työn loppuun
saamiseksi.

Tavoitteena tulisi olla laadukas ohjelmistotuote. Huonon työn voi hylätä.
Työn päätavoite on kuitenkin oppiminen ei oppineisuuden osoittaminen.
Toisaalta opiskelijalle pitäisi antaa mahdollisuus parantaa työtään
paremman arvosanan saamiseksi. Töissä tulisi lähteä siitä, että
määräaikoja noudatetaan. Tämä ei estä sinua sopimasta opiskelijan kanssa
henkilökohtaista aikataulua, jossa valmistumispäivä on jokin muu kuin
ryhmän virallinen valmistumispäivä. Työn myöhästyminen sovitusta
valmistumispäivästä ilman hyvin pätevää syytä johtaa aina arvosanan
laskuun.

Kts. myös [kurssin arvosteluperusteet][arvosteluperusteet]

Älä käytä liikaa aikaa arvosteluun. Työaikanormiin mahtuu noin 4 tuntia
tarkastusaikaa opiskelijaa kohti. Yleensä tästä suuri osa menee viikkopalautteiden antamiseen, mutta bonuksena loppuarvostelun checklist käyttää melko vapaasti hyväkseen viikkopalauteissa kerättyjä tietoja, joten loppuarvostelu on usein paljon nopeampaa kuin luulisi.

Jos annat jatkoaikaa tai palautat työn korjattavaksi, niin sinä olet
edelleen vastuussa työn ohjaamisesta ja korjaamisesta, vaikka varsinainen
työryhmän ohjausaika olisikin jo päättynyt. Ääritapauksissa neuvottele
kurssin vastuuhenkilön kanssa. Et voi lykätä opiskelijaa seuraavan ryhmän
vetäjän harteille. Jos opiskelija selvästi tippuu annetusta aikataulussa,
voit katsoa hänet keskeyttäneeksi.

Tulosten toimittaminen eteenpäin tulisi tapahtua noin 2 viikon kuluessa
ohjausajan päättymisestä. Älä jää odottamaan lisäajan saaneita vaan
ilmoita heidän tuloksensa myöhemmin erikseen.

Arvostelu olisi julkaistava kahden viikon kuluttua ryhmän päättymisestä.
Tulosten täytyy olla rekisterissä ehdottomasti viimeistään 1 kuukauden
kuluessa (yliopiston ohjesääntö). 
Yleensäottaen arvostelu on jaettu tasan ryhmäopetustuntien mukaan.

### Arvostelun selitys opiskelijalle

Sinun tulee
antaa opiskelijalle palautetta hänen työstään. 
Normaalisti tämä tapahtuu labtoolin kautta valitemalla "Loppuarvostelu"-nimisen
checklistin. Tarkistuslistalle annetaan kätevyyden nimissä samalla viikkopisteet ja mahdolliset koodikatselmointipisteet.
Tässäkin kannattaa muistaa, että tarkistuslistan antama pisteytys ja palaute on *alustavaa*.

Opiskelijan
niin halutessa on henkilökohtainen palautetilaisuus järjestettävä.
Tätä varten voit sopia
ohjaustilaisuuden yhteydessä opiskelijan kanssa.
Opiskelijoilla on myös oikeus 2 kuukauden aikana
(asetus HY:stä) tulosten julkistamisesta tulla kysymään arvostelun
perusteita, joten talleta itselläsi kaikki arvosteluusi tarvitavat tiedot.

### Arvostelun kirjaaminen

Kirjaa arvosana kurki-järjestelmään ja ilmoita arvostelun valmistumisesta
kurssin vastuuhenkilölle.

Jos opiskelijalla on mielestäsi hyvä syy jatkaa kesken jäänyttä työtä
seuraavana lukukautena uudessa ryhmässä, niin pistä tähän hyvät perustelut
sille.

### Sairauden tai muun syyn johdosta syntyvät poikkeukset

Poissaolo demotilaisuuksista on esitettävä hyvä syy. Opiskelijan on
ilmoitettava henkilökohtaisen ohjauspalaverin peruutuksesta hyvissä ajoin
etukäteen. Niiden peruuttamiseen täytyy olla hyvä syy.

Kun opiskelija saa työnsä valmiiksi, ohjaustilaisuuksien läsnäoloa ei sen
jälkeen tietenkään vaadita. demo voidaan silloinkin vaatia.

## Kysymyksiä?

Kysymykset sivujen tai kurssin sisällöstä kannattaa tällä hetkellä lähettää [David Consuegralle](mailto:davicon@gmail.com)
tai kurssin vastuuhenkilölle.
