% Viikko 3
<!-- order: 1 -->

<deadline>{{deadline3}}</deadline>

Kolmannen viikon pääteemana on tutustua 
hyvän arkkitehtuurin mukaiseen koodaamiseen
ja toteuttaa kirjautuminen.

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset.
Kunkin otsikon alla olevista asioista saa suluissa määritellyt aikataulupisteet.

## MVC-arkkitehtuuri (1p)

* Sovelluksen logiikkaa on eritelty kontrollereista malleihin ja näkymiin [MVC-mallin mukaisesti][arkkitehtuuri].
* HTML-koodia ei enää tuoteta muualla kuin näkymissä.
* Tietokannan käsittely keskitetty malliluokkiin.
* Sivulta toiseen samana toistuva HTML-koodin runko on sijoitettu erilliseen HTML-pohjatiedostoon, niin ettei sitä toisteta turhaan joka näkymässä.

## Kirjautuminen (2p)

* Sovelluksessa on malliluokka tai luokat käyttäjien ja kirjautumisen käsittelyyn. Toteutuksessa pitää käyttää tietokantaa ja istuntoa.
* Sovelluksessa on kirjautumislomake ja kontrolleri, joka ottaa lomakkeen lähettämät tiedot vastaan
* Kirjautuneelle käyttäjälle varattuihin toimintoihin ei päästetä kirjautumatta
* Käyttäjä ohjataan takaisin kirjautumissivulle, mikäli tiedot on virheellisesti täytetty. 
    * Käyttäjälle annetaan virheilmoitus jos kirjautuminen ei onnistu.

Kirjautumista toteuttaessa kannattaa koota yleisesti käytetyt toiminnot koottuna yhteen luokkaan tai tiedostoon:

* Näkymän näyttäminen sivupohjan kanssa yhdellä funktiokutsulla
* Selaimen ohjaus toiselle sivulle (HTTP redirect, toteuttaminen vapaaehtoinen)
* Virheilmoitusten näyttäminen käyttäjälle.
* PHP:llä `[session_start](http://www.php.net/session_start)`-funktion kutsuminen kannattaa sijoittaa tähän tiedostoon.

Laita linkki kirjautumissivuusi myös [esittelysivusi](esittelysivu.html)
linkkilistaan. Lisää sivulle myös kappale tunnuksista, joilla sovellusta voi testata.
Mallia voi katsoa 
[valmiin sivun näköisversiosta]({{rootdir}}src/{{curdir}}esittelysivu/esittelysivu-lopullinen.html).

Mikäli sovelluksessa ei ole lainkaan kirjautumistoimintoja, sovi ohjaajasi kanssa jokin toinen tavoite viikolle 3.
Yleensä ottaen kirjautumisdeadline voidaan korvata tekemällä alustava versio jostain lisäys- ja muokkauslomakkeesta.

<ohje>
Aloita lukemalla [arkkitehtuuriohje][arkkitehtuuri]
ja jatka sitten vihreitä ohjelaatikoita seuraamalla 
käyttämäsi kielen toteuttamisohjeisiin.

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät sekä
GitHub-repositoriossasi että esittelysivullasi users-palvelimella.
</ohje>

[arkkitehtuuri]: {{rootdir}}koodaaminen/arkkitehtuuri/index.html
