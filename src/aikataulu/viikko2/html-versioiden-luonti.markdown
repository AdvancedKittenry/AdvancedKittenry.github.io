% HTML-versioiden luominen
<!-- order: 5 -->

<wip />

Tässä vaiheessa työtä siirrytään suunnittelusta käytäntöön
ja luodaan suunnitelluista sivuista oikean näköiset, mutta
vielä staattiset HTML-versiot.

Viimeistään tässä vaiheessa työlle kannattaa luoda NetBeans-projekti.
NetBeansia ei ole pakko käyttää, mutta etenkin Javalla koodatessa sen
koodingenerointi- ja refaktorointiominaisuuksista on paljon iloa.
Pääset NetBeans-ohjeisiin [tästä](netbeans.html).

## Sivujen luonti

Luo repositorioosi kansio `html-demo` ja lähde rakentamaan sinne HTML-versiota työstäsi. 
Javalla ohjelmoivat voivat testauksen helpottamiseksi sijoittaa HTML-tiedostonsa kansioon `web/html-demo`.
Sijoita kaikki tässä vaiheessa tekemäsi HTML-tiedostot tuohon kansioon.

### HTML-sivun luonti NetBeansillä

NetBeansin käyttäjät voivat luoda HTML-tiedostoja projektiinsa seuraavasti:

* Javalla koodatessa:
    * Valitse uuden tiedoston ikkunasta Web->HTML
    * Voit halutessasi valita tyypiksi myös Web->JSP
* PHP:llä koodatessa:
    * Valitse uuden tiedoston ikkunasta Other->HTML
    * Voit halutessasi valita tyypiksi myös PHP->PHP Web Page

Poista kummassakin tapauksessa NetBeansin alkuun lisäämä Template-kommentti.
Ota kommentin luominen pois päältä valitsemalla valikosta `Tools->Templates`.
Avaa listassa kohdan _Licenses_ alla oleva tiedosto `Default License` ja tyhjennä sen sisältö.

### HTML ja CSS

Mikäli loit tiedostosi NetBeansillä näyttää se tältä:

~~~~HTML
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <div>TODO write content</div>
    </body>
</html>
~~~~

Tehdään sivusta vähän nätimpi CSS:llä. Lataa twitterin mainio [Bootstrap-kirjasto](http://getbootstrap.com/)
ja pura paketin sisältä dist kansion sisältö projektisi juureen tai Javalla `web`-kansioon.
Tarkoituksena on, että bootstrapin `css`, `fonts` ja `js`-kansiot
sijoittuvat samaan kansioon kuin edellä luomasi `html-demo`-kansio. 

Tämän jälkeen luo `css`-kansioon vielä oma tyylitiedostosi `main.css`. (NetBeansillä tyylitiedoston luonti löytyy kategoriasta _Other_ nimellä _Cascading Style Sheet_). Tähän tiedostoon voit sijoittaa omat projektikohtaiset tyylimääritelmäsi. Älä sijoita tiedostoon vielä mitään.

Lisätään CSS-tiedostoihin linkit laittamalla HTML-tiedoston head-tägin sisään:

~~~HTML
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/bootstrap-theme.css" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">
~~~

Nyt voimme käyttää Bootstrapin kirjastoja erilaisten käyttöliittymäkomponenttien luomiseen. Alla esimerkkejä.

<tabs>
<tab title="Tabinavigaatio">

~~~~ {#html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}esimerkit/tabit.html
~~~~

<iframe src="{{rootdir}}src/{{curdir}}esimerkit/tabit.html" ></iframe>

</tab>
<tab title="Sivunavigaatio">

~~~~ {#html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}esimerkit/sivunavi.html | sed -e s/-xs-/-md-/g 
~~~~

<iframe src="{{rootdir}}src/{{curdir}}esimerkit/sivunavi.html" ></iframe>

</tab>
<tab title="Listaus">

~~~~ {#html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}esimerkit/table.html | sed -e s/-xs-/-md-/g 
~~~~

<iframe src="{{rootdir}}src/{{curdir}}esimerkit/table.html" ></iframe>

</tab>
<tab title="Lomake">

~~~~ {#html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}esimerkit/lomake.html | sed -e s/-xs-/-md-/g 
~~~~

<iframe src="{{rootdir}}src/{{curdir}}esimerkit/lomake.html" ></iframe>

</tab>
</tabs>

Nämä esimerkit ovat tietenkin vielä melko harmaita. Kannattaa tutustua CSS-kieleen ja laittaa
omaan tyylitiedostoon määrittelyjä, jotka tekevät asioista värikkäämpiä.
Voit halutessasi tutustua myös näiden ohjeiden lähdekoodiin.

Tee nyt näitä ohjeita ja esimerkkejä mukaillen itsellesi kokonaiset demosivut, joissa jokaisella sivulla on käytetty samaa
yleistä ulkoasua.

## Linkkejä

* [Twitter Bootstrap](http://getbootstrap.com/)
* [HTML Dogin tutoriaalit](http://www.htmldog.com/) (HTML ja CSS) ovat lupsakoita ja perusteellisia. Suositellaan selattavaksi sivuja tehdessä! Tutoriaaleissa tehdään XHTML-sivuja, mutta ne on helppo soveltaa HTML5-sivuiksi (korvaa alun pitkä DOCTYPE lyhyellä HTML5-doctypellä).
* W3-konsortion sivuilta löydät alkuperäiset, kattavat standardit: [HTML5](http://www.w3.org/TR/html5/) ja [CSS(3)](http://www.w3.org/TR/CSS/) sekä aika hyvän [tutoriaali- ja referenssisivun](http://w3schools.com/html/html5_intro.asp).

## Palautus

Lopulta palautuksesi kansiorakenteen pitäisi näyttää suurinpiirtein tältä:

~~~~
doc/
  dokumentaatio.pdf
  relaatiotietokantakaavio.dia
  sivukartta.png
  tietosisältökaavio.dia
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
html-demo/
  index.html
  kissalista.html
  muokkaakissaa.html
  ...
~~~~

NetBeansia käyttävillä on projektissaa todennäköisesti huomattavasti enemmän tiedostoja.
Se ei haittaa.

<last>
Varmista vielä, että olet laittanut [tietosisältö- ja relaatiottietokantakaaviot](tietokanta.html), SQL-tiedostot ja [HTML-demoversion](html-versioiden-luonti.markdown) repositorioosi!
</last>
