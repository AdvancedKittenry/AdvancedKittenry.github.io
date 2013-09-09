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

## HTML-sivujen luonti

Tähän tulossa lyhyet ohjeet siitä, miten selkeällä HTML:llä ja CSS:llä
sekä [Bootstrapilla](http://getbootstrap.com/) saa aikaan siistit sivut.

Hyviä HTML-referenssejä:

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
html/
  index.html
  ...
sql/
  create-tables.sql
  drop-tables.sql
  add-test-data.sql
~~~~

<last>
Varmista vielä, että olet laittanut [tietosisältö- ja relaatiottietokantakaaviot](tietokanta.html), SQL-tiedostot ja [HTML-demoversion](html-versioiden-luonti.markdown) repositorioosi!
</last>
