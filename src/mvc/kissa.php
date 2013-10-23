<?php
  /** Tiedosto, jonka tarkoituksena on näyttää kissan tiedot.
    * Olettaa, että muuttuja $kissa on asetettu. */ 
?><div class="kissa">
  <div class="row nimi">
    <label>Nimi:</label>
    <div class="value"><?php echo $kissa->getNimi(); ?></div>
  </div>
  <div class="row turkin_vari">
    <label>Turkin väri:</label>
    <div class="value"><?php echo $kissa->getTurkinVari(); ?></div>
  </div>
  <div class="row rotu">
    <label>Rotu:</label>
    <div class="value"><?php echo $kissa->getRotu(); ?></div>
  </div>
</div>
