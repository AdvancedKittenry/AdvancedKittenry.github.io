% Muokkausnäkymän toteuttaminen
<!-- order: 10 -->

<wip />

Tämän sivun Java-versio on valitettavasti tällä hetkellä vielä klooni PHP-versiosta. Samat suunitteluperiaatteet pätevät kuitenkin kummallakin kielellä.

Yleensä lisäys- ja muokkauslomakkeet kannattaa toteuttaa samalla tai ainakin hyvin samanlaisella koodilla.
Kumpaankin käytetyt lomakkeet ovat useimmiten lähes samanlaisia, mutta lisäyksestä poiketen
lomake on esitäytetty muokattavan olion tietojen mukaan. 

Tämä toteutetaan siten, että sivun kontrolleri ottaa muokattavan tietokohteen pääavaimen arvon GET-parametrina ja 
pyytää mallilta oikeaa riviä vastaavaan olion, joka sitten näytetään näkymässä.
Periaate on siis samanlainen, kuin 
[tietosivujen toteuttamisesta](listausnakymat.html#tietosivut)

Erona lisäykseen on tietenkin myös suoritettava SQL-koodi, jolle pitää muutettavien tietojen lisäksi kertoa `WHERE`-ehdossa muutettavan rivin pääavaimen arvo.

Päivityksen toteutukseessa on järkevää käyttää samaa tietojen kelpoisuuden tarkistamismekanismia, kuin lisäämisen kanssa.

~~~sql
UPDATE kissat SET nimi = ?, vari = ?, karvaisuus = ? WHERE id = ?
~~~

Tämä pääavain pitää myös välittää lomakkeesta jotenkin päivitystä suorittavalle kontrollerille. 
Helpoin tapa on käyttää käyttäjälle näkymätöntä input-kenttää, jonka tyypiksi merkitään `"hidden"`:

~~~php
<input type="hidden" name="id" value="<?php echo $data->kissa->getId(); ?>">
~~~

## Poistotoiminnot

Poisto toimii käytännössä samoin, kuin muokkaus, lomakkeen näyttäminen vain jätetään välistä ja suoritetaan suoraan poistokäsky kontrollerille välitetyn pääavaimen arvon perusteella.
Usein poiston aktivointiin kannattaa käyttää lomakkeisiin upotettuja poistonappeja ja POST-metodia.
Kannattaa myös varmistaa, että kulloisella käyttäjällä on oikeus tehdä poisto!

Malliluokan puolelle tarvitaan myös metodi(t), jolla voi poistaa rivejä.
Toteutustapoja on kaksi:

  * Instanssimetodi poistaa yhden olion kannasta.
  * Staattisella metodilla voi poistaa useitakin olioita.
 
SQL-syntaksi:

~~~sql
DELETE FROM kissat WHERE id = ?
~~~

<last>
Kun olet tehnyt täyden setin sivuja yhtä tietokohdetta varten, viikon 4 työsi on valmis.
</last>
