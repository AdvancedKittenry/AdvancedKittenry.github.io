import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

Connection yhteys = null;
PreparedStatement kysely = null;
ResultSet tulokset = null;

class Tietokanta {

  public static void teeAsioitaKannalla() throws Exception {
    try {
      //Haetaan context-xml-tiedostosta tietokannan yhteystiedot
      //HUOM! Tämä esimerkki ei toimi sellaisenaan ilman Tomcat-palvelinta!
      Context ctx = new InitialContext();
      DataSource yhteysVarasto = (DataSource) ctx.lookup("java:/comp/env/jdbc/tietokanta");

      //Otetaan yhteys tietokantaan
      yhteys = yhteysVarasto.getConnection();

      //Suoritetaan sql-kysely. Haetaan täysi-ikäiset Lehtoset tietokannasta
      String sql = "SELECT etunimi, sukunimi, ika FROM kayttajat WHERE ika >= ? and sukunimi = ?";
      kysely = yhteys.prepareStatement(sql);
      kysely.setInteger(1, 18);
      kysely.setString(2, "Lehtonen");
      tulokset = kysely.executeQuery();

      //Tulostetaan tietoja löydetyistä käyttäjistä
      while(tulokset.next()) {
        String nimi = tulokset.getString("etunimi") + " " +tulokset.getString("sukunimi");
        int ika = tulokset.getString("ika");
        System.out.println("Käyttäjän "+nimi+" ikä on "+ika);
      }

    } catch (Exception e) {
      throw e;
    } finally {
      //Suljetaan lopulta kaikki avatut resurssit
      try { tulokset.close(); } catch (Exception e) {  }
      try { kysely.close(); } catch (Exception e) {  }
      try { yhteys.close(); } catch (Exception e) {  }
    }
  }
}
