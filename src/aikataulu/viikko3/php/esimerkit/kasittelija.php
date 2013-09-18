<?php 
  //Otetaan käyttöön kirjastotiedosto, joka hakee kasan omatekoisia yleistoimintoja, sekä malliluokka:
  require_once 'src/common.php';
  require_once 'src/models/kissa.php';

  //Kirjautuneet käyttäjät potkitaan pois
  if (Istunto::getKirjautunutKayttaja() == null) {
    ohjaa("login.php");
  }
  
  //Selvitetään onko käyttäjä tehnyt haun
  $hakusana = null;
  if (!empty($_GET['haku'])) {
    $hakusana = $_GET['haku'];
  }

  //Kutsutaan malliluokan staattista metodia
  $kissat = Kissa::hae($hakusana);
  
  //Alustetaan omatekoinen näkymäluokka ja näytetään näkymä asettaen sille muutamia muuttujia
  $view = new Nakyma("kissalista");
  $view->title = "Kissalista";
  $view->kissat = $kissat;
  $view->nayta();

  //Huom! <?php-tägiä ei tarvitse lopettaa tiedoston lopussa
