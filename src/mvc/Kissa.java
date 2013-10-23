import Kissalista.Models.Tietokanta;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

class Kissa {
  
  private int id;
  private String nimi;
  private String turkinVari;
  private int rotuId;

  private Kissa(ResultSet tulos) {
    Kissa(
      tulos.getInteger("id"),
      tulos.getString("nimi"),
      tulos.getString("turkin_vari"),
      tulos.getInteger("rotuId")
    );
  }
  public Kissa(int id, String nimi, String vari, int rotuId) {
    this.id = id;
    this.nimi = nimi;
    this.turkinVari = vari;
    this.rotuId = rotuId;
  }
  
  /** Hakee tietokannasta yksittäisen kissan id-numeron perusteella */
  public static Kissa haeKissa(int id) throws Exception {
    Connection yhteys = null;
    PreparedStatement kysely = null;
    ResultSet tulokset = null;

    try {
      String sql = "SELECT * FROM kissat WHERE id = ?";
      yhteys = Tietokanta.getConnection();
      kysely = yhteys.getKysely(sql);
      kysely.setInteger(1, id);
      tulokset = kysely.executeQuery();

      if (tulokset.next()) {
        return new Kissa(tulokset);
      } else {
        return null;
      }

    } finally {
      try { tulokset.close(); } catch (Exception e) {  }
      try { kysely.close(); } catch (Exception e) {  }
      try { yhteys.close(); } catch (Exception e) {  }
    }

  }
  /** Hakee tietokannasta listan kissoja nimen perusteella */
  public static List<Kissa> haeKissat(String nimi) throw Exception {
    Connection yhteys = null;
    PreparedStatement kysely = null;
    ResultSet tulokset = null;

    try {
      String sql = "SELECT * FROM kissat WHERE nimi = ?";
      yhteys = Tietokanta.getConnection();
      kysely = yhteys.getKysely(sql);
      kysely.setString(1, nimi);
      tulokset = kysely.executeQuery();
      
      ArrayList<Kissa> l = new ArrayList<Kissa>();
      while (tulokset.next()) {
        l.append(new Kissa(tulokset));
      } 
      return l;

    } finally {
      try { tulokset.close(); } catch (Exception e) {  }
      try { kysely.close(); } catch (Exception e) {  }
      try { yhteys.close(); } catch (Exception e) {  }
    }

  }

  /** Tallentaa kissan tietokantaan */
  public boolean tallenna() throw Exception {
    Connection yhteys = null;
    PreparedStatement kysely = null;
    ResultSet tulokset = null;

    try {
      String sql = "INSERT INTO kissat(nimi, turkin_vari, rotuId) VALUES(?,?,?) RETURNING id";
      yhteys = Tietokanta.getConnection();
      kysely = yhteys.getKysely(sql);
      kysely.setString(1, nimi);
      kysely.setString(2, turkinVari);
      kysely.setInteger(3, rotuId);
      tulokset = kysely.executeQuery();
      
      if (tulokset.next()) {
        id = tulokset.getInteger("id");
        return true;
      } else {
        return false;
      }

    } finally {
      try { tulokset.close(); } catch (Exception e) {  }
      try { kysely.close(); } catch (Exception e) {  }
      try { yhteys.close(); } catch (Exception e) {  }
    }
  }
  /** Poistaa kissan tietokannasta */
  public boolean poista() throw Exception {
    Connection yhteys = null;
    PreparedStatement kysely = null;

    try {
      String sql = "DELETE FROM kissat where id = ?";
      yhteys = Tietokanta.getConnection();
      kysely = yhteys.getKysely(sql);
      kysely.setInteger(1, id);
      return kysely.execute();
    } finally {
      try { kysely.close(); } catch (Exception e) {  }
      try { yhteys.close(); } catch (Exception e) {  }
    }
  }

  /** Getterit ja setterit */
  public int getId() {
    return this.id;
  }
  public void setId(int id) {
    this.id = id;
  }

  public String getNimi() {
    return this.nimi;
  }
  public void setNimi(String nimi) {
    this.nimi = nimi;
  }

  public String getTurkinVari() {
    return this.turkinVari;
  }
  public void setTurkinVari(String turkinVari) {
    this.turkinVari = turkinVari;
  }

  public int getRotuId() {
    return this.rotuId;
  }
  public void setRotuId(int rotuId) {
    this.rotuId = rotuId;
  }
}
