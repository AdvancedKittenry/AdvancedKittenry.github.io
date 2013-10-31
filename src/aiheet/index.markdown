% Työaiheet
<!-- order: 100 -->

Ohessa olevasta listasta löydät tietokantasovelluksen valmiit aihe-ehdotukset
vaikeusasteineen ja arvosanamaksimeineen. Vaikeusasteet ovat suuntaa-antavia,
todellinen työn laajuus riippuu myös siitä mitä ohjaajan kanssa sovitaan.
Vitosen arvosanamaksimiin vaaditaan aiheelta ainakin seuraavat:

* Kirjautumisen toteuttaminen
* Toteutettavia tietokohteita ainakin kolme
* Vähintään kahteen tietokohteeseen pitää olla toteutettuna täysi [CRUD-nelikko](http://en.wikipedia.org/wiki/Create,_read,_update_and_delete): kohteen luominen, selailu, muokkaus, ja poisto.
* Järjestelmässä on ainakin yksi monesta-moneen suhde tietokantataulujen välillä

Parityön aiheeksi kelpaa ainoastaan vitosen arvosanamaksimilla varustettu aihe.

Myös omaa aihetta saa ehdottaa tai toteuttaa aihe-ehdotuksesta oman variaationsa.
Tällaisesta on sovittava aina erikseen ohjaajan kanssa, mutta 
kunhan laajuus on sopiva, omalle aiheelle ei ole yleensä mitään estettä.
Ota oma aiheesi esille mielellään jo heti aloitusluennon jälkeen.

<next>
Kun olet valinnut aiheesi, valitse [ohjelmointikieli]({{rootdir}}aikataulu/viikko1/ohjelmointikielet.html), jota haluat käyttää.
</next>

<comment>
* Oma aihe
* Ryhmittely?
* Jokaisella aiheella on arvosana-cap

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
cd src/aiheet

echo "| Työn nimi | Vaikeustaso | Maksimiarvosana |"
echo "|-----------|-------------|-----------------|"
for file in `find -not -name index.markdown -and -iname "*.markdown" -printf "%f\n"`; do
  htmlfile=${file%.markdown}.html
  title=`head -n 1 $file | sed -e "s/^ *% *//"`
  maksimiarvosana=`egrep -o "<arvosanamaksim.>.*</arvosanamaksimi>" $file | sed -e "s/<\w\+> *\(.*\) *<\/\w\+>/\1/"`
  vaikeustaso=`egrep -o "<vaikeustas.>.*</vaikeustaso>" $file | sed -e "s/<\w\+> *\(.*\) *<\/\w\+>/\1/"`
  echo "| [$title]($htmlfile) | $vaikeustaso | $maksimiarvosana |"
done | LC_ALL=fi_FI.UTF-8 sort

~~~~
