% Viikko 4
<!-- order: 1 -->

<deadline>{{deadline4}}</deadline>

<comment>
Työaiheet neljännellä viikolla lyhyesti:

* Varmista että aikaisemmin kirjoittamasi sql-lauseet toimivat siten tietokantataulusi ovat nyt pystyssä kannassa
* Tietokantayhteyden luonti
    Javalle: postgresql-siltaus
      ssh
      putty
    Oma luokkansa?


???
* SQL-injektiot ja hyvä sql-koodi
* XSS-injektiot
* Mallien kirjoittaminen, osa 2
Viikko 4
  Tietokantayhteyden käyttö malliluokassa
    Syöttäminen
    Erilaisten hakijoiden tekeminen
    Poistot
    Muokkaukset
      Miten ihmeessä?? Muutetaan kaikki kerralla?
  Tehdään koko setti:
    Listaus
    Tietosivu
    Lomake
      Lisäys
      Muokkaus
      Käytettävyys!!
    Poisto
</comment>

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
    * Lomakkeen käsittelijä ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
        * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Väärin syötetyt tiedot kerrotaan virheilmoituksin.
    * Tiedot näkyvät sivuilla oikein myös silloin kun käyttäjä on syöttänyt niiden sekaan HTML:ää, lainausmerkkejä yms.
        * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
        * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`

<comment>
<ohje>
Aloita [tästä](404.html) ja seuraa vihreitä ohjelaatikoita.

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät GitHub-repositoriossasi.
</ohje>
</comment>
