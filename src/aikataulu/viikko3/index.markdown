% Viikko 3
<!-- order: 1 -->

<deadline>{{deadline3}}</deadline>

Kolmannen viikon pääteemana on tutustua 
hyvän arkkitehtuurin mukaiseen koodaamiseen
ja toteuttaa kirjautuminen.

<wip />

Näillä sivuilla ei valitettavasti vielä ole kunnollista ohjeistusta virheilmoitusten toteuttamisesta.

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset:

<comment>
TODO:
* Virheilmoitusmekanismi
* Käytettävyys
</comment>

## MVC-arkkitehtuuri (1p)

* Sovelluksen logiikkaa on eritelty kontrollereista malleihin ja näkymiin [MVC-mallin mukaisesti][arkkitehtuuri].
* Sivuille on luotu erillinen sivupohjatiedosto, joka sisältää jokaiselle sivulle tulevat asiat.
    * Java:lla helpointa käyttää [JSP-tägikirjastoa]({{rootdir}}ohjeistus/tietokantaohjelmointi/java/rakenne.html#template-pohjatiedoston-k%C3%A4ytt%C3%B6)
    * PHP:lle tulossa oma ohje, joka perustuu [include-funktion](http://php.net/manual/en/function.include.php) käyttöön

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
* PHP:llä `session_start`-funktion kutsuminen kannattaa sijoittaa tähän tiedostoon.

Mikäli sovelluksessa ei ole lainkaan kirjautumistoimintoja, sovi ohjaajasi kanssa jokin toinen tavoite viikolle 3.
Yleensä ottaen kirjautumisdeadline voidaan korvata tekemällä alustava versio jostain lisäys- ja muokkauslomakkeesta.

<ohje>
Aloita lukemalla [arkkitehtuuriohje][arkkitehtuuri].
Siirry sitten käyttämäsi kielen toteuttamisohjeisiin:

* [PHP-ohjeet]({{rootdir}}ohjeistus/tietokantaohjelmointi/php/index.html)
* [Java-ohjeet]({{rootdir}}ohjeistus/tietokantaohjelmointi/java/index.html)

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>

[arkkitehtuuri]: {{rootdir}}ohjeistus/tietokantaohjelmointi/arkkitehtuuri/index.html
