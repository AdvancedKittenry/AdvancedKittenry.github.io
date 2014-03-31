% Lyhyt PHP-opas Java-koodarille
<!-- tags: viikko2-usefull,viikko3-php-usefull,viikko4-php-usefull -->

PHP on enimmäkseen Javan kaltainen syntaksiltaan, mutta muutamia tärkeitä eroja on etenkin muuttujien ja oliosyntaksin kannalta.

Tärkein ero on varmaankin se, että muuttujia ei tarvitse
esitellä, vaan muuttujat luodaan ajonaikaisesti samalla, kun niihin sijoitetaan jotakin.

~~~inlinephp
$kissanVari = "keltainen";
~~~

Suurin ongelma tässä on väärin kirjoitetut muuttujanimet, jotka 
tuottavat virheen vasta ajonaikaisesti:

~~~inlinephp
if ($kissaVari == "punainen") {
  //Koodia, jota ei koskaan ajeta
}
~~~

PHP:n tapa toimia tälläisten virheiden kanssa on olettaa muuttujan sisältö
null:iksi ja jatkaa koodin suorittamista. Virhe selviää
vain katsomalla [virhelokeja](php-virheet.html),
joihin ilmestyy seuraavantapainen virhe:

~~~ 
PHP Notice:  Undefined variable: kissaVari in tiedosto.php on line 1
~~~

## Kahden merkkijonon yhteen liittäminen

Huomioinarvoista on kahden merkkijonon *konkatenoinnin*
hoitaminen eri operaattorilla:

<sidebyside>
<column>
**Java**

~~~java
String totuus = "Hauki on "+"kala";
~~~
</column>
<column>
**PHP**

~~~inlinephp
$totuus = "Hauki on "."kala";
~~~
</column>
</sidebyside>

## Olioiden ja luokkien käsittely

PHP:n oliosyntaksi on valitettavasti sekavampi kuin Javan käyttämä.
Metodien kutsumiseen käytetään syntaksia 
`$olio->metodi();`,
olion atribuutteja käytetään samaan tapaan `$olio->attribuutti`.

Sensijaan jos metodi, attribuutti, tai *vakio* on 
staattinen käytetään kahta kaksoispistettä ja atribuutin tapauksessa
vielä dollaria. 

Alla tiivistelmä PHP:n ja Javan tavoista käsitellä olioita ja luokkia.

|Ominaisuus|Java-toteutus|PHP-toteutus|
|:------|:-----|:-----|
|Instanssimetodi     |`olio.metodi()`|`$olio->metodi()`|
|Instanssin attribuutti|`olio.attribuutti`|`$olio->attribuutti`|
|Staattinen metodi     |`LuokanNimi.staattinenMetodi()`|`LuokanNimi::staattinenMetodi()`|
|Staattinen attribuutti|`LuokanNimi.attribuutti`|`LuokanNimi::$attribuutti`|
|Staattinen vakio      |`LuokanNimi.VAKION_NIMI`|`LuokanNimi::VAKION_NIMI`|

### Konstruktorit, metodit ja funktiot

Dynaamisen tyypityksen vuoksi myöskään metodeilla ei ole tyyppejä.
Niiden tilalla käytetään `function`-sanaa.
Konstruktorit määritellään erityisellä `__construct`-nimisellä funktiolla:

~~~php
<?php
  class Kala {
    private $nimi;

    public function __construct($nimi) {
      $this->nimi = $nimi;
    }

    public function getNimi() {
      return $this->nimi;
    }
  }
?>
~~~

Myöskin luokattomia funktioita on mahdollista tehdä:

~~~php
<?php
  function pertinLempijalkiruoka() {
    return "Vaniljavanukas";
  }
~~~


## Koodin näkyvyys

PHP:ssä kaikki luokat ovat samalla
näkyvyydellä, joten niihin ei tarvitse laittaa etuliitettä `public`.

Suoraa vastinetta `import`-lauseelle ei ole. Sen sijaan PHP:ssä käytetään
`include`ja `require` -funktioita muissa tiedostoissa olevan koodin ajamiseen.
Tällä tavalla myös näissä tiedostoissa olevat luokat saa käyttöönsä.
Funktioista on olemassa myös once-päätteiset versiot, jotka
ajavat tiedoston vain jos sitä ei ole aiemmin ajettu.

**Jokuluokka.php**

~~~php
<?php
  class JokuLuokka {
    const TARKOITUS = 42;
  }
?>
~~~

**jokukoodi.php**

~~~php
<?php
  require_once 'Jokuluokka.php';

  echo "Vastaus elämään, maailmankaikkeuteen ja kaikkeen muuhun sellaiseen on ".JokuLuokka::TARKOITUS;

?>
~~~

## Array, PHP:n lista- ja assosiaatiotaulutietorakenne {#array}

PHP:ssä listojen ja erilaisten assosiaatiotaulujen virkaa hoitaa yleiskäyttöinen
[array](http://php.net/manual/en/language.types.array.php)-tietotyyppi.
Arraytä käytetään hieman kuin javan taulukoita, mutta avaimena voi käyttää sekä kokonaislukuja, että merkkijonoja.
Yleensä erityyppisiä avaimia ei kuitenkaan kannata sekoittaa. 

Tyhjä array luodaan kielen sisäisellä array-konstruktiolla:

~~~inlinephp
  $a = array();
  $a[0] = "arvo";
  $a[1] = "toinen arvo";
~~~

Taulukkojen sisällön voi myös alustaa samalla kun ne luo. 
Oletuksena indeksointi alkaa nollasta.

~~~inlinephp
  $m = array(1,2,3,4);
  $m[0] == 1; //tosi
~~~

Numeroindeksoidun taulukon perään voi myös lisätä arvoja jättämällä sijoittaessa avaimen pois.

~~~inlinephp
  $m[] = 5; //Sama kuin sanoisi: $m[4] = 5;
~~~

Käytettäessä array-tietotyyppiä assosiaatiotauluna (vrt. Javan Map-tietotyyppi)
käytetään merkkijonoavaimia.
Avaimet voi määrittää myös array-kutsun sisällä käyttäen `=>`-operaattoria:

~~~inlinephp
  $kissa = array("nimi" => "Kasper", "rotu" => "Siamilainen");
  echo $kissa["nimi"]; //Tulostaa nimen Kasper.
~~~
