% Ohjelmointikielen valinta
<!-- order: 2 -->

Tietokantasovellukset kirjoitetaan yleensä joko Javalla tai PHP:llä.
Nämä ovat myös tällä hetkellä laitoksen palvelimella tuetut kielet
ja niillä tekemiseen pyritään kirjoittamaan ajantasaista dokumentaatiota.
Tämä sivu käsittelee lähinnä näitä kahta kieltä. 
Sovelluksen voi halutessaan kirjoittaa myös esim. Pythonilla tai Rubyllä, 
kunhan sopii asiasta ohjaajan kanssa. 
Mitään kovin raskaita web-kirjastoja ei tällöinkään saa käyttää.
Esim. Ruby on Rails ei käy. 

Miettiessäsi jotain tuettujen kielien ulkopuolista kieltä, 
pitäydy mielummin kielissä ja kirjastoissa,
jotka osaat jo ja joille on olemassa hyvä dokumentaatio. 
Liian esoteerisillä välineillä tehdyillä töillä on usein tapana jäädä kesken.

## Java ja PHP

Perussyntaksiltaan PHP ja Java ovat aika samanlaisia, sillä
molemmat ovat perineet syntaksinsa C-kieleltä.
PHP on tosin lainannut Perliltä tavan käyttää dollaria `$muuttujien` nimien edessä.
Esimerkiksi luokka Kahvikuppi määriteltäisiin näissä kielissä seuraavasti:

<sidebyside>
<column>
**PHP**

~~~~php<include src="esimerkit/kahvikuppi.php" />~~~~
</column>
<column>
**Java**

~~~~java<include src="esimerkit/Kahvikuppi.java" />~~~~
</column>
</sidebyside>

Kuten esimerkeistä voi huomata, kielet ovat normaalissa olio-ohjelmoinnissa melko samanlaisia.
Suurin osa eroista on merkintätapaeroja, mutta eräs tärkeä ero esimerkistä näkyy. 
PHP:ssä ei koskaan määritetä muuttujalle tyyppiä, kuten Javassa tehdään.
PHP:ssä muuttujaan voi sijoittaa minkätyyppistä dataa tahansa
ja tietotyyppi voi jopa vaihdella ajon aikana.
Muuttujia ei PHP:ssä myöskään tarvitse esitellä mitenkään.
Esimerkkejä:

<sidebyside>
<column>
**PHP**

~~~~php<include src="esimerkit/tyyppisekoilua.php" />~~~~
</column>
<column>
**Java**

~~~~java<include src="esimerkit/tyyppisekoilua.java" />~~~~
</column>
</sidebyside>

