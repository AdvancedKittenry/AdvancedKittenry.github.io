<?php 

  class View {
    
    /* Muuttuja, joka määrittelee, minkä nimisen näkymätiedoston luokka näyttää */
    private $viewName; 
      
    public function __construct($view) {
      $this->viewName = $view;
    }

    /* Yksityinen metodi, joka ajaa näkymätiedoston
     * koodin sellaisenaan
     */
    private function displayContent() {
      require 'views/'.$this->viewName.'.php';
    }

    /* Julkinen metodi, joka näyttää näkymän kokonaisuudessan.
     * Käyttää hyväksi template.php-runkoa, jossa kutsutaan,
     * displayContent-metodia oikeassa kohta.
     */
    public function display() {
      require 'views/template.php';
    }
      
  }
