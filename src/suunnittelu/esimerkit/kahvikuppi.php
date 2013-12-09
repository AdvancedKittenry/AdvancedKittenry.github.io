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
