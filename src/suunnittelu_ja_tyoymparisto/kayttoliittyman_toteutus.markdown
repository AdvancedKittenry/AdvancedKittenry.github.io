% Käyttöliittymädemon toteuttaminen
<!-- order: 11 -->
<!-- addHeaderNavigation -->
<!-- tags: viikko2 -->

Jokaisen tietokantasovelluksen käyttöliittymän pohjana on HTML-kieli,
jolla määritetään se, mitä sivuilla näkyy. HTML-kielen kaverina 
toimii CSS-tyylitiedostokieli, jolla on mahdollista määritellä minkä näköisenä
HTML-kielellä ilmaistut elementit sivuilla esiintyvät.

## Minne laitan sivuni?

Se minne sivut kannattaa sijoittaa riippuu hieman ohjelmointikielestä.
Javan servlet-tekniikalla ainoastaan `web`-hakemistoon laitetut
tiedostot näkyvät selaimella. PHP:llä tätä rajoitusta ei ole,
joskin myöhemmin keskitämme HTML-koodin MVC-mallin mukaisesti omaan hakemistoonsa.

Jos teet vasta staattista HTML-versiota käyttöliittymää,
luo hakemisto `html-demo` ja lähde rakentamaan sinne HTML-versiota työstäsi. 
Javalla tämä hakemisto sijoitetaan `web`-hakemistoon, PHP:llä se voi olla projektin juuressa.
Sijoita kaikki puhtaasti testausmielessä (lähinnä viikolla 2) tekemäsi HTML-tiedostot tuohon kansioon.

## HTML-sivun luonti NetBeansillä

NetBeansin käyttäjät voivat luoda HTML-tiedostoja projektiinsa seuraavasti:

* Javalla koodatessa:
    * Valitse uuden tiedoston ikkunasta Web->HTML
    * Halutessasi tehdä dynaamisia sivuja valitse Web->JSP
* PHP:llä koodatessa:
    * Valitse uuden tiedoston ikkunasta Other->HTML
    * Halutessasi tehdä dynaamisia sivuja valitse PHP->PHP Web Page

Poista kummassakin tapauksessa NetBeansin alkuun lisäämä Template-kommentti.
Ota kommentin luominen pois päältä valitsemalla valikosta `Tools->Templates`.
Avaa listassa kohdan _Licenses_ alla oleva tiedosto `Default License` ja tyhjennä sen sisältö.

## HTML, CSS ja Bootstrap

Mikäli loit tiedostosi NetBeansillä näyttää se suurinpiirtein tältä:

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

