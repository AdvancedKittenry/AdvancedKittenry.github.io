% Tietokannan dokumentointi
<!-- order: 13 -->
<!-- tags: viikko2 -->

<summary>
* Luo dokumentaatioon asiaanliittyvät kaaviot ja kappaleet: 
    * [Järjestelmän tietosisältö]({{rootdir}}dokumentaatio-ohje.html#j%C3%A4rjestelm%C3%A4n-tietosis%C3%A4lt%C3%B6)
    * [Relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio)
* Sijoita uudet kappaleet samaan pdf-tiedostoon kuin aikaisempikin dokumentaatio
</summary>

<alert>
Laita kaikki uusi dokumentaatio kootusti yhteen `dokumentaatio.pdf`-tiedostoon `docs`-kansiossa. Ohjaajasi ei halua arvuutella mistä tiedostosta dokumentaatio löytyy.
</alert>

Tee lista kunkin kaavion tietokohteen
sisältämistä tietokentistä, niiden tyypeistä ja rooleista sovelluksessa.
Liitä kenttien kuvaukset taulukkoina dokumentaatioon. 
Myös yhteydet toisiin kohteisiin täytyy määritellä. 
Lopputuloksen kuuluu näyttää tämäntapaiselta:

> **Tietokohde: Kissa**
> 
> ------------------------------------------------------------------------
> Attribuutti          Arvojoukko         Kuvailu
> -------------------- ------------------ -------------------------------
> Nimi                 Merkkijono,        Kissan nimi
>                      max. 80 merkkiä    
> 
> Väri                 Merkkijono,        Kuvaus kissan väristä
>                      max. 30 merkkiä    esim. "valkotäplikäs oranssi"
> 
> Viim. ruokkimis-pvm. Päivämäärä         Koska kissa on viimeksi ruokittu?
> 
> Lisätiedot           Merkkijono,        Kuvaus kissan ominaisuuksista
>                      max. 255 merkkiä   esim. "Serafiina syö vain kalaa."
> 
> -----------------------------------------------------------------------
> 
> Kissa, joka asuu kissatädin kartanossa. Jokainen kissa kuuluu tasan yhteen kissarotuun. Jokaisesta kissasta merkitään ylös sitä viimeksi ruokkinut palvelija.

### Relaatiotietokantakaavio

Tee lopuksi suunnittelemastasi tietosisällöstä [dokumentaatio-ohjeen mukainen relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio):
![Kissoihin liittymätön relaatiotietokantakaavio]({{imgdir}}dokumentaatio-ohje/relaatiokaavio.gif)

Muista lisätä kaavioon kaikki olennaiset viiteavaimet sekä
monesta-moneen suhteiden tilalle välitaulut.

Tallenna tekemäsi kaaviot ja uusi sisältö 
repositoriosi samaan dokumentaatiotiedostoon missä edellisetkin dokumentaatiot olivat.
Lisää myös kaavioiden tuottamiseen käyttämäsi lähdetiedostot
repositoriosi doc-kansioon niin ne pysyvät tallessa muutosten varalta.

<next>
Suunniteltuasi ja dokumentoituasi tietokannan rakenteen varmista, että
[saat sen pystyyn palvelimelle]({{rootdir}}koodaaminen/kannan-alustus.html).
</next>
