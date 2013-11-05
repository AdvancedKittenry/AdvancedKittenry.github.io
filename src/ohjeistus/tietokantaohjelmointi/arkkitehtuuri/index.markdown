% Arkkitehtuuri ja MVC
<!-- order: 6 -->

Tällä kurssilla pyritään kevyeen [MVC-mallin](http://fi.wikipedia.org/wiki/MVC-arkkitehtuuri) mukaiseen 
koodiarkkitehtuuriin.
Monille käsite on hieman hämärä, siispä avaamme sitä tällä sivulla tarkemmin.

Käytännössä MVC-arkkitehtuuri tarkoittaa sitä, että koodi jaetaan 
kolmeen osaan: 
_näkymiin_, _kontrollereihin_ ja _malleihin_ 
(engl. views, controllers ja models).
Mallit käyttävät tietokantaa ja abstrahoivat sen ohjelmointirajapinnaksi, jota muu koodi käyttää.
Näkymät hoitavat kaiken HTML:ään liittyvän koodin ja
kontrollerit ottavat vastaan käyttäjän antamat aineistopyynnöt, hakevat ja päivittävät tietoa malleja käyttäen ja välittävät tiedot näkymälle, joka näyttää sivun.

![MVC-mallin vastuunjako]({{imgdir}}mvc.png)

<summary title="Nyrkkisääntöjä">
<include src="nyrkkisaannot.markdown" />
</summary>

## Mallit

Mallit sisältävät kaikki sovelluksen tietokannassa olevan tiedon 
ja käsittelyyn liittyvät toiminnnot. 
Kaikki tietokantaa käsittelevä koodi kuuluu siis malleihin.

Mallit toteutetaan keräämällä eri asioihin ja tietokohteisiin 
liittyviä toimintoja luokiksi ja/tai funktioiksi. 
Ohessa Javalla tehty esimerkki malliluokasta tietokohteelle kissa:

~~~ {.java .scrollable}<include src="esimerkit/Kissa.java" />~~~

Vastaava luokka PHP-kielellä on hyvin samanlainen, joskin hieman lyhyempi.

Huomaa miten malliluokka on käytännössä pelkkä abstraktitaso,
joka piilottaa tietokantakoodin rumat yksityiskohdat siistin
oliokäyttöliittymän taakse.

Usein voi olla järkevää tehdä malleja myös abstraktimmeille asioille kuten istunnoille ja sille millä oikeuksilla käyttäjä on kirjautunut.
Näiden ei ole tietenkään pakko käyttää tietokantaa (ainakaan suoraan), mutta ne ovat silti malleja.

## Näkymät

Näkymä määrittää käyttöliittymän ulkoasun ja tietojen näytön esityksen käyttöliittymässä. 
Tietokantasovelluksen tapauksessa käytetään nk. *template-tiedostoja*
eli tiedostoja, joissa määritellään sivulle tuleva HTML-koodi,
ja sen sekaan tulevat muuttujat.

Javalla käytetään JSP-tiedostoja, PHP:llä tavallisia 
php-tiedostoja. Kummassakin on lähinnä HTML-koodia,
jonka seassa on hieman ohjelmakoodia.

Näkymissä ei ikinä käsitellä tietokantaa suoraan, ja erittäin 
harvoin niissä on varsinaista koodia yli kolmea riviä peräkkäin.
Sensijaan, että haettaisiin tiedot näkymässä suoraan kannasta
käytetään sovitun nimisiä muuttujia, joiden sisältö näytetään.
Se, mistä muuttujien sisältö tulee, näkymän ei tarvitse tietää mitään.
Sille riittää että tieto on siellä missä sen pitääkin. 
(Tiedon sijoittaminen oikeisiin muuttujiin on sitävastoinkontrollerin tehtävä.)

Ohessa esimerkki kahdella tiedostolla toteutetusta kissalistasta.
Jälkimmäistä tiedostoa voi käyttää myös muualla kissan näyttämiseen.

**views/kissalista.php**

~~~html<include src="esimerkit/kissalista.php" />~~~

**views/kissa.php**

~~~html<include src="esimerkit/kissa.php" />~~~

Yleensä on tapana myös tehdä muutama ns. template-näkymätiedosto,
joissa määritellään kaikille sovelluksen sivuille yhteisiä elementtejä.

## Kontrollerit

Kontrolleri (tunnetaan myös nimellä käsittelijä tai ohjain)
sitoo yhteen mallin ja näkymän ja välittää tietoa niiden välillä.

Kontrolleri vastaanottaa käyttäjältä tulevat aineistopyynnöt,
käyttää mallia tiedon hakemiseen ja muuttamiseen,
ja lopuksi yleensä siirtää suorituksen jollekin näkymälle.
Yleensä kontrolleri välittää samalla näkymälle jotain tietoa näytettäväksi,
esimerkiksi listan mallin palauttamia olioita tai virheviestin.

Kontrollerissa sensijaan **ei**  koskaan käsitellä tietokantaa suoraan, tai 
lähetetä selaimelle HTML:ää tai muuta sisältöä. 
Nämä ovat mallien ja näkymien tehtäviä.

Ohessa esimerkkejä kontrollereista PHP:llä ja Javalla

<tabs>
<tab title="Kontrolleri PHP:llä">

~~~~php<include src="../../../aikataulu/viikko3/php/esimerkit/kasittelija.php" />~~~~

</tab>
<tab title="Kontrolleri Javalla">

~~~~java<include src="esimerkit/KissaServlet.java" />~~~~

</tab>
</tabs>

## Koodin sijoittelu tiedostojärjestelmään

Eri osioiden koodit sijoitetaan käytetystä kielestä riippuen eri paikkaan.
Ohjaajien toiveet sijoittelusta ovat alla:

<tabs>
<tab title="PHP-esimerkkisijoittelu">

PHP:tä käytettäessä sijoita kaikki mallit 
ja näkymät omaan kansioonsa.
Käsittelijät taas sijoitetaan projektin juureen.
Näkymät sijoitetaan kansioon `views`.

Useimmiten on tarpeen luoda vielä oma kansionsa
yleiskäyttöisille kirjastotiedostoille, jotka
eivät varsinaisesti ole malleja.
Yleiskäyttöisen koodin kansion voi nimetä kuvaavasti
esim. `libs`. Luo malleille oma `models`-kansio yleiskäyttöisen koodin alle.

Kansioiden nimet voi halutessaan suomentaa.

~~~~<include src="../../../aikataulu/viikko3/php/kansiorakenne.txt" />~~~~

</tab>
<tab title="Java-esimerkkisijoittelu">

Javaa käytettäessä sijoita mallit 
ja kontrollerit omiin paketteihinsa
projektin yhteisen paketin alle src-kansioon.

Kontrollerit ovat Javan tapauksessa aina HttpServlet-luokan aliluokkia eli servlettejä, joten niiden paketin voi nimetä myös esim. `servletit`.

Näkymät - eli yleensä jsp-tiedostot - menevät omaan kansioonsa 
joka on oletuksena nimeltään web.

~~~~<include src="../../../aikataulu/viikko3/java/kansiorakenne.txt" />~~~~

</tab>
</tabs>

## Nyrkkisääntöjä

<include src="nyrkkisaannot.markdown" />

## Linkkejä

* [Model View Controller Explained](http://tomdalling.com/blog/software-design/model-view-controller-explained/)
* [A Really Simple Explanation Of MVC](http://www.strongandagile.co.uk/index.php/a-really-simple-explanation-of-mvc/)
* [Lyhyt PHP-esimerkki ohjelmointiputka.net:issä](http://www.ohjelmointiputka.net/oppaat/opas.php?tunnus=php_14#mvcmalli)
