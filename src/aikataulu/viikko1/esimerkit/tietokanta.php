<?php
  //Otetaan yhteys mysql-tietokantaan
  $yhteys = new PDO("mysql:host=localhost;dbname=tietokannan_nimi", "kayttaja", "salasana");

  //Suoritetaan sql-kysely. Haetaan täysi-ikäiset Lehtoset tietokannasta
  $sql = "SELECT id, nimi, osoite FROM kayttajat WHERE ika >= ? and sukunimi = ?";
  $kysely = $yhteys->prepare($sql);
  $tulokset = $kysely->execute(array(18,"Lehtonen"));

  //Tulostetaan tietoja löydetyistä käyttäjistä
  while($rivi = $tulokset->fetchObject()) {
    echo "Käyttäjän $rivi->etunimi $rivi->sukunimi ikä on $rivi->ika";
  }

  //PHP sulkee yhteydet ja resurssit automaattisesti
  //suorituksen päätteeksi
