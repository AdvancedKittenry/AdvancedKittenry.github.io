% Lääkäriaseman työvuorolista
<!-- Arvosanamaksimi: 5 -->
<!-- Vaikeustaso: Haastava! -->
<comment>
Kirjautuminen:        ?
3 tietokohdetta:      On
2 CRUD:ia:            On
Monesta-moneen-suhde: On
</comment>

**IS98JP1**

Tehtävänä on laatia järjestelmä, jolla voidaan laatia lääkäriaseman
työvuorolistoja. Lääkäriaseman henkilöstö jaetaan kolmeen luokkaan: lääkärit,
sairaanhoitajat ja perushoitajat. Myös aseman aukioloajat jaetaan
tarvittavan henkilöstövahvuuden mukaan eri kiireellisyysluokkiin.
Jokaiselle kiireellisyysluokalle määritellään minimivahvuus eli kuinka monta
kunkin henkilöstöluokan työntekijääää täytyy olla töissä. Kuitenkin laskettessa
minimivahvuutta ylempi voi korvata alemman eli lääkäri voi olla
sairaanhoitaja tai perushoitaja, ja sairaanhoitaja voi olla myös
perushoitaja. Jokainen aseman aukiolotunti kuuluu johonkin
kiireellisyysluokkaan.

Huom. järjestelmä saa hyväksyä vain sellaiset tyvuorolistat, jotka täyttävät
vaaditut henkilöstövahvuudet. Lisäksi jokaisella työntekijääällä on määritelty
päivä- tai viikkotuntimäärä, jonka ylitykset järjestelmään täytyy estää.

Toimintoja:
-  Ylläpitäjän kirjautuminen
-  Kiireellisyysluokkien teko (muutos)
-  Henkilöstövahvuuskalenterin teko (ja muutos)
-  Työvuorolistan teko (ja muutos)
-  Henkilöökohtaisen työvuorolistan listaus
-  Työvuorolistan listaus
-  Työntekijäkohtainen työraportti (tehdäyt tunnit tietyllä aikavälillä)
-  Työntekijään tekemien tuntien listaus kiireellisyysluokittain
-  Työvuorolistan ylimiehityksen raportointi
 
