%Dokumentaatio-ohje
<!-- addHeaderNavigation -->

Kurssilla määritellään, suunnitellaan ja toteutetaan pieni www-alustalle toteutettava tietokantajärjestelmä.  
Tämä dokumentti antaa suuntaa harjoitustyöltä odotettavasta dokumentaatiosta.  
Dokumentissa tulee olla selkeä kappalejako, kansilehti ja sisällysluettelo. Tekstin tulee olla kieliasultaan selkeää. Dokumentaatio tulisi palauttaa mieluiten **yhtenä pdf-tiedostona** joka kuvaa koko järjestelmän, tarvittaessa kuvat voi palauttaa irrallisina.

##1. Johdanto

Johdantoon kirjoitetaan lyhyt, ytimekäs kuvaus siitä, mikä on työn aihe, mitä työllä kuuluisi pystyä tekemään
ja mitä tekniikoita siinä käytetään.

- Järjestelmän tarkoitus
  - Tiivis kuvaus siitä mistä on kyse.
  - Millaisen toiminnan tukemiseen järjestelmä on tarkoitettu.
  - Mitkä ovat järjestelmän tavoitteet.
  - Nämä tiedot saa yleensä tehtäväkuvauksesta, kirjoita kuitenkin omin sanoin.
- Toteutus-/toimintaympäristö
  - Missä ympäristössä työ toteutetaan (yleensä laitoksen users-palvelimella Tomcat- tai Apache-palvelimen alla)
  - Täytyykö web-sovelluksen alustajärjestelmän tukea jotain tiettyä ohjelmointikieltä. (esim. Java, Ruby, PHP..?)
    - Jos edellytetään jotain sovelluskehystä tulisi sekin mainita.
  - Täytyykö käyttäjän selaimen tukea jotain tiettyä ohjelmointikieltä (esim. javascript?).
  - Edellyttääkö ohjelmisto jonkun tietyn tietokannan käyttöä vai voiko sitä vaihtaa helposti. Useimmat työt toimivat vain yhdellä kannalla.


##2. Yleiskuva järjestelmästä

###Käyttötapauskaavio tai sidosryhmäkaavio
Molemmat kaaviot näyttävät järjestelmän sidosryhmät ja miten ne liittyvät järjestelmään.
Tällä kurssilla kehitettävissä järjestelmissä sidosryhminä ovat enimmäkseen järjestelmän käyttäjäryhmät. Muita mahdollisia sidosryhmiä olisi esimerkiksi toiset järjestelmät. Harjoitustyössä käyttäjäryhmien tulisi osaltaan näkyä kyseisille ryhmille suunnattuina toiminnallisuuksia.

Käyttötapauskaaviossa käyttötapaukset kuvataan järjestelmän sisällä ja sidosryhmien yhteydet järjestelmään esitetään yhteyksinä käyttötapauksiin. 
Kaavion kuvaa järjestelmästä voisi kuvailla esimerkiksi "Tällaisia asioita järjestelmässä voi tehdä, ja nämä ryhmät tekevät näitä asioita".

Sidosryhmäkaaviossa sidosryhmien yhteys järjestelmään kuvataan nuolina sidosryhmästä kohti palveluntarjoajaa. 
Kunkin sidosryhmän karkean tason käyttötapaukset ilmaistaan yhteyden tyyppinä.

Kaavioiden lisäksi käyttäjäryhmät sekä tärkeimmät käyttötapaukset kuvaillaan erikseen myös tekstinä.
Kurssin tavoitteisiin riittää, että toinen kaavioista on mukana.

**Esimerkit**

####Käyttötapauskaavio  
![Käyttötapauskaavio]({{imgdir}}dokumentaatio-ohje/usecase_diagram.png)

####Sidosryhmäkaavio  
![Sidosryhmäkaavio]({{imgdir}}dokumentaatio-ohje/sidos3.gif)

###Käyttäjäryhmät
Annetaan lyhyt kuvaus järjestelmän sidosryhminä toimivista käyttäjäryhmistä.

