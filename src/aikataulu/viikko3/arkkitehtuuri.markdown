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

PHP:tä käytettäessä sijoita kaikki yleiskäyttöinen koodi 
ja näkymät omaan kansioonsa.
Käsittelijät taas sijoitetaan projektin juureen.
Näkymät sijoitetaan kansioon `views`.
Yleiskäyttöisen koodin kansion voi nimetä kuvaavasti
esim. `libs`. Luo malleille oma `models`-kansio yleiskäyttöisen koodin alle.

Kansioiden nimet voi halutessaan suomentaa.

~~~~<include src="php/kansiorakenne.txt" />~~~~

</tab>
<tab title="Java-esimerkkisijoittelu">

Javaa käytettäessä sijoita mallit 
ja käsittelijät - Javan tapauksessa Servletit - omiin paketteihinsa
projektin yhteisen paketin alle src-kansioon.
Näkymät - eli yleensä jsp-tiedostot - menevät omaan kansioonsa 
joka on oletuksena nimeltään web.

~~~~<include src="java/kansiorakenne.txt" />~~~~

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

## Käsittelijät

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

<next>
Nyt mikäli koodaat Javalla, seuraa kirjautumisen teon [Java-ohjetta](java/index.html).\
PHP:llä koodaaville taas on oma vastaava [PHP-ohjeensa](java/index.html).
</next>

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
