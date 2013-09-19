<?php
  include 'tietokantayhteys.php';
  $yhteys = new PDO('psql:');
  $nimi = 'Matti';
?><!DOCTYPE html>
<html>
  <head><title>PHP Page</title></head>
  <body>
    <h1>Hello <?php $nimi; ?></h1>
    <?php 

      $sql = "SELECT id, nimi, osoite FROM kayttajat WHERE ika >= ? and sukunimi = ?";
      $kysely = $yhteys->prepare($sql);
      $tulokset = $kysely->execute(array(18,"Lehtonen"));
      //Tulostetaan tietoja löydetyistä käyttäjistä
      while($rivi = $tulokset->fetchObject()) {
        echo "<div>Käyttäjän $rivi->etunimi $rivi->sukunimi ikä on $rivi->ika</div>";
      }

    ?>
  </body>
</html>