**Esimerkki**

  Jokamies
    Jokamiehellä tarkoitetaan ketä tahansa, joka Internetin välityksellä tulee lukemaan KatonAlle yhtiön www-sivuja. 
    Kaikki muut sidosryhmät kuuluvat myös tähän sidosryhmään.

  Asiakas
    Asiakas on rekisteröitynyt käyttäjä.

  Vuokranantaja
    Vuokranantaja on rekisteröitynyt henkilö, joka on antanut asunnon KatonAlle yhtiölle välitettäväksi.

  Työntekijä
    Työntekijä on KatonAlle yhtiön palveluksessa oleva henkilö.

  Johto
    Johdolla tarkoitetaan työntekijöitä, joiden tehtävänä on tehtävien anto ja asioista päättäminen.


##3. Käyttötapaukset

Käyttötapauksella tarkoitetaan järjestelmän avulla hoidettavaa tavoitteellista tehtäväkokonaisuutta. 
Esimerkiksi tilauksen kirjaus, tilauksen peruutus ja laskun tulostus ovat tehtäväkokonaisuuksia, joita on luonnollista mallintaa käyttötapauksina. 
Kustakin käyttötapauksesta kuvataan sen sisältö: mitä käyttötapauksessa tehdään. 
Raporttien kohdalta kerrotaan, mitä tietoja raporttiin sisältyy. 

Käyttötapausten avulla määritellään, mitä järjestelmällä tehdään. Voit luonnostella käyttötapauksia esimerkkitapausten avulla. 
Esimerkkitapauksessa toiminnan kohde on kiinnitetty. Esimerkiksi 'ilmoittautuminen Informaatiojärjestelmät kurssin harjoitusryhmään 3' 
on esimerkkitapaus käyttötapauksesta 'luentokurssille ilmoittautuminen'. Voit esittää esimerkkitapauksia myös dokumentissa havainnollistaaksesi 
käyttötapauksia. Käyttötapaukset kannattaa esittää käyttäjittäin ryhmiteltynä tärkeysjärjestyksessä.

####Esimerkki  

  Jokamiehen käyttötapaukset

  Yritysinfon lukeminen:
    Kuka tahansa voi käydä lukemassa yrityksen mainos- ja yleistietoja 
    mm. työntekijöiden puhelinnumerot ja toimistojen sijainnit.

  Asuntotilanteen yleiskuvan selvittäminen:
    Käyttäjälle näytetään, minkä tyyppisiä asuntoja kullakin alueella 
    kyselyn suoritushetkellä on tarjolla vuokralle ja kuinka monta näitä on tarjolla. 
    Esimerkki: Millaisia asuntoja on tarjolla Kruunuhaassa?

  Rekisteröityminen asiakkaaksi:
    Rekisteröitymisessä käyttäjä ilmoittautuu yrityksen asiakkaaksi päästen näin 
    yrityksen muiden asiakaspalveluiden käyttäjäksi ja asiakastiedotteiden saajaksi.

    Jokamiehestä tulee asiakas. Hän antaa henkilötietonsa ja saa asiakastunnuksen, 
    joka on avain asiakkaille tarkoitettuihin palveluihin. 

    Prototyypissä asiakastunnus aktivoituu heti. 
    Aktivoinnin voisi kytkeä myös esimerkiksi jäsenmaksun maksamiseen.


##4. Järjestelmän tietosisältö

Järjestelmän tietosisältö kuvataan käsitekaavion avulla. Käsitekaavio on järjestelmään säilöttävälle tiedolle käsitetason malli, jonka perusteella johdetaan toteutustason relaatiotietokantakaavio.

####Esimerkki  
![Käsitekaavio]({{imgdir}}dokumentaatio-ohje/information_diagram.png)

Kaavion lisäksi täytyy kuhunkin tietokohteeseen liittää selitys, jossa määritellään kyseinen kohde. 
Attribuutit täytyy kuvailla ellei merkitys ole nimen perusteella itsestään selvä. 
Jos attribuutilla on koodiarvoja tai rajattu arvojoukko, on arvojen merkitys myös selitettävä. 
Myös yhteydet täytyy määritellä. Alla on esimerkkinä yhden tietokohteen määrittely.

