% Viikko 4
<!-- order: 1 -->

<deadline>{{deadline4}}</deadline>

Työaiheet neljännellä viikolla lyhyesti:

* [Tietokannan kokeilu ja yhteydenotto](tietokantayhteys.html)
* [Tietokantaa käyttävän mallin luominen](mallit.html)
* [Lomakkeiden ja sivujen toteuttaminen](nakymat.html)

## Nelosviikon deadline

Palautuspäivämäärään mennessä työn on täytettävä seuraavat vaatimukset:

* Tietokantayhteys toimii, ja sen luonti on sijoitettu omaan metodiinsa/funktioonsa.
* Luotu ainakin yksi malliluokka, joka:
    1. Sisältää staattisia metodeja, jotka hakevat kannasta eri kriteerein rivejä olioiksi. (Esim. kissalistan hakutoiminto, yksittäisen kissan hakeminen id-numerolla yms.)
    2. Sisältää metodin, joka lisää olion kantaan (INSERT-lause).
    3. Sisältää metodin, joka päivittää olion tiedot kantaan (UPDATE-lause).
    4. Sisältää metodin joka poistaa olion kannasta, voidaan toteuttaa myös staattinen metodi, joka poistaa hakuehdolla rivejä taulusta.
* Käytetty SQL-koodi on turvallinen, eikä tarjoa mahdollisuuksia SQL-injektioille.
* Luotu sivut, jossa edellä mainittuja malliluokan toimintoja käytetään hyväksi. Käytettävyyden pitää olla kohdallaan:
    * Sivuilla selkeät virheilmoitukset kaikista virhetilanteista ja lomakkeiden syöttövirheistä.
    * Lomakkeen kontrolleri ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
        * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Väärin syötetyt tiedot kerrotaan virheilmoituksin.
    * Tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms.

<ohje>
Aloita [tietokantayhteyden luomisesta](tietokantayhteys.html) ja seuraa vihreitä ohjelaatikoita.

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>
