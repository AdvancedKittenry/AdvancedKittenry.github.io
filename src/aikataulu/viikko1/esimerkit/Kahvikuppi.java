

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