####Esimerkki 

<include src="examples/tietokohdekuvaus.markdown" />

Jos haluat varmistua siitä, että tietosisältömallisi ja käyttötapauksesi sopivat yhteen ja mallit ovat kattavia voit laatia riippuvuusmatriisin kuvaamaan tietokohteiden käsittelyä käyttötapauksissa. Riippuvuusmatriisin sarakkeina ovat kohdetyypit ja yhteydet. Riveinä ovat käyttötapaukset. Kuhunkin sarakkeeseen merkitään, mitä käyttötapauksessa tehdään ko. luokan kohteille (C=create, R=read, D=delete, U=update). Jokaisen käyttötapauksen täytyy käsitellä jotain kohdetta. Tietokohteelle täytyy mahdollistaa riittävät käsittelyoperaatiot käyttötapausten kautta.


##5. Relaatiotietokantakaavio

Relaatiotietokantakaavio on teknisempi dokumentti, jossa tiedon säilömiseen käytettävän tietokannan rakenne esitetään kaaviokuvana ja SQL:n create table lauseina. Kaavioon täytyy sisältyä taulujen välisten viiteyhteyksien ja avainten määritykset. 
Jos relaatiokaaviossa on attribuutteja, jotka eivät esiinny käsitemallissa tai jonkin käsitemallin attribuutti on karsittu tai sen muotoa on muutettu on tästä erikseen mainittava. 
Yleissääntönä on, että relaatiotietokantakaavion tulee olla yhteensopiva käsitemallin kanssa.

Create table -lauseet voi antaa liitteenä, jolloin niitä ei tarvitse kirjoittaa dokumentin sekaan.

Alla on esimerkki kaaviokuvasta. Nuolten tulisi lähteä vierasavainten kohdalta, pk = primary key, fk = foreign key.  
Huomaa kuitenkin taulun varuste vieras pariavain (huoneisto,laatimisaika) on kuvattu yhdellä nuolella.  

![Relaatiotietokantakaavio]({{imgdir}}dokumentaatio-ohje/relaatiokaavio.gif)
Muunnossäännöt käsitemallista relaatiomalliin löytyvät Tietokantojen perusteet kurssin materiaalista.

##6. Järjestelmän yleisrakenne

Tämän kappaleen tarkoitus on kertoa lyhyesti mistä jotakin toimintoa kannattaa ohjelmakoodissa etsiä.
Järjestelmän yleinen hakemistorakenne esitetään selostamalla yleisellä tasolla lyhyesti mihin tarkoitukseen tarkoitettuja tiedostoja projektin hakemistot sisältävät,
mihin mahdollisesti käytetyt kirjastot ja apuluokat on sijoitettu ja mitä erilaisia ohjelmakoodikomponentteja projektista löytyy (Esim. html-näkymä, apuluokka, tietokantaluokka, kontrolleri). Mikäli järjestelmällä on erillinen asetuksista vastaava tiedosto, kerrotaan sen sijainti samoin kuin mahdolliset tiedostojen nimeämiseen liittyvät käytännöt.

####Esimerkki MVC-mallin mukaisesta php-projektista

> Tietokantasovellusta tehdessä on noudatettu MVC-mallia. Kontrollerit, näkymät ja mallit \
> sijaitsevat hakemistoissa controllers, views- ja models. Käytetyt apukirjastot on sijoitettu\
> hakemistoon lib ja asetukset ovat tiedostossa settings.php. \
> \
> Ylläpidon sivuista vastaavissa tiedostoissa on kaikissa admin-etuliite. Kaikki tiedostonimet on \
> kirjoitettu pienellä.

##7. Järjestelmän komponentit
Kustakin ohjelman komponentista laaditaan erillinen kuvaus, jossa esitetään komponentin ymmärtämisen kannalta oleelliset asiat. 
Kuvaus on suunnattu henkilölle, joka mahdollisesti joskus joutuisi ylläpitämään ohjelmistoa.

