% Arkkitehtuuriohje

Tällä kurssilla pyritään kevyeen [MVC-mallin](http://fi.wikipedia.org/wiki/MVC-arkkitehtuuri) mukaiseen 
koodiarkkitehtuuriin.

Käytännössä tämä tarkoittaa sitä, että koodi jaetaan 
kolmeen osaan: 
_näkymiin_, _käsittelijöihin_ ja _malleihin_ 
(engl. views, controllers ja models).

## Koodin sijoittelu tiedostojärjestelmään

Eri osioiden koodit sijoitetaan käytetystä kielestä eri paikkaan.
Ohjaajien toiveet sijoittelusta ovat alla:

<tabs>
<tab title="PHP-esimerkkisijoittelu">

PHP:tä käytettäessä sijoita mallit 
ja näkymät omiin kansioihinsa.
Kontrollerit voit halutessasi jättää
projektin juureen tai sijoittaa nekin omaan
kansioonsa. Kansioiden nimet voi halutessaan suomentaa.

~~~
views/
  userlist.php
models/
  user.php
users.php (Käyttäjänhallinnan käsittelijä)
~~~

</tab>
<tab title="Java-esimerkkisijoittelu">

Javaa käytettäessä sijoita mallit 
ja käsittelijät - Javan tapauksessa Servletit - omiin paketteihinsa
projektin yhteisen paketin alle src-kansioon.
Näkymät - eli yleensä jsp-tiedostot - menevät omaan kansioonsa 
joka on oletuksena nimeltään web.

~~~
src/
  Paketti/
    Models/
      User.java
    Servlets/
      UserServlet.java
web/
  user.jsp
~~~

</tab>
</tabs>

## Mallit

Mallit sisältävät järjestelmän tiedon tallentamisen, ylläpidon 
ja käsittelyyn liittyviä toimintoja. 
Ne toteutetaan yleensä keräämällä eri asioihin ja tietokohteisiin 
liittyviä toimintoja luokiksi. 

Esimerkiksi käyttäjille on hyvä olla oma luokkansa, joka 
sisältää ainakin samat kentät kuin käyttäjien tietokantataulu,
ja jossa on metodit joilla voi hakea, lisätä, muokata ja poistaa käyttäjiä. 
Usein voi olla järkevää tehdä malleja myös abstraktimmeille asioille kuten käyttäjän kirjautumiselle.

## Näkymät

Näkymä määrittää käyttöliittymän ulkoasun ja tietojen näytön esityksen käyttöliittymässä. 
Tietokantasovelluksen tapauksessa käytetään erilaisia template-tiedostoja. Javalla käytetään JSP-tiedostoja, PHP:llä tavallisia 
php-tiedostoja. Kummassakin on lähinnä HTML-koodia,
jonka seassa on hieman ohjelmakoodia.

Yleensä on tapana myös tehdä muutama näkymätiedosto,
joissa määritellään kaikille sovelluksen sivuille yhteisiä elementtejä.

## Kontrollerit

Käsittelijä eli kontrolleri tai ohjain vastaanottaa 
käyttäjältä tulevat HTTP-pyynnöt 
ja käsittelee niisssä tulevan informaation perusteella 
mallia sekä tuottaa jonkin näkymän vastauksena pyyntöön.

Web-sovelluksessa käsittelijöitä on tyypillisesti kahdentyyppisiä:
_näkymiä näyttäviä käsittelijöitä_ ja _lomakekäsitteliöitä_.
Näkymiä näyttävät käsittelijät yksinkertaisesti näyttävät jonkin näkymän,
johon on yleensä haettu mallin avulla tietokannasta sisältöä.
Lomakekäsittelijät sensijaan keskittyvät nimensä mukaan
vastaanottamaan käyttäjän lähettämiä lomakkeita
tai muita erilaisia toimintoja.
Ne tekevät yleensä malleja käyttämällä muutoksia tietokantaan
ja ohjaavat selaimen tämän jälkeen johonkin näkymään mahdollisen 
virheilmoituksen kera.

<comment>
Toiminta palvelimessa:

* Pyynnön vastaanotto
* Käyttöoikeuden tarkistus (& istunnon tilan selvitys)
* Pyyntöparametrien purkaminen
* Palvelun valinta parametrien perusteella
* Palvelun suoritus / datan haku
* Palautteen sisällön määrittely
* Istunnon tilan tallennus
* Palautteen valmistelu asiakkaalle
* Palautesivun muotoilu

</comment>
