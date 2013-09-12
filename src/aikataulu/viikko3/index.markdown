% Viikko 3
<!-- order: 1 -->

<deadline>{{deadline3}}</deadline>

Kolmannen viikon pääteemana on aloittaa 
hyvän arkkitehtuurin mukainen koodaaminen
ja toteuttaa kirjautuminen.

<wip />

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset:

* Työssä on noudatettu [arkkitehtuuriohjeen MVC-kolmijakoa](arkkitehtuuri.html)
* Toteutettu yleinen luokka perusasioihin
    * Osaa näyttää näkymän niin, että siihen haetaan 
      erillisestä näkymätiedostosta sovelluksen käyttöliittymä ja navigaatio.
    * Osaa ohjata selaimen toiselle sivulle (HTTP redirect)
    * Tarjoaa tavan näyttää käyttäjälle virheilmoituksia, jotka näytetään automaattisesti sivuilla, jos jokin menee pieleen.
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
* Yksinkertainen lomakekäsittelijä
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
Aloita lukemalla [arkkitehtuuriohje](arkkitehtuuri.html).

Ohjeiden jälkeen ei valitettavasti ole vielä sisältöä siitä miten 
ohjelmat kannatta toteuttaa, mutta sitä on tulossa lisää lähipäivien aikana.

<!-- ja seuraa vihreitä ohjelaatikoita. -->

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>
