% Yleisnäkymän suunnittelu
<!-- order: 1 -->

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

Keskimääräinen tietokantasovellus jakautuu 
suurinpiirtein neljäntyyppisin sivuihin: etusivuihin, listauksiin,
lomakesivuihin ja kirjautumiseen liittyviin sivuihin. 
Näistä joko kirjautuminen tai etusivu on se sivu, jonka
sovelluksen käyttäjä ensimmäiseksi näkee.
Etusivut esittelevät sovellusta, kertovat sen toiminnasta
ja antavat käyttäjälle ohjeita sovelluksen käyttöön. 
Ne liittyvät usein saumattomasti listauksiin, jotka
näyttävät listan jostain sovelluksen tietokohteesta. Tässä
tapauksessa esimerkiksi kissoista tai palveluskunnasta.
Listauksesta taas pääsee erilaisille lomakesivuille,
jolla pystyy lisäämään tai muokkaamaan jonkin tietokohteen 
tietoja eli vaikkapa yksittäistä kissaa.

Nämä mielessä pitäen lähde rakentamaan eri sivuista
ja toiminnoista karkeaa sivukarttaa, joka on dokumentaation
[käyttöliittymäkaavion]({{rootdir}}dokumentaatio-ohje.html#k%C3%A4ytt%C3%B6liittym%C3%A4) karkea luonnos. 
Suunnitelmaan kannattaa hahmotella mitä sivuja sovelluksessa on, 
mille sivuille niiltä pääsee ja mitkä sivuista olisi luonnollista sijoittaa
sovelluksen _päävalikkoon_, eli niihin linkkeihin, jotka ovat jokaisella sivulla näkyvissä.

<info>
Suunnittelemiseen kannattaa käyttää _paperia ja kynää_, _valkotaulua_
tai jotain muuta välinettä, jolla luonnosteleminen on nopeaa.
Suunnitteluvaiheessa kaikenlaiset kaavio-ohjelmistot yleensä vain hidastavat ajattelua, 
ellei niiden käytössä ole erityisen rutinoitunut. 
</info>

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

Kun sivukartta on tehty, lähde suunnittelemaan alustavasti etusivua
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

<comment>
    * Etusivun suunnittelu
    * Tätä kannattaa tulla tekemään pajaan
</comment>

<ohje>
Tehtyäsi sivukartan, yleisnäkymän ja etusivun on aika suunnitella [listanäkymiä](listanakyma.html).
</ohje>
