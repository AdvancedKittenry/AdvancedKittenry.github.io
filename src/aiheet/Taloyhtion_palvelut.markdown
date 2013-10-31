% Taloyhtiön palvelut
<arvosanamaksimi>5</arvosanamaksimi>
<vaikeustaso>Haastava</vaikeustaso>
<comment>
Kirjautuminen:        On
3 tietokohdetta:      On
2 CRUD:ia:            On
Monesta-moneen-suhde: On
</comment>

**IK98HL3**

Tehtävänäsi on laatia järjestelmä, jolla voidaan varata
asunto-/kiinteistöyhtiön yleiskäyttöisiä resursseja kuten saunaa, pesutupaa,
yms. Yhtiön isännöitsijä määrittelee ajat, joille varauksia voi tehdä.
Järjestelmän avulla voidaan tehdä sekä kertavarauksia että pysyväisvarauksia.
Kertavarauksia voi tehdä aikaisintaan 2 viikkoa etukäteen.
Pysyväisvarauksen voi peruutta milloin tahansa. Kertavarauksen peruutus
ei onnistu enää samana päivänä, joksi varaus on tehty eikä tämän päivän jälkeen.
Kullekin resurssille on määritelty kiinteä varausyksikön koko (esim. 1
tunti) ja yksikölle hinta. Vain varauksen tehnyt voi käyttää resurssia
(varauksen yhteydessä saatu tunnusluku on syötettävä ovikontrolliin).

Varauksille annetaan varausnumerot kasvavassa järjestyksessä
automaattisesti. Varaaja voi laatia itselleen laskun resurssien käytöstä.
Laskuun otetaan mukaan kaikki laskuntekohetkeä ennen toteutuneet
maksamattomat kertavaraukset. Laskun viitenumeroksi tulee
mukaanotettavien laskujen suurin varausnumero. Saatuaan tiedon laskun
maksamisesta isännöitsijä kirjaa tätä viitenumeroa käyttäen laskun maksetuksi.
Pysyväisvaraukset laskutetaan vuokran tai yhtiövastikkeen yhteydessä.

Varauksia ja peruutuksia ovat oikeutetut tekemään vain kiinteistön
asukkaat. Jokaiseen huoneistoon on toimitettu salasana, jolla varauksen
tekijä osoittaa käyttoikeutensa. Salasanan voi vaihtaa.

Isännöitsijä saa järjestelmästä yhteenvetoja resurssien käytöstä ja
maksutilanteesta. Hän voi tuottaa myös laskuja kenelle tahansa ja
lisätä ja poistaa varattavia aikoja ja tiloja

Toimintoja:

-  Kirjautuminen
-  Varauksen teko ja peruutus
-  Laskun laatiminen
-  Yhteenveto resurssin käytöstä
-  Yhteenveto maksuista
-  Maksetun laskun kirjaus
-  Salasanan vaihto
-  Isännöitsijän muutostyöt: aikojen ja varattavien tilojen lisäys, poisto ja muokkaus (saattaa perua varauksia)