Jokaisen komponentin osalta esitetään sen nimi ja kuvaus siitä, mitä se tekee ts. mikä sen tarkoitus on.
Komponentit voidaan esitellä esim. ryhmiteltyinä html-sivuihin, servletteihin ja apuluokkiin. 
Lisäksi voi omana osionaan luetella sovelluksessa mahdollisesti käytettävät kuva-, ääni- yms. tiedostot.
Mikäli sovelluksessa on käytetty jotain kirjastoa, kuten jQuery, tulee eritellä mitkä ovat omia ja mitkä kirjaston komponentteja, käytetyistä kirjastokomponenteista tulee kertoa mihin niitä käyttää.


####Esimerkki

> index.php\
>   Sovelluksen etusivu. Sisältää kentät sisäänkirjautumista varten, linkin rekisteröitymissivulle ja lyhyen, \
>   mutta kuvailevan kertomuksen järjestelmästä ja sen viimeaikaisesta kehityksestä. Viimeaikaisesta kehityksestä \
>   kertovan kentän sisältö täytetään uutissyötteestä dynaamisesti. Sivu tarjoaa myös pikahakukentän, jonka sisältö \
>   lähetetään asuntohaku.php:n käsiteltäväksi.\
>   \
> asuntohaku.php\
>   Tarjoaa hakulomakkeen asuntojen hakua varten ja luettelon hakutuloksista. Hakulomake mahdollistaa hakujen\
>   tekemisen avainsanan, paikkakunnan ja hintahaarukan perusteella.\
> \
> resources/dbConnection.php\
>   Tiedosto, jonka avulla tietokantayhteyden saa avatuksi helposti. \
>   Tietokantaa tarvitsevat komponentit käynnistävät tämän tarpeen mukaan.\
>   \
> resources/dbSearchFunctions.php\
>   Tarjoaa kokoelman funktioita, jotka tekevät tietokantaan kyselyitä ja palauttavat kyselyiden tuloksia eri muodoissa. \
>   Tämän kokoelman funktiot keskittyvät erilaisiin asuntotietoihin liittyviin hakuihin ja eivät muuta mitään tietokannassa.\
> \
> ...\
> \
> resources/header.html\
>   Jokaisen generoitavan sivun alkuun liitettävä otsaketiedosto, jossa html-sivun yleiset määrittelyt. \
>   Asettaa sivujen otsikoksi "KatonAlle Oy" ja kertoo merkistökoodauksen olevan UTF-8.\
>   \
> resources/footer.html\
>   Jokaisen generoitavan sivun loppuun liitettävä tiedosto. Liittää sivun pohjalle sivun ylläpitäjän sähköpostiosoitteen ja lopettaa sivun.\
> \
> resources/lib/jokuKirjasto/\*\
>   Käyttämäni kirjaston jokuKirjasto komponentit löytyvät täältä. Seuraavaksi yksilöin sen komponenttien joukosta ne,\
>   joita olen käyttänyt.\
> \
> resources/lib/jokuKirjasto/lomakkeentarkastuskomponentti.js\
>   Olen käyttänyt tätä komponenttia web-lomakkeiden sähköpostikenttien muodon tarkastukseen.\
>   \
> ...
  
Tämän lisäksi ohjelmakoodin tulee olla dokumentoitua (kommentit / javadoc / phpdoc tms.) ja käyttää havainnollisia nimiä muuttujille ja funktioille/metodeille. 
Ohjelmiston tulee olla jaettuna komponentteihin järkevästi, siten että turhalta toistolta vältytään.
Komponentteihin liittyvät yleistiedot on hyvä kirjoittaa myös ohjelmakoodin alkuun yleiskommentiksi, jolloin ne voi vain kerätä ohjelmakoodista dokumenttiin. 
Ohjelmakoodit sijoitetaan dokumentin liitteiksi.


##8. Käyttöliittymä

