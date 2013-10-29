% Käyttöliittymän suunnittelu
<!-- order: 2 -->
<!-- addHeaderNavigation -->

<summary>
* Luo aihekuvauksen perusteella alustava [käyttöliittymäkaavio](#k%C3%A4ytt%C3%B6liittym%C3%A4kaavio)
* Suunnittele sovelluksen yleinen näkymä ja päävalikko
    * Näiden kuuluu näkyä joka sivulla!
* Suunnittele listaus-, tieto- ja lomakesivut ohjeiden mukaisesti
</summary>

Aloita suunnittelu lukemalla valitsemasi aihekuvaus
ja miettimällä millaisiin sivuihin sovelluksesi
voisi jakautua. 
Otetaan esimerkiksi kuvitteellinen aihe "Kissatädin kissalista",
jonka aihekuvaus on seuraava:

<box>
Eerika Svinhufvud harrastaa kissojen keräilyä.
Hänellä on kartanossaan 127 kissaa ja kuuden hengen palveluskunta,
mutta heillä on jo pitkään ollut vaikeuksia koordinoida sitä
kuka ruokkii minkäkin kissan. Ratkaisuksi Eerika haluaa
ottaa käyttöön järjestelmän, jossa olisi jokaisen hänen kissansa
tiedot, sekä tieto siitä koska kukin kissa on viimeksi ruokittu.

Järjestelmällä olisi myös tieto jokaisen kissan roduista 
ja rotujen ominaisuuksista, sekä tieto siitä onko jokin kissoista 
lainassa jollakin ompeluseuran rouvista.

Lisäksi, jotta tiedettäisiin kuka on ruokkinut minkäkin
karvakasan, kukin palveluskunnan jäsen järjestelmään kirjautuisi 
järjestelmään omilla tunnuksillaan, joita kartanonomistaja hallinnoi.
</box>

## Käyttöliittymäkaavio

Keskimääräinen tietokantasovellus jakautuu 
suurinpiirtein viidentyyppisin sivuihin: etusivuihin, listauksiin,
dynaamisiin tietosivuihin, lomakesivuihin ja kirjautumiseen liittyviin sivuihin. 
Näistä joko kirjautuminen tai etusivu on se sivu, jonka
sovelluksen käyttäjä ensimmäiseksi näkee.
Etusivut esittelevät sovellusta, kertovat sen toiminnasta
ja antavat käyttäjälle ohjeita sovelluksen käyttöön. 
Ne liittyvät usein saumattomasti listauksiin, jotka
näyttävät listan jostain sovelluksen tietokohteesta. Tässä
tapauksessa esimerkiksi kissoista tai palveluskunnasta.
Listauksesta taas päästään yleensä suoraan erilaisille tieto- ja lomakesivuille,
jolla pystyy katselemaan, lisäämään tai muokkaamaan jonkin tietokohteen 
tietoja eli vaikkapa muokkaamaan yksittäisen kissan kuvausta.

Nämä mielessä pitäen lähde rakentamaan eri sivuista
ja toiminnoista karkeaa sivukarttaa, joka on dokumentaation
[käyttöliittymäkaavion]({{rootdir}}dokumentaatio-ohje.html#k%C3%A4ytt%C3%B6liittym%C3%A4) karkea luonnos. 
Suunnitelmaan kannattaa hahmotella mitä sivuja sovelluksessa on, 
mille sivuille niiltä pääsee ja mitkä sivuista olisi luonnollista sijoittaa
sovelluksen _päävalikkoon_, eli niihin linkkeihin, jotka ovat jokaisella sivulla näkyvissä.

<vinkki>
Suunnittelemiseen kannattaa käyttää _paperia ja kynää_, _valkotaulua_
tai jotain muuta välinettä, jolla luonnosteleminen on nopeaa.
Suunnitteluvaiheessa kaikenlaiset kaavio-ohjelmistot yleensä vain hidastavat ajattelua, 
ellei niiden käytössä ole erityisen rutinoitunut. 
</vinkki>

Kissalistan tapauksessa alustava suunnitelma voisi näyttää vaikkapa tältä:

![Alustava sivukartta]({{myimgdir}}sivukartta.png)

Kuten kuvasta huomaa, suunnitelman ei tarvitse tässä vaiheessa olla
erityisen siisti, riittää että sen perusteella tietää
mitä sivuja haluaa toteuttaa. 
Tässä kuvassa esimerkiksi on vielä sekaisin sivuja ja
sivuilla esiintyviä toimintoja, jotka eivät tarvitse omaa sivua
(esim. eri kohteiden poistot ja tallennukset).
Lopullisen siistin version voi huoletta jättää myöhemmäksi, 
sillä yleensä suunnitelmat kuitenkin muuttuvat työn edetessä.

Kun sivukartta on tehty, ota siitä kuva kännykkäkamerallasi
ja sijoita se repositoriosi doc-kansioon nimellä `sivukartta.jpg` (tiedostopäätteellä ei ole niin väliä).
Voit halutessasi myös skannata sen tai 
tehdä valmiin version jollain diagrammiohjelmalla. 

## Etusivu ja yleisnäkymä (template)

Lähde suunnittelemaan alustavasti etusivua
ja yleistä sivujen käyttöliittymää.
Tee samalla luonnos siitä millaisia yleisiä navigaatioelementtejä
sovelluksesi sivuille tulisi.
Pohdi myös haluatko sijoittaa jo etusivulle jonkun listauksen.
Esimerkiksi kissalistan etusivulle tulee suoraan lista kissoista,
sekä kaksiosainen navigaatioyläpalkki, jossa on linkit 
tärkeimpiin tietokohteisiin ja uloskirjautumiseen:

![Kissalistan etusivu]({{myimgdir}}etusivu.png)

Kun on kerran piirtänyt joka sivulla olevan navigaation, voi 
sen jättää muista piirroksista pois. 
Navigaation on kuitenkin tultava lopullisessa 
sovelluksessa joka sivulle. 
Ainoana poikkeuksena toimii kirjautumissivu, joka 
näyttää useimmiten tältä:

![Kirjautumislomake]({{myimgdir}}kirjautuminen.png)

## Listanäkymän suunnittelu

Tietokohteen listausta suunnitellessa tärkeintä ovat helppous ja selkeys.
Yksinkertaisimmillaan listaus voi olla pelkkä lista listattavien asioiden nimiä,
koodeja tai muita vastaavia tunnisteita, josta nimeä klikkaamalla pääsee käsiksi
lisätietoihin.  Usein on kuitenkin hyvä listata sovelluksen toiminnan kannalta
olennaisimmat tiedot (joskus peräti kaikki tiedot) listaukseen, jolloin tietoa
on helppo ja nopea löytää. Liikaa tietoa ei kuitenkaan yhteen näkymään kannata
ahtaa, sillä se vaikeuttaa olennaisten asioiden löytämistä.

Mikäli lista on hyvin pitkä, näytetään tarvittaessa siitä vain 
osa ja mahdollistetaan loppuosan selailu _sivunavigaation_ avulla.
Myös hakutoimintojen liittämistä sovellukseen kannattaa harkita,
varsinkin jos lista on pitkä ja sivutettu. Lyhyemmissä listoissa
voidaan turvautua selaimen hakutoimintoon. 
Myös listan näyttäminen aakkosjärjestyksessä helpottaa siitä hakemista.

![Kissalista, aakkosjärjestys tosin näkyy unohtuneen suunnittelijalta]({{myimgdir}}kissalista.png)

Listaa suunnitellessa kannattaa muistaa, että listalla on käytännössä kaksi
käyttötarkoitusta: tiedon ylimalkaisen selailun mahdollistaminen ja pääsy
yksittäistä kohdetta käsitteleville tieto- ja muokkaussivuille.  Yleensä
listan kohdetta klikkaamalla pääsee joko tarkastelemaan sivua, jolla on
siitä lisätietoja tai suoraan muokkaamaan sitä lomakkeella.  Lisätiedot ja
lomakkeeet ovat yleensä omalla sivullaaan, mutta joskus on pätevää myös
upottaa se suoraan listauksen sisään, mahdollisesti niin, että se näytetään
dynaamisesti javascriptillä. 

Myös erilaiset yleisesti käytetyt toiminnot esim. asioiden poistaminen,
aktivoiminen tai sulkeminen, tai vaikka kissojen syöttäminen saattaa olla
järkevä laittaa listalle suoraan erilaisten nappien muodossa.  Samaan
tapaan uuden kohteen lisääminen listaan on yleensä luontevaa laittaa listan
yhteyteen joko erillisenä linkkinä tai nappina, tai lomakkeena listan
ohessa.

## Muokkaus- ja tietonäkymät

Muokkaus- ja tietonäkymissä näkyy kaikki johonkin yksittäiseen
tietokohteeseen, esimerkiksi kissaan, liittyvä informaatio yhdellä selkeällä sivulla.
Sivutyyppien ero on siinä, että tietosivu vain näyttää sisältöä 
antamatta suoraa mahdollisuutta muokata sitä,
muokkaussivut taas koostuvat yleensä lomakkeista ja toimintonapeista, joilla
kohdetta voi muokata. 

Yleensä nämä sivut on myös jollain tapaa linkitetty toisiinsa, 
joskin joskus linkitys näkyy vain mikäli senhetkisellä käyttäjällä 
on oikeus muokata kyseessä olevaa tietoa. 

Kissalistan tapauksessa suunnittelija ei ole nähnyt yksittäisen 
kissan tietosivulle tarvetta, mutta muokkaussivu on tehty:

![Kissan tietojen muokkaus- ja syöttölomake]({{myimgdir}}kissalomake.png)

Varsinaisen päämuokkauslomakkeen ohessa sivulla on kasa muita toimintoja.
Sivulta löytyvät erillinen kommentointiosio ja 
napit kissan poistamiseen, lainaamiseen sekä uuden kuvan laittamiseen.
Näistä toiminnoista avautuvat sivut ovat yleensä keveämpiä yhden lomakkeen sivuja:

![Muutamia muokkauksen alitoimintoja]({{myimgdir}}misc.png)

Yleensäottaen jonkin tiedon lisäämis ja muokkaamissivut ovat melko samanlaisia
pienillä variaatioilla. Voit halutessasi suunnitella erikseen lisäysnäkymän tai
piirtää suunnitelmastasi hybridin, joka tulee toimimaan sekä lisäys- että
muokkausnäkymän pohjana.

<next>
Kun olet suunnitellut mielestäsi toimivan käyttöliittymän, 
suunnittele työllesi [tietokanta ja dokumentoi se](tietokanta.html).

Vaihtoehtoisesti toteuta suunnittelemasi käyttöliittymä [HTML:llä]({{rootdir}}ohjeistus/html-opas.html). Ja syvenny sitten tietokantoihin.
</next>
