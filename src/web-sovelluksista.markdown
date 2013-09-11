% Web-sovelluksien toiminta
<!-- addHeaderNavigation -->

Web-sovellusohjelmointi eroaa normaalista
sovellusohjelmoinnista monellakin saralla. 
Tällä sivulla selostetaan tärkeimmät termit ja eroavaisuudet.

## Asiakkaat ja palvelimet

Web-sovelluksien toiminta on aina jakautunut vähintään
kahteen eri paikkaan: ohjelman käyttäjän
tietokoneessa pyörivä _selainohjelmaan_, joka osaa näyttää HTML-kielellä tehtyjä verkkosivuja
sekä verkon takana olevaan _palvelimeen_, joka tuottaa ja lähettää pyynnöstä verkkosivun sisällön selaimelle.

![Palvelin ja asiakas]({{imgdir}}asiakas-palvelinmalli.gif)

Palvelimien sisälläkin ohjelman suoritus jakautuu lähes aina osiin.
Sivuja tuottavat ohjelmat pyörivät jonkin HTTP-palvelimen,
esimerkiksi [Apachen](http://httpd.apache.org/) tai [Tomcatin](http://tomcat.apache.org/) alaisuudessa.
Tietojen säilytykseen taas käytetään erillistä tietokantapalvelinta,
vaikkapa [PostgreSQL:ää](http://www.postgresql.org/).

## Aineistopyynnöt

Palvelimella pyörivän ohjelman suoritus alkaa 
selaimen tekemästä _[HTTP-protokollalla](http://fi.wikipedia.org/wiki/HTTP)_ tekemästä _aineistopyynnöstä_ (engl. _request_).
Tämä tapahtuu joko manuaalisesti linkin klikkauksen, lomakkeen lähettämisen,
tai selaimen osoitekentän käytön seurauksena,
tai automaattisesti esim. sivulla olevan kuvan hakemisen muodossa.

Jokainen aineistopyyntö esitetään _[URL (Universal Resource Locator)](http://fi.wikipedia.org/wiki/URL) –muodossa_.
Esim. http://cs.helsinki.fi/opiskelu hakee laitoksemme sivuilta kurssilistan.
Pyynnöillä voidaan hakea joko staattisia tiedostoja, esim. html-tiedostoja tai kuvia,
tai dynaamista sisältöä, jotka tuottaa jokin ohjelma.
Suurin osa tietokantasovelluksessa tuotettavista sivuista on näitä dynaamisia sivuja.

### GET ja POST

Aineistopyyntöjen mukana voi kulkea kolmenlaista tietoa:
selain voi lähettää palvelimelle _evästeitä_, minkä lisäksi
aineistopyynnöt jakautuvat kahteen tyyppiin: _GET- ja POST-pyyntöihin_.

GET-pyynnöt ovat yleisempiä ja niiden mukana välitetään vain evästeet
ja osoitteeseen kirjoitetut _GET-parametrit_, jotka kirjoitetaan osoitteeseen tiedostonimen
perään seuraavaan tapaan `http://sivusto.fi/index.php?parametri=arvo&toinenParametri=43`.
POST-pyynnöt lähetetään yleensä lomakkeita lähettäessä ja niissä käytettävät _POST-parametrit_
upotetaan piilotettuna aineistopyynnön otsakkeiden sisään (itseasiassa hyvin samaan tapaan kuin evästeet).
Myös POST-pyynnöissä voi käyttää GET-parametreja, joskin se on harvinaisempaa.

Semanttisesti pyynnöt eroavat siten, että GET-pyyntö katsotaan pyynnöksi näyttää jotain tietoa,
kun taas POST-pyynnöillä yleensä muutetaan jotakin, esim. kirjoitetaan tietokantaan.
Selaimet esimerkiksi kysyvät refresh-nappia painaneelta käyttäjältä 
haluaako hän varmasti ladata sivun uudestaan, mikäli kysessä on POST-pyyntö, 
sillä yleensä pyynnön tekemiä muokkauksia ei haluta toistaa.

![Tyypillinen aineistopyyntö]({{imgdir}}aineistopyynto.gif)

Sen jälkeen, kun pyynnön vaatima sivu tai muu resurssi on löydetty tai
tuotettu palvelimella olevalla ohjelmalla, lähetetään se selaimelle
yleensä html-koodina.
Selain tulkitsee tästä koodista, sekä mahdollisesti mukana tulevista kuvista
ja css-määrittelyistä sen miltä sivun kuuluisi näyttää. 
Selain myös suorittaa mahdolliset sivujen mukana tulevat javascript-ohjelmat,
ja vastaanottaa ja tallentaa palvelimen lähettämät evästeet.

### Tilatiedon hallinta ja samanaikaiset aineistopyynnöt

Viimeinen huomionarvoinen puoli web-ohjelmoinnissa on se, että 
kukin palvelupyyntö on teknisesti täysin erillinen muista palvelupyynnöistä.
Lisäksi palvelupyyntöjä voi tulla useita samanaikaisesti useammiltakin käyttäjiltä.

Näiden pyyntöjen vastauksia tuottavat ohjelmat ajetaan joka pyynnölle erikseen,
eivätkä ohjelmien suoritukseen liittyvät muuttujat ja tietorakenteet säästy
suorituskerrasta toiseen ellei niitä erikseen tallennetta käyttäen 
evästeitä, _istuntoja_ tai tietokantaa, joissa tieto säilyy.

Nykyään lähes kaikki web-sovellukset tallentavat evästeitä käyttäen
vähintään jonkin istuntotunnuksen, jolla käyttäjä voidaan identifioida
aineistopyyntöjen välillä. Istuntotunnuksen perusteella voidaan järjestää pääsy palvelimen säilyttämiin istuntokohtaisiin tietoihin.
Joskus käytetään myös lomakkeisiin upotettuja piilokenttiä joidenkin tilatietojen välittämiseen.

![Useiden aineistopyyntöjen kanssakäyti]({{imgdir}}kaksi-aineistopyyntoa.gif)