Mikäli tämännäköinen koodi ei ole tuttua, kannattaa lukea taustatietoja
esim. [w3schoolsin sivuilta](http://www.w3schools.com/html/html_intro.asp).
Myös [tietokone työvälineenä -kurssin](https://blogs.helsinki.fi/tyovaline-2013/tehtavat/)
[materiaaleista](https://docs.google.com/document/d/1GhmkqP86f1q4tYIP6EsxXAnM6Ntlc0SiUcitWC3RcoE/pub) voi olla apua.

Tehdään sivusta vähän nätimpi CSS:llä. Lataa twitterin mainio [Bootstrap-kirjasto](http://getbootstrap.com/)
ja pura paketin sisältä dist kansion sisältö projektisi juureen tai Javalla `web`-kansioon.
Tarkoituksena on, että bootstrapin `css`, `fonts` ja `js`-kansiot
sijoittuvat seuraavasti: 

<tabs>
<tab title="Bootstrap PHP-projektissa">

Kansiorakenteesta tulee suurinpiirtein seuraavanlainen

```
css/
fonts/
index.php
js/
html-demo/
```

</tab>
<tab title="Bootstrap Java-projektissa">

Kansiorakenteesta tulee suurinpiirtein seuraavanlainen

```
src/
web/
  css/
  fonts/
  html-demo/
  js/
  index.jps
```
</tab>
</tabs>

Tämän jälkeen luo `css`-kansioon vielä oma tyylitiedostosi `main.css`. (NetBeansillä tyylitiedoston luonti löytyy kategoriasta _Other_ nimellä _Cascading Style Sheet_). Tähän tiedostoon voit sijoittaa omat projektikohtaiset tyylimääritelmäsi. 
Tiedostoon ei tarvitse laittaa vielä mitään.

Lisätään CSS-tiedostoihin linkit laittamalla HTML-tiedoston head-tägin sisään ja
katso miten CSS muuttaa sivun ulkoasua hieman.

~~~HTML
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/bootstrap-theme.css" rel="stylesheet">
<link href="../css/main.css" rel="stylesheet">
~~~

<alert>
Yllä oleva määritelmä hakee CSS-tiedostot luomasi `html-demo`-kansion _yläkansiossa_ olevasta `css`-kansiosta. (Kaksi pistettä tarkoittaa hakemistopoluissa aina ylähakemistoa.)

Mikäli sivusi eivät näytä oikein tyylitellyiltä johtuu se todennäköisesti siitä, 
että CSS-tiedostoja haetaan väärästä paikasta.
Tarkista että linkit osoittavat sinne, missä tiedostot oikeasti ovat.
</alert>

### Bootstrap-esimerkkejä

Nyt voimme käyttää Bootstrapin kirjastoja erilaisten käyttöliittymäkomponenttien luomiseen. Alla esimerkkejä.
Lisää Bootstrap-esimerkkejä voi katsoa Bootstrapin sivujen [CSS](http://getbootstrap.com/css/)- ja [Components](http://getbootstrap.com/components/)-osioista.

<tabs>
<tab title="Tabinavigaatio">

Käyttämällä luokkia `nav` ja `nav-tabs` saadaan tavallinen ul-elementti toimimaan [tabinavigaationa](http://getbootstrap.com/components/#nav).

<iframe src="{{rootdir}}src/{{curdir}}html-esimerkit/tabit.html" ></iframe>

Esimerkin lähdekoodi:

~~~~ {.html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}html-esimerkit/tabit.html
~~~~

</tab>
<tab title="Sivunavigaatio">

Luokilla `row` ja `col-md-<leveys>` varustetuilla div-elementeillä on mahdollista laittaa 
käyttöliittymäelementtejä helposti vierekkäin. Bonuksena elementit limittyvät
päällekkäisiksi jos sivulta loppuu tila. Bootstrapin Grid-järjestelmästä lisää [täältä](http://getbootstrap.com/css/#grid).

Huomaam myös kätevä `panel`-luokka, jolla saa helposti aikaan nättejä [laatikoita](http://getbootstrap.com/components/#panels).

<iframe src="{{rootdir}}src/{{curdir}}html-esimerkit/sivunavi.html" ></iframe>

Esimerkin lähdekoodi:

~~~~ {.html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}html-esimerkit/sivunavi.html | sed -e s/-xs-/-md-/g 
~~~~

</tab>
<tab title="Listaus">

Useimmat listaukset kannattaa tehdä HTML-taulukoilla. 
Bootstrapissa on hyvät oletustyylit tätä varten luokilla `table` ja `table-striped`.
[Muitakin käteviä tyylejä](http://getbootstrap.com/css/#tables) löytyy.

Listauksessa on myös käytetty hyväksi Bootstrapin tukea [napeille](http://getbootstrap.com/css/#buttons) ja [Glyphicon-kuvakkeille](http://getbootstrap.com/components/#glyphicons).

<iframe src="{{rootdir}}src/{{curdir}}html-esimerkit/table.html" ></iframe>

Esimerkin lähdekoodi:

~~~~ {.html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}html-esimerkit/table.html | sed -e s/-xs-/-md-/g 
~~~~

</tab>
<tab title="Lomake">

Bootstrap tukee lomakkeiden tyylittelyyn samankaltaisia [rivi- ja sarakeluokkia](http://getbootstrap.com/css/#forms-horizontal) kuin yleiseen asetteluunkin.
Myös [monia muita tapoja](http://getbootstrap.com/css/#forms) tyylitellä lomakkeita löytyy.

<iframe src="{{rootdir}}src/{{curdir}}html-esimerkit/lomake.html" ></iframe>

Esimerkin lähdekoodi:

~~~~ {.html execute=bash type=block}
./extract-tag.pl body src/{{curdir}}html-esimerkit/lomake.html | sed -e s/-xs-/-md-/g 
~~~~

</tab>
</tabs>

Nämä esimerkit ovat tietenkin vielä melko harmaita. Kannattaa tutustua CSS-kieleen ja laittaa
omaan tyylitiedostoon määrittelyjä, jotka tekevät asioista värikkäämpiä.
Voit halutessasi tutustua myös näiden ohjeiden lähdekoodiin.

Tee nyt näitä ohjeita ja esimerkkejä mukaillen itsellesi kokonaiset demosivut, joissa jokaisella sivulla on käytetty samaa
yleistä ulkoasua. 
Tekeminen kannattaa aloittaa yleisestä sivunavigaatiosta ja valita joku päätietokohde johon liittyvät sivut tekee valmiiksi ensin.
Tästä saadun kokemuksen pohjalta muut sivut on helpompi tehdä valmiiksi.

## Vinkkejä

Kannattaa varmistaa, että jokainen aloitettu HTML-tägi myös lopetetaan jossain:

```html
<nav>Navigaatio</nav>
<div>Sisältöä</div>
```

Jos näin ei tee, joutuvat tägit toistensa sisään ja aikaansaavat mystisiä bugeja.
Jotkin tägeistä ovat sellaisia että ne suljetaan samantien, niille ei tarvitse tehdä
erillistä sulkutägiä. Näistä käytetään nimitystä tyhjät tägit (engl. *void tags*).
Esimerkiksi `<input>` toimii näin:

```html
<input type="text" name="username">
```

Muita vastaavia tägejä ovat mm. `<br>`, `<hr>`, `<link>`, `<meta>` ja `<img>`.

## Linkkejä

* [W3schools-sivuston HTML-intro](http://w3schools.com/html/html_intro.asp).
* [Suomenkielinen sivu HTML-sivujen rakenteesta](http://salakapakka.net/oppaat/html-ja-css-opas/html_opas_dokumentti.php#dokumentin_rakenne)
* [Saman sivuston sivupohjantekoohjeita](http://salakapakka.net/oppaat/html-ja-css-opas/sivupohjaopas.php)
* [tietokone työvälineenä -kurssin HTML-materiaalit](https://docs.google.com/document/d/1GhmkqP86f1q4tYIP6EsxXAnM6Ntlc0SiUcitWC3RcoE/pub).
* [Learn the Basic HTML Tags!](http://www.htmlgoodies.com/primers/html/article.php/3478151)
* [Twitter Bootstrap](http://getbootstrap.com/)
* [HTML Dogin tutoriaalit](http://www.htmldog.com/) (HTML ja CSS) ovat lupsakoita ja perusteellisia. Suositellaan selattavaksi sivuja tehdessä! Tutoriaaleissa tehdään XHTML-sivuja, mutta ne on helppo soveltaa HTML5-sivuiksi (korvaa alun pitkä DOCTYPE lyhyellä HTML5-doctypellä).

<next>
Kun olet suunnitellut mielestäsi toimivan käyttöliittymän, 
suunnittele työllesi [tietokanta ja dokumentoi se](tietokanta.html).
</next>
