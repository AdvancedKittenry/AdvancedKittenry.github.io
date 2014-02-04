% Muokkausnäkymän toteuttaminen
<!-- order: 10 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta. Samat suunitteluperiaatteet pätevät kuitenkin kummallakin kielellä.

<comment>
Tehdään koko setti:
  Listaus
  Tietosivu
  Lomake
    Lisäys
    Muokkaus
    Käytettävyys!!
  Poisto

* Päivittämiseen tarvitaan vastaavaa metodia, joka ajaa UPDATE-lauseen
* samoin poistamiselle on tarpeen DELETE-lauseen ajava instanssimetodi.
</comment>

* Lisäys- ja muokkauslomakkeet kannattaa toteuttaa samalla tai ainakin hyvin samanlaisella koodilla.
* Muokkaustoiminnot toteutetaan niin, että sivun kontrolleri ottaa muokattavan tietokohteen id:n tai muun avaimen GET-parametrina ja näyttää sen perusteella oikean kohteen.
    * Poisto ym. vastaavat toiminnot toimivat käytännössä samoin. Usein niiden aktivointii kannattaa tosin käyttää lomakkeisiin upotettuja nappeja ja POST-metodia.
* Muokkauslomake koodataan näyttämään GET-parametrin määrittämän olion tiedot valmiina kentissä. 
    * Olio haetaan mallilta sopivalla metodilla.
    * Malli ei koskaan käsittele GET- tai POST-parametreja suoraan vaan ne kontrolleri välittää ne parametreina mallin metodeille.
* Toteutukseessa on järkevää käyttää samaa tietojen kelpoisuuden tarkistamismekanismia, kuin lisäämisen kanssa.

## Poistotoiminnot

* Tarvitaan myös metodi(t), jolla voi poistaa rivejä.
    * Instanssimetodi poistaa kyseisen olion kannasta.
    * Staattisella metodilla voi poistaa useitakin olioita.

<last>
Kun olet tehnyt täyden setin sivuja yhtä tietokohdetta varten, viikon 4 työsi on valmis.
</last>
