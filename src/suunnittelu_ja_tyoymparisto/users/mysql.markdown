% MySql-tietokannan käyttöönotto
<!-- tags: viikko1 -->
<!-- order: 2 -->

MySql-kannan saat käyttöösi koneessa users.cs.helsinki.fi
skriptillä `wanna-mysql`. 
Ohjelma kysyy sinulta uuden tietokannan pääkäyttäjän salasanaa.
Pistä se johonkin ylös, sillä sitä ei tallenneta mihinkään siltä varalta että unohdat sen!
Ohjelma myös käynnistää tietokannan. Voit kirjautua sen komentotulkkiin komennolla

~~~bash
mysql -u root -p
~~~

Usersin MySql-tietokannat eivät ole julkisia, vaan ne ajetaan käyttäjäkohtaisina prosesseina palvelimella.
Tietokannan käynnistyksestä ja sammuttamisesta huolehdit sinä.
Voit manuaalisesti käynnistää ja sammuttaa tietokantaasi komennoilla `start-mysql` ja `stop-mysql`.
Sammuttaminen kysyy sinulta pääkäyttäjän salasanan.

Tätä tietokantaa ei pysty etäkäyttämään kovin helposti palvelimen ulkopuolelta, joten sitä on parasta käyttää ainoastaan,
jos saat myös lokaaliin koodausympäristöösi MySql-tietokannan asennettua tai 
jos käytät esimerkiksi NetBeansia siirtääksesi PHP-sovelluksesi automaattisesti Users-palvelimelle.

MySql:ään pätevät samat lainausmerkkejä koskevat huomiot kuin PostgreSQL:ään ylempänä.

<info>
Voit testata mysql-tietokantayhteyttä seuraavanlaisella lyhyellä PHP-tiedostolla:

~~~php
<?php
$p = new PDO('mysql:unix_socket=/home/consuegr/mysql/socket;dbname=test','root', 'salasana');
var_dump($p);
?>
OK
~~~

</info>

<alert>
Älä aja mysql-palvelintasi tilassa, jossa se kuuntelee TCP-yhteyksiä.
Normikäytöllä tähän ei päästäkään, mutta, 
jos jostain syystä harkitset haksoroivasi sen toimimaan niin, älä tee näin.

Syy tähän on siinä, että usersin käyttäjäkohtaiset htdocs ja tomcat-kansiot on
toteutettu sisäisesti tietyssä portissa toimivina palvelimen sisäisinä yhteyksinä
ja omat viritykset ovat ajoittain menneet niiden väliin.
</alert>

