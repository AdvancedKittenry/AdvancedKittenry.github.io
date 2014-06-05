% Muokkausnäkymän toteuttaminen
<!-- order: 10 -->
<!-- tags: viikko4-java -->

Useimmissa tapauksissa lisäys- ja muokkauslomakkeet kannattaa toteuttaa
samalla tai ainakin hyvin samanlaisella koodilla. Kumpaankin voi käyttää
käytännössä samanlaista lomaketta. Erona lisäykseen on lähinnä se, että
muokkauslomake kannattaa esitäyttää muokattavan olion tietojen mukaan. 

## Mallin ja muokkauskontrollerin toteuttaminen

Tietokannan puolella muokkaamiseen käytetään `UPDATE`-lausetta,
jolle pitää muutettavien tietojen lisäksi kertoa 
mitä muutetaan `WHERE`-ehdossa.
Paras tapa kertoa tämä on antaa muutettavan rivin pääavaimen arvo.

~~~sql
UPDATE kissat SET nimi = ?, vari = ?, karvaisuus = ? WHERE id = ?
~~~

Update-lauseen ajavan koodin voi sijoittaa omaan metodiinsa samaan
tapaan kuin lisäysmetodi. 
Koodia kutsutaan kontrollerista rakentamalla olio, jolla on
oikea pääavaimen arvo sekä käyttäjän lomakkeella syöttämät
muokatut tiedot.

Olion luomisen voi toteuttaa kahdella eri tavalla,
yksinkertaisin tapa on rakentaa olio käsin:

**Yksinkertaisen muokkauskontrollerin alku**

~~~java
int id;
try {
  id = Integer.parseInt(request.getParameter("id"));
} catch(Exception e) {
  //Virhetilanne. Näytetään käyttäjälle virhe.
}

Kissa katti = new Kissa();
katti.setId(id);
katti.setNimi(request.getParameter("nimi"));
katti.setVari(request.getParameter("vari"));
katti.setKarvaisuus(request.getParameter("karvaisuus"));
~~~

Tämä tapa on nopeampi, sillä kannasta ei tarvitse hakea mitään.
Usein kuitenkin on parempi pyytää 
mallia hakemaan tietokannasta kyseinen rivi oliona, jolta voi sitten kutsua
settereitä.

~~~java
Kissa kissa = Kissa.etsi(id);
~~~

Tätä tapaa käytetään usein siihen, että varmistutaan
muokattavan rivin olemassaolosta.
Joskus halutaan myös muokata olioita, jota aivan kuka tahansa ei saa 
muokata. Rivi voi esimerkiksi olla juuri tietyn henkilön muistiinpano,
kissa tai muu vastaava tietue, johon kellään muulla ei ole asiaa.

Tässä tapauksessa joudut aina hakemaan tietokannasta
kyseessä olevan rivin tiedot ja tarkistamaan että sen oikeus- tai omistajatiedot
antavat kirjautuneen käyttäjän muokata kyseistä riviä.

**Muokkauskontrolleri olemassaolo- ja käyttöoikeustarkistuksin**

~~~java
Kissa kissa = Kissa.etsi(id);
Kayttaja kirjautunutKayttaja = (Kayttaja)session.getAttribute("kirjautunut");

if (katti == null) {
  // Näytetään käyttäjälle ilmoitus kadonneesta kissasta...
} else if (!katti.saakoMuokata(kirjautunutKayttaja)) {
  // Näytetään käyttäjälle ilmoitus oikeuksien puutteesta...
} else { 
  //Kissaa on mahdollista muokata
  katti.setNimi(request.getParameter("nimi"));
  katti.setVari(request.getParameter("vari"));
  katti.setKarvaisuus(request.getParameter("karvaisuus"));

  //Tähän tulee vielä tallennuskoodia
}
~~~

Tämän lisäksi päivityksen toteutuksessa on järkevää käyttää samaa tietojen kelpoisuuden tarkistamismekanismia, kuin lisäämisen kanssa.
Tarvittaessa kannattaa myös koodata malliluokkaan
metodi, joka tarkistaa saako tietty käyttäjä muokata oliota.

~~~java
if (katti.onkoKelvollinen()) {
  katti.tallennaMuokkaukset();
  //Näytetään käyttäjälle onnistumisviesti
} else {
  //Näytetään virheellinen lomake
}
~~~

## Näkymän toteuttaminen

Muokkausnäkymät toteutetaan siten, että muokkausnäkymäsivun kontrolleri ottaa muokattavan tietokohteen pääavaimen arvon GET-parametrina ja 
pyytää mallilta oikeaa riviä vastaavaan olion, joka sitten näytetään näkymässä.

Periaate on siis samanlainen, kuin 
[tietosivujen toteuttamisesta](listausnakymat.html#tietosivut),
mutta sen sijaan että näytettäisiin staattista tietoa, näytetään
lomake oikeilla tiedoilla.

Tämä pääavain pitää myös välittää lomakkeesta jotenkin päivitystä suorittavalle kontrollerille. 
Helpoin tapa on käyttää käyttäjälle näkymätöntä input-kenttää, jonka tyypiksi merkitään `"hidden"`:

~~~jsp
<input type="hidden" name="id" value="${kissa.id}">
~~~

Päivityksen toteutuksessa on järkevää käyttää samaa tietojen kelpoisuuden tarkistamismekanismia, kuin lisäämisen kanssa.

## Poistotoiminnot

Poisto toimii käytännössä samoin, kuin muokkaus, lomakkeen näyttäminen vain jätetään välistä ja suoritetaan suoraan poistokäsky kontrollerille välitetyn pääavaimen arvon perusteella.
Usein poiston aktivointiin kannattaa käyttää lomakkeisiin upotettuja poistonappeja ja POST-metodia.
Kannattaa myös varmistaa, että kulloisella käyttäjällä on oikeus tehdä poisto!

Malliluokan puolelle tarvitaan myös metodi(t), jolla voi poistaa rivejä. Toteutustapoja on kaksi:

* Instanssimetodi poistaa yhden olion kannasta.
* Staattinen metodi, jolla annetaan parametrina poistettavan olion pääavaimen arvo
    * Staattisella metodilla voi poistaa useitakin olioita.
 
SQL-syntaksi ja logiikka ovat varsin samanlaiset kuin muokkauksessa:

~~~sql
DELETE FROM kissat WHERE id = ?
~~~

<last>
Kun olet tehnyt täyden setin sivuja yhtä tietokohdetta varten, ja kirjoittanut dokumentaatioosi työsi 
[asennus- ja käyttöohjeen]({{rootdir}}dokumentaatio-ohje.html#asennustiedot),
viikon 4 työsi on valmis.
</last>
