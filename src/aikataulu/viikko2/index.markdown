% Viikko 2
<!-- order: 1 -->
<!-- hidden! -->

<deadline>{{deadline2}}</deadline>

Toisen viikon aikataulu
suunnittelemalla työhön
tulevat sivut, jonka jälkeen niistä toteutetaan 
oikean näköiset, mutta epätoiminnalliset raakaversiot HTML:llä.
Tämän jälkeen suunnitellaan
Näitä harjoituksia on yleensä paras tulla tekemään pajaan,
jolloin ohjaaja voi antaa vinkkejä niiden tekemisessä.

Sinulla tulee olla tehtynä seuraavat asiat:

<comment>
TODO:
Käyttöliittymäsuunnitelmat <- hajota kälikaavio pois ykkösviikkoon

Asiat:
* Käyttöliittymäsuunnitelmat 
* HTML-demot: yleisnäkymä
* Listaukset
* Tietokannan suunnittelu: Järjestelmän tietosisältö, relaatiotietokantakaavio
* Tiedostot sovelluksen tietokannan taulujen luomiseen ja alasajoon, tietokannan pystytys (Testifilu)
* Oma listaus! Hyvin yksinkertainen!
</comment>

* [Käyttöliittymän suunnittelu](suunnittelu.html).
* [HTML-versio sovelluksen rungosta](html-versioiden-luonti.html).
* HTML-versiot sovelluksen listaussivuista.
* [Tietokannan suunnittelu](tietokanta.html) ja dokumentointi.
    * [Järjestelmän tietosisältö]({{rootdir}}dokumentaatio-ohje.html#j%C3%A4rjestelm%C3%A4n-tietosis%C3%A4lt%C3%B6)
    * [Relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio)
* Tiedostot sovelluksen tietokannan taulujen luomiseen ja alasajoon .
    * `sql/create-tables.sql`
    * `sql/drop-tables.sql`
    * `sql/add-test-data.sql`
    * Tietokannan pystyttäminen näillä tiedostoilla
    * Tietokantatestisovelluksen laittaminen näkyville
* Kevyt testisivu, joka listaa jonkin tietokantataulun sisällön.
    * Käytä tietokannan täyttämiseen `add-test-data.sql`-tiedostoa, niin sivulla on jotain näytettävää.
* MVC-malliin käytön aloittaminen.

Jokaisesta listan yläkohdasta saa puolikkaan aikataulupisteen. 
Yhteensä kolme pistettä tältä viikolta.

<alert>
Laita kaikki uusi dokumentaatio kootusti yhteen `dokumentaatio.pdf`-tiedostoon `docs`-kansiossa. Ohjaajasi ei halua arvuutella mistä tiedostosta dokumentaatio löytyy.
</alert>

<ohje>
Aloita ottamalla [laitoksen tietokanta- ja web-palvelimet käyttöön](tekniikka.html) ja jatka siitä seuraten vihreitä ohjelaatikoita.

Tehtyäsi kaiken varmista, että kaikki tekemäsi muutokset näkyvät github-repositoriossasi.
</ohje>
