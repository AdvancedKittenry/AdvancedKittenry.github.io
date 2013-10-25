% Viikko 3
<!-- order: 1 -->
<!-- hidden! -->

<deadline>{{deadline3}}</deadline>

Kolmannen viikon pääteemana on aloittaa 
hyvän arkkitehtuurin mukainen koodaaminen
ja toteuttaa kirjautuminen.

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset:

<comment>
TODO:
* Työssä on noudatettu arkkitehtuuriohjeen MVC-kolmijakoa ja koodi on siistiä
* Sovellukseen kirjautumisesta kirjoitettu malliluokka/tiedosto
* Virheilmoitusmekanismi
* Ei päästetä näkymiin kirjautumatta
* HTML-demo: lomakesivut
* HTML-demo: listasivut
</comment>

* Työssä on noudatettu [arkkitehtuuriohjeen MVC-kolmijakoa][arkkitehtuuri]
* Sivuille on luotu erillinen sivupohjatiedosto, joka sisältää jokaiselle sivulle tulevat asiat.
    * Java:lla helpointa käyttää [JSP-tägikirjastoa](java/rakenne.html#template-pohjatiedoston-k%C3%A4ytt%C3%B6)
    * PHP:lle tulossa oma ohje, joka perustuu [include-funktion](http://php.net/manual/en/function.include.php) käyttöön
* Yleisesti käytetyt toiminnot koottu yhteen luokkaan tai tiedostoon
    * Näkymän näyttäminen sivupohjan kanssa yhdellä funktiokutsulla
    * Selaimen ohjaus toiselle sivulle (HTTP redirect, toteuttaminen vapaaehtoinen)
    * Virheilmoitusten näyttäminen käyttäjälle.
    * PHP:llä `session_start`-funktion kutsuminen kannattaa sijoittaa tähän tiedostoon.
* Sovellukseen kirjautuminen toimii
    * Käyttää valitsemasi kielen istuntotukea kirjautumisen muistamiseen
    * Ei tarvitse käyttää vielä tietokantaa
    * Antaa käyttäjälle virheilmoituksen jos kirjautuminen ei onnistu
    * Ohjaa jollekin näkymäsivulle (esim. etusivu), kun kirjautuminen onnistuu
        * Näkymäsivu ei päästä käyttäjää sisään/näyttää 
          erilaiselta jos käyttäjä ei ole kirjautunut.
* Mikäli sovelluksessa ei ole lainkaan kirjautumistoimintoja, tee alustava versio jostain lisäys- ja muokkauslomakkeesta.

<comment>

* Yleistä arkkitehtuurista
  * Template-tiedostojen käyttö (php, java)
  * Mallien kirjoittaminen
* Yksinkertainen lomakekontrolleri
* Istunnot, kirjautuminen ja virhetilanteet
  * Käytettävyys

Mistä aloitetaan?

TODO:
* Laita melkein kaikki eri kielille spesifeihin tiedostoihin
* Java
    * Welcome pages
    * Kansiot: models, servlets
    * Abstrakti emäservlet
* PHP
    * Kansiot: models, views, mihin hittoon controllerit laitetaan?
    * ???
    * Profit
</comment>

<ohje>
Aloita lukemalla [arkkitehtuuriohje][arkkitehtuuri].
Siirry sitten käyttämäsi kielen kirjautumisen toteuttamisohjeisiin:

* [Kirjautuminen PHP:llä](php/index.html)
* [Kirjautuminen Javalla](java/index.html)


Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>

[arkkitehtuuri]: {{rootdir}}mvc-opas.html