Aiheesta lisää informaatiota [PHP:n manuaalissa](http://www.php.net/manual/en/language.types.type-juggling.php)

Javaa koodatessa joutuu kirjoittamaan hieman enemmän, mutta PHP:llä saattaa varsinkin aluksi tehdä tyyppivirheitä, jotka huomaa vasta ajon aikana.

### HTML:n käyttö

Toinen huomionarvoinen seikka PHP:tä kirjoittaessa on kielen käyttämät _\<?php-tägit_, jotka aloittavat PHP-koodin.
Niiden ulkopuolella olevan tekstin PHP oletuksena tulostaa sellaisenaan. 
Tämä tekee PHP:n käyttämisestä yksinkertaisten nettisivujen tekemiseen erittäin helppoa:

**helloworld.php**

~~~~php<include src="esimerkit/helloworld.php" />~~~~

Yllä oleva sivu toimii sellaisenaan, kun osoittaa selaimensa osoitteeseen, jossa helloworld.php-tiedosto sijaitsee.
Esim. `sivusto.fi/php-sovelluksen/osoite/helloworld.php`.
Javalla vastaavan tekeminen on hieman monimutkaisempaa ja vaatii Servlet-luokan ja template-tiedoston:

**src/java/servlets/HelloWorldServlet.java**

~~~~java<include src="esimerkit/HelloWorldServlet.java" />~~~~

**web/helloworld.jsp**

~~~~html<include src="esimerkit/helloworld.jsp" />~~~~

Ylläoleva ohjelma käynnistyy melko lailla PHP-esimerkin tapaan osoitteessa `sivusto.fi/java-sovelluksen/osoite/HelloWorld`.
Tässä käytetty JSP-tiedostoformaatti on Javan-vastaus PHP:n suoraviivaiselle tavalle käsitellä HTML:n tulostusta ja
sitä on varsin yksinkertaista käyttää.

Itse Java-ohjelmakoodi sensijaan on aika monimutkaista ja käyttää taustalla suurta määrää
Javan kirjastoja. Tätä ei kovin moni jaksaisi kirjoittaa, siksi ylläolevasta koodista suurin osa 
onkin NetBeansin autogeneroimaa, eikä kaikkea onneksi tarvitse kirjoittaa itse.

PHP on kielenä optimoitu nopeaan nettisivustojen kasaamiseen. Suuremmilla sivustoilla ja monimutkaisempia kehyksiä käytettäessä
PHP-koodikin alkaa muistuttaa yllä olevaa Java-koodia ja pitenee ja monimutkaistuu merkittävästi.
Yleisenä nyrkkisääntönä kuitenkin on, että pienikokoisempiin web-projekteihin - esimerkiksi tietokantasovelluksiin -
Java-koodia joutuu kirjoittamaan enemmän kuin vastaaviin PHP:llä tehtyihin sovelluksiin.

### Tietokannan käyttö

Sekä PHP että Java hoitavat tietokannan käytön oliopohjaisesti tavalla, 
joka mahdollistaa kielen sisäisten muuttujien upottamisen SQL-lausekkeisiin helposti
ja tietoturvallisesti.

**tietokanta.php**

~~~~php<include src="esimerkit/tietokanta.php" />~~~~

**tietokanta.java**

~~~~java<include src="esimerkit/Tietokanta.java" />~~~~

Yllä oleva Java-koodi hakee tietokannan tiedot xml-tiedostosta:

~~~~xml<include src="esimerkit/context.xml" />~~~~

PHP on tässäkin tapauksessa merkittävästi vähäsanaisempi. Taitava koodari lyhentää yllä olevasta
esimerkistä toistuvat koodinpätkät kuitenkin yleiskäyttöisiin metodeihin, jolloin lopullisessa käytössä
eri kielten tapa käsitellä tietokantaa on lähestulkoon yhtä monisanainen. Lisäksi Javan versiossa 7
resurssien sulkemisesta on [tehty automaattisempaa](http://stackoverflow.com/questions/9260159/java-7-automatic-resource-management-jdbc).
Valitettavasti tosin laitoksen palvelimilla oleva versio ei ole vielä ajan tasalla.

## Yhteenveto

Kumpaa sitten kannattaa käyttää? Sitä mikä tuntuu kotoisimmalta ja luonnollisemmalta.
Tätä nykyä suurin osa valitsee PHP:n sen keveyden takia, mutta kumpaankin kieleen
on tarjolla varsin mallikkaat välineistöt tietokantasovelluksen tekemiseen.

Ominaisuus                       Java                          PHP
-------------------------------- ----------------------------- --------------------------------
Ajotapa                          Käännetään ennen ajoa         Tulkitaan ajonaikaisesti
Tyyppijärjestelmä                Vahva tyypitys                Heikko tyypitys
HTML:n tuottaminen               JSP-kielellä                  Suoraan PHP-koodin sisällä
Konfigurointi                    Lukuisilla XML-tiedostoilla   Monia tapoja. Mahdollista suoraan koodissa.
-------------------------------- ----------------------------- --------------------------------

Voit tutustua myös Sami Saadan tekemiin esimerkkisovelluksiin 
[PHP](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/php-raaka) ja
[Java-kielellä](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/java-servlet).
Bonuksena samasta aiheesta on olemassa myös hyvin tiivis 
[Ruby-toteutus](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/ruby_sinatra_sequel) Sinatra-kehyksellä tehtynä.

Linkkejä: 

* [Javan EE dokumentaatio](http://docs.oracle.com/javaee/)
* [PHP:n dokumentaatio](http://www.php.net/manual/en/)

<next>
Kun olet valinnut aiheesi ja mieleisen ohjelmointikielen, vilkaise [tietokannan valitsemista](tietokannan-valinta.html).
</next>
