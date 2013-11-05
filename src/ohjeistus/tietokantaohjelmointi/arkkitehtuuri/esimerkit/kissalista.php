<?php
  /** Tiedosto, jonka tarkoituksena on näyttää lista kissoja.
    * Olettaa, että muuttujassa $tiedot on kentät kissat. */ 
?>
<h1>Kissat</h1>
<p>Kissoja yhteensä <?php echo count($kissat); ?> kpl</p>  
<div class="kissat">
  <?php foreach($kissat as $kissa): ?>
  <?php require 'kissa.php'; ?>
  <?php endforeach; ?>
</div>
