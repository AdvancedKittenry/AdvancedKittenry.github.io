% Ohjelmointikielen valinta
<!-- order: 3 -->

Tietokantasovellukset kirjoitetaan yleensä joko Javalla tai PHP:llä.
Nämä ovat myös tällä hetkellä laitoksen palvelimella tuetut kielet
ja niillä tekemiseen pyritään kirjoittamaan ajantasaista dokumentaatiota.
Tämä sivu käsittelee lähinnä näitä kahta kieltä. 
Sovelluksen voi halutesaan kirjoittaa myös Pythonilla tai Rubyllä, 
kunhan sopii asiasta ohjaajan kanssa. 
Mitään kovin raskaita web-kirjastoja ei tällöinkään saa käyttä.
Esim. Ruby on Rails ei käy.

## Java ja PHP

Perussyntaksiltaan PHP ja Java ovat aika samanlaisia, sillä
molemmat ovat perineet syntaksinsa C-tyyppisiltä kieliltä.
PHP on tosin perinyt perliltä tavan käyttää dollaria <code>$muuttujien</code> nimissä.
Esimerkiksi luokka Kahvikuppi määriteltäisiin näissä kielissä seuraavasti:

<sidebyside>
<column>
**PHP**

~~~~ {.php}
<?php

class Kahvikuppi {

  /* Luokkamuuttujat */
  private $tekstiKyljessa;
  private $tayttoaste = 0;
  
  /* Konstruktori */
  function __construct($teksti) {
    $this->tekstiKyljessa = $teksti;
  }
  
  /* Metodeja */
  function kaadaKahvia($maara) {
    $this->tayttoaste += $maara;
    if ($this->tayttoaste > 100) {
      throw new Exception("Kahvikuppi valui yli");
    }
  }
  function juoTyhjaksi() {
    $this->tayttoaste = 0;
  }
  function getKahvinMaara() {
    return $this->tayttoaste;
  }
}
~~~~
</column>
<column>
**Java**

~~~~ {.java}


class Kahvikuppi {
  
  /* Luokkamuuttujat */
  private String tekstiKyljessa
  private int tayttoaste = 0;

  /* Konstruktori */
  Kahvikuppi(String teksti) { 
    this.tekstiKyljessa = teksti;
  }
  
  /* Metodeja */
  void kaadaKahvia(int maara) {
    tayttoaste += $maara;
    if (tayttoaste > 100) {
      throw new Exception("Kahvikuppi valui yli");
    }
  }
  void juoTyhjaksi() {
    tayttoaste = 0;
  }
  int getKahvinMaara() {
    return tayttoaste;
  }
}
~~~~
</column>
</sidebyside>

<alert>Tämän kirjoittaminen on vielä kesken</alert>

## Yhteenveto

Ominaisuus                       Java                          PHP
-------------------------------- ----------------------------- --------------------------------
Ajotapa                          Käännetään ennen ajoa         Tulkitaan ajonaikaisesti
Tyyppijärjestelmä                Vahva tyypitys                Heikko tyypitys
Paradigma                        Olio-ohjelmointi              Monia paradigmoja
-------------------------------- ----------------------------- --------------------------------

Voit tutustua myös Sami Saadan tekemiin esimerkkisovelluksiin 
[PHP](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/php-raaka) ja
[Java-kielellä](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/java-servlet).
Bonuksena samasta aiheesta on olemassa myös hyvin tiivis 
[Ruby-toteutus](https://github.com/tsoha-syksy2012/ostoslista-esimerkki/tree/ruby_sinatra_sequel) Sinatra-kehyksellä tehtynä.

<comment>
TODO:
lyhyet kuvaukset
  wikipedia
esimerkkisovellukset
</comment>

<ohje>
Kun olet valinnut aiheesi ja mieleisen ohjelmointikielen, aloita [dokumentaation](dokumentointi.html) tuottaminen.
</ohje>
