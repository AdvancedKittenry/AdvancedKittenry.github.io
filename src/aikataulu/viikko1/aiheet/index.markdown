% Aiheet

Ohessa olevassa listasta löydät tietokantasovelluksen valmiit aihe-ehdotukset
arvosanamaksimeineen. Vitosen arvosanamaksimiin vaaditaan aiheelta ainakin seuraavat:
  
* Kirjautumisen toteuttaminen
* Toteutettavia tietokohteita ainakin kolme
* Järjestelmässä on ainakin yksi monesta-moneen suhde tietokantojen välillä

Myös omaa aihetta saa ehdottaa tai toteuttaa aihe-ehdotuksesta oman variaationsa.
Tälläisestä on sovittava aina erikseen ohjaajan kanssa, mutta 
kunhan laajuus on sopiva omalle aiheelle ei ole yleensä mitään estettä.

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
cd src/aikataulu/viikko1/aiheet

echo "| Työn nimi | Vaikeustaso | Maksimiarvosana |"
echo "|-----------|-------------|-----------------|"
for file in `find -not -name index.markdown -and -iname "*.markdown" -printf "%f\n" | LC_ALL=fi_FI.UTF-8 sort`; do
  htmlfile=${file%.markdown}.html
  title=`head -n 1 $file | sed -e "s/^ *% *//"`
  maksimiarvosana=`egrep -o "<\!-- Arvosanamaksimi: .* -->" $file | sed -e "s/<\!-- \+\w\+: \+\(.*\) *-->/\1/"`
  vaikeustaso=`egrep -o "<\!-- Vaikeustaso: .* -->" $file | sed -e "s/<\!-- \+\w\+: \+\(.*\) *-->/\1/"`
  echo "| [$title]($htmlfile) | $vaikeustaso | $maksimiarvosana |"
done

~~~~
