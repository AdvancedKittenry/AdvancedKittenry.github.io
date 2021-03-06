% Työaiheet
<!-- order: 1 -->
<!-- tags: viikko1 -->

Ensiksi kurssilla on tietenkin valittava aihe. 
Voit keksiä joko oman, tai valita valmiista aiheista.

<include src="maksimiarvosana.markdown" />

### Oma aihe

Jos haluat tehdä työn itse keksimästäsi aiheesta ja työ täyttää kurssille
asetettavat vaatimukset (tietokanta jossa noin 4-7 taulua, yksinkertainen
käyttöliittymä, järkevä maksimiarvosana), voit toteuttaa työn omalla aiheellasi.
Omasta aiheesta täytyy laatia aihekuvaus valmiiden aiheiden tapaan.
Voit myös toteuttaa valmiista aihe-ehdotuksesta oman variaatiosi.

Hyviä aiheideoita voit saada vaikkapa omista harrasteista ja kiinnostuksen kohteista.
Kurssilla on vuosien saatossa toteutettu mm. kaikennäköisiä roolipelitietokantoja,
lintutietokanta, bussinbongaustietokanta, käärmelainaamo ja haalarimerkkigalleria.

Omasta aiheesta on sovittava ohjaajan kanssa, että varmistetaan aiheen sopiva laajuus, mutta 
kunhan laajuus on sopiva, saa tsohan tehdä käytännössä mistä itse parhaaksi katsoo.
Ota oma aiheesi esille mielellään jo heti aloitusluennon jälkeen.

### Valmiit aiheet

Jos et keksi omaa aihetta voit myös valita jonkin valmiin aiheen.

Ohessa olevasta listasta löydät tietokantasovelluksen valmiit aihe-ehdotukset
vaikeusasteineen ja arvosanamaksimeineen. Vaikeusasteet ovat suuntaa-antavia,
todellinen työn laajuus riippuu myös siitä mitä ohjaajan kanssa sovitaan.

<next>
Kun olet valinnut aiheesi, valitse [ohjelmointikieli](../ohjelmointikielet.html), jota haluat käyttää.
</next>

<comment>
* Oma aihe
* Ryhmittely?

Informaation keräily ja näyttö
  Drinkkiarkisto
  Elektroninen keittokirja
  Kuluttajan tuki Ry
  Kurssin kotisivu
  Opintoneuvonnan usein kysytyt kysymykset
  Tutkimusaineston keräys
  Työaihekanta

Verkkokaupat
  Pizzapalvelu
  Matkojen markkinointi
  Huutokauppa
  Kurssitarjonta ja kurssipaikan varaus
  Graduaiheet
  Lääkärin kotikäynnit
  Ostoskassi (Siipilomat Oy)
  Palvelubisnes
  Parturi-Kampaamo
  Taloyhtiön palvelut
  Tukkuliikkeen tilaustenkäsittely
  Työntekijänvuokraus kotitöihin

Muut
  Harjoitustyön seuranta
  Lainahakemusten käsittely
  Projektin työaikaseuranta
  Rankkauslista
  Tavaranvaihto
  Työryhmätiedotus
  Ystävänvälityspalvelu
  Muistilista
  Painontarkkailu
  Kurssikysely
  Äänestys
  Kennelkerho
  Hiihtokisojen tulospalvelu
  Lääkäriaseman työvuorolista
  Vedonlyönti
  Vuokra-asuntojen välitys


</comment>

~~~~ {execute=bash}
cd src/suunnittelu_ja_tyoymparisto/aiheet

echo "| Työn nimi | Vaikeustaso | Maksimiarvosana |"
echo "|-----------|-------------|-----------------|"
for file in `find -not -name maksimiarvosana.markdown -and  -not -name index.markdown -and -iname "*.markdown" -printf "%f\n"`; do
  htmlfile=${file%.markdown}.html
  title=`head -n 1 $file | sed -e "s/^ *% *//"`
  maksimiarvosana=`egrep -o "<arvosanamaksim.>.*</arvosanamaksimi>" $file | sed -e "s/<\w\+> *\(.*\) *<\/\w\+>/\1/"`
  vaikeustaso=`egrep -o "<vaikeustas.>.*</vaikeustaso>" $file | sed -e "s/<\w\+> *\(.*\) *<\/\w\+>/\1/"`
  echo "| [$title]($htmlfile) | $vaikeustaso | $maksimiarvosana |"
done | LC_ALL=fi_FI.UTF-8 sort

~~~~
