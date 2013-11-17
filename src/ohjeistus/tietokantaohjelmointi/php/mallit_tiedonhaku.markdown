% Malliluokat I: tiedon hakeminen
<!-- order: 4 -->
<!-- hidden! -->

<summary>
* Käytännössä jokaista tietokohdetta vastaa yksi malliluokka.
    * Puhtaille välitauluille harvemmin tarvitaan omaa luokkaansa, vaan niiden toiminnot hoidetaan itse tietokohteiden kautta.
    * Luokka sisältää tarvittavat metodit.
* Käytetyn SQL-koodin pitää olla turvallista niin, ettei se tarjoa mahdollisuuksia SQL-injektioille. Tähän käytetään PDO:n tai Javan JDBC:n prepared statements -tukia.

</summary>
