% Muokkausnäkymän toteuttaminen
<!-- order: 8 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta.

<comment>
Tehdään koko setti:
  Listaus
  Tietosivu
  Lomake
    Lisäys
    Muokkaus
    Käytettävyys!!
  Poisto
</comment>

* Lisäys- ja muokkauslomakkeet kannattaa toteuttaa samalla tai ainakin hyvin samanlaisella koodilla.
* Muokkaustoiminnot kannattaa toteuttaa niin, että sivun kontrolleri ottaa muokattavan tietokohteen id:n tai muun avaimen GET-parametrina ja näyttää sen perusteella oikean kohteen.
    * Poisto ym. vastaavat toiminnot toimivat käytännössä samoin. Usein niiden aktivointii kannattaa tosin käyttää lomakkeisiin upotettuja nappeja ja POST-metodia.
* Muokkauslomake koodataan näyttämään GET-parametrin määrittämän olion tiedot valmiina kentissä. 
    * Olio haetaan mallilta sopivalla metodilla.
    * Malli ei koskaan käsittele GET- tai POST-parametreja suoraan vaan ne kontrolleri välittää ne parametreina mallin metodeille.
* Lomakkeen kontrolleri ohjaa takaisin lomakesivulle, mikäli lomake on virheellisesti täytetty.
    * Lomakesivulla tällöin näkyvissä ne tiedot, jotka käyttäjä siihen syötti.
        * Tiedot voidaan näyttää antamalla lomakkeelle näytettäväksi malliluokan olio, johon on asetettu käyttäjän syöttämät lomaketiedot.
    * Väärin syötetyt tiedot eritellään vielä virheilmoituksin. Mieluiten kaikki kerrallaan.
* Sekä lomakkeita, että sivunäkymiä näytettäessä kannattaa varmistaa, etteivät käyttäjän syöttämät HTML-koodinpätkät, lainausmerkit yms.
  sotke sivujen rakennetta.
    * PHP:ssä [htmlspecialchars-funktio](http://www.php.net/manual/en/function.htmlspecialchars.php) auttaa: `<?php echo htmlspecialchars($muuttuja); ?>`
    * Javassa voi käyttää [out-tägiä](http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs/): `<c:out value="${muuttuja}"/>`

## Istunnon käyttäminen ilmoitusten ja virheiden näyttämiseen

Lyhyt esimerkki, selitykset tulossa:

**Kontrollerissa**

~~~inlinephp
  $uusikatti->lisaaKantaan();
  
  //Äsken lisättiin kantaan onnistuneesti kissa,
  //lähetetään käyttäjä eteenpäin listasivulle:
  header('Location: kissalista.php');
  //Asetetaan istuntoon ilmoitus siitä, että kissa on lisätty:
  $_SESSION['ilmoitus'] = "Kissa lisätty onnistuneesti.";
~~~

**Näkymien pohjatiedostossa**

~~~php
<?php if (!empty($_SESSION['ilmoitus'])): ?>
<?php unset($_SESSION['ilmoitus']); ?>
  <div class="alert alert-danger">
    <?php echo $_SESSION['ilmoitus']; ?>
  </div>
<?php endif; ?>
~~~


<last>
Kun olet tehnyt täyden setin sivuja yhtä tietokohdetta varten, viikon 4 työsi on valmis.
</last>
