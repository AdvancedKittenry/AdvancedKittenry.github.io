% Henkilögalleria
<arvosanamaksimi>5</arvosanamaksimi>
<vaikeustaso>Keskitasoa</vaikeustaso>
<comment>
Kirjautuminen:        On
3 tietokohdetta:      On
2 CRUD:ia:            On
Monesta-moneen-suhde: On
</comment>

Yliopiston 375 vuosijuhlintaan liittyen on kaavailtu henkilögalleria, jonne yliopiston piirissä toimivat henkilöt
voisivat laittaa itseensä ja toimintaansa liittyvää esittelymateriaalia. Ajatuksena on, että tarjolla on
käyttöliittymä, jonka kautta henkilöt voivat toimittaa tietojaan ohjelmassa julkaistavaksi. Tietoja kerätään
lomakkeella, johon järjestelmän hoitaja voi määritellä kysymykset. Kyselylomakkeen muotoa ei ole
kiinnitetty. Se voi olla näytettävän esittelysivun kaltainen ja muuttua tehtävien valintojen perusteella.
Lomakkeen ei kuitenkaan tarvitse olla sellainen. Tietojen syöttäjän pitäisi kuitenkin saada näkyville tuotettu
esittelysivu ennen sen julkaisemista. Esittelysivun tietoja pitää pystyä muuttamaan. Järjestelmän hoitajalla
tulee olla mahdollisuus muokata lomakkeella esitettäviä kysymyksiä ja lisätä sekä poistaa niitä. Kysymyksiä
pitää voida muokata. Henkilöitä voidaan luokitella erilaisten tagien avulla. Henkilöön voi liittyä useita
tageja. Tagit voivat vaikuttaa henkilön esittelysivun ulkoasuun esimerkiksi väreihin.

Gallerian tiedot näytetään vakioidussa muodossa (css:llä säädettävissä). Lähtökohtana on kuvavalikko,
jonka sisältö määräytyy valittujen tagien perusteella. Kuvavalikosta pääsee henkilön esittelysivulle.
Prototyypissä esittelysivut tuotetaan dynaamisesti. Järjestelmän hoitajalla on oma katselusivu, jonka
kautta hän voi tarkastella paitsi esittelysivuja myös niihin liittyvää metatietoa kuten laatimisaikaa tai
muutostietoja. Järjestelmän hoitaja antaa esittelysivulle julkaisuluvan.

Toteutus: MySQL tai PostgreSQL tietokanta , php

Yhdyshenkilö: Harri Laine

Kaavailuja galleriasta löytyy osoitteesta: 
[http://www.cs.helsinki.fi/u/laine/tsoha/375_kasvoa_sparraus.pdf](http://www.cs.helsinki.fi/u/laine/tsoha/375_kasvoa_sparraus.pdf)