Käyttöliittymän näkymien välisiä yhteyksiä on luontevaa esittää kaavioina. 
Seuraavassa kuvassa on esimerkki tällaisesta kaaviosta.  
![Sivurakennekaavio]({{imgdir}}dokumentaatio-ohje/sivurakenne.jpg)

Käyttötapausten ja käyttöliittymäkomponenttien välisiä yhteyksiä voi kuvailla tekstimuodossa. Tätä vaatimusta lieventää, 
jos sivut on nimetty kuvaavasti ja käyttötapauksille tarkoitetut polut rakenteessa ovat intuitiiviset.
Sivukohtaisen julkisuusmäärittelyn dokumentoiminen ei ole välttämätöntä, jos esim. asianmukaisen siirtymän kohdalla kertoo,
että tästä pääsee eteenpäin vain tunnistettu käyttäjä. Mikäli sivustolla on navigaatiopalkki, jonka johdosta kirjautunut käyttäjä 
pääsee mistä vain mihin vain, kannattaa tämä mainita sanallisesti kaavion yhteydessä ja merkitä kaavioon vain sellaiset yhteydet,
jotka olisivat olemassa ilman navigaatiopalkkiakin.


##9. Asennustiedot

TODOOOOOOOO

yhyehkö ohje, jonka tarkoituksena on toisaalta kertoa, miten sovellus on nyt asennettu ja toisaalta miten sen saisi asennettua uuteen ympäristöön.
Servlettien sijoittelu riippuu servlettiympäristöstä, joten sitä ei tarvitse määritellä.

Asennusohjeesta tulisi käydä ilmi, minne käytettävän tietokannan asetukset (käytettävä tietokanta, käyttäjätunnus, salasana) tulee ohjelmistoa asentaessa määritellä.

**Esimerkki PHP-sovelluksen asennustiedoista:**

> Asenna sovellus kopioimalla sen tiedostot palvelimesi nettiin näkyvään hakemistoon 
> (esim. usersin htdocs-hakemisto). 
> Aseta sen jälkeen tietokannan yhteystiedot oikeaksi tiedostoon
> `libs/config.php`. Voit kopioida asetustiedoston mallin tiedostosta `libs/config.php.dist`

##10. Käynnistys- / käyttöohje

Tyypillisesti tässä riittää kertoa missä osoitteessa harjoitustyö on asennettuna ja 
millä voi kirjautua sisään.

Perusoletuksena on, että järjestelmän käyttäjä osaa käsitellä WWW-sivuja selaimella. Tähän liittyviä ohjeita ei siten tarvitse antaa. 
WWW-sovelluksen tulisi olla helppokäyttöinen ja intuitiivinen. Sivujen  pitäisi itsessään sisältää riittävästi sivun käyttöön tarvittavaa informaatiota. 
Jos sivut ovat tällaisia, riittää antaa ohjelman käynnistykseen tarvittava URL. 
Jos käyttöön liittyy joitain yleisiä toimintajärjestykseen liittyviä asioita, ne voidaan kertoa tässä yhteydessä.  
Näiden tietojen tulisi löytyä myös tuotettavan järjestelmän sivuilta. 

Muista kertoa ohjaajalle mahdolliset testaustunnukset ja salasanat.

##11. Testaus, tunnetut bugit ja puutteet & jatkokehitysideat

Miten olet testannut ohjelmaa? Kuinka laajasti testaus on toteutettu?

Mitä puutteita tai bugeja ohjelmassa on? Mitä lisäominaisuuksia ohjelmaan voisi lisätä?

##12. Omat kokemukset

Mikä oli tietokantasovelluksen teossa helppoa? Mikä vaikeaa? Mitä opit? Muu vapaa sana.


##13. Liitteet
Dokumentin liitteinä annetaan:

* Tietokannan määrittelevät create table lauseet, erillisenä SQL-tiedostona projektin git-repositoriossa.
* Tehtäväkuvaus, jos valmis aihe.
  * Linkki kuvaukseen liiteluettelossa riittää.
