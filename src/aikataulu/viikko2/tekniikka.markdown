% Tietokantojen ja palvelimien käyttöönotto
<!-- order: 1 -->
<!-- addHeaderNavigation -->

Ota käyttöösi users-palvelimen Java- tai PHP-tuki, sekä käyttämäsi tietokanta.
Ensiksi sinun pitää kirjautua laitoksen tietokantasovelluspalvelimelle 
SSH:llä. Käytä Windowsissa [Puttyä](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) ja muissa käyttäjärjestelmissä päätettä ja ssh-ohjelmaa.
Ohjelma kysyy cs-tunnuksesi salasanaa ja päästää sinut sisälle palvelimeen.

~~~~bash
ssh kayttajatunnuksesi@users.cs.helsinki.fi
~~~~

Laitoksen koneilla toimii myös lyhyempi ja kätevämpi muoto:

~~~~bash
ssh users
~~~~

Kun olet päässyt sisään aktivoi valitsemasi ohjelmointikielen tuki.

## Java-tuki

* [Servlettien käyttö Tietokantasovellusten harjoitustyössä](http://www.cs.helsinki.fi/u/laine/tikas/material/servlet_ohje.html) 

## PHP-tuki

PHP sivut sijoitetaan users-koneen käyttäjän htdocs hakemistoon tai sen alihakemistoon. 
Hakemiston htdocs saa luotua komentoskriptillä komennolla <code>wanna-htdocs</code>.

PHP sivut ajetaan käyttäjän oikeuksin, eikä niille tarvita mitään erityisiä
luku- tai suoritusoikeuksia. Kuitenkin, jos php-sivuilla on viittauksia kuviin
tai muihin tähän hakemistoon tai sen alihakemistoihin sijoitettuihin
resursseihin kuten tyylitiedostoihin tai javascript koodiin, on näille
annettava laaja lukuoikeus ja hakemistoille läpikulkuoikeus. Myös staattisille
tavallisille html-sivuille on annettava maailmalle lukuoikeus. Seuraava komento
varmistaa riittävät oikeudet sekä koodihakemistoille, että niissä oleville
tiedostoille:

~~~~bash
chmod -R a+X $HOME $HOME/htdocs
~~~~

Mikäli sinulla on jo tiedostoja tässä hakemistossa, saat niille lukuoikeudet komennolla:

~~~~bash
chmod -R a+r $HOME/htdocs/*
~~~~

Siinä vaiheessa kun sivut ovat pystyssä htdocs-kansiossa olevaan PHP-tiedostoon <code>sivu.php</code> viitataan osoitteella:
_http://käyttäjätunnuksesi.users.cs.helsinki.fi/sivu.php_

Esimerkiksi _http://laine.users.cs.helsinki.fi/lahja/lahjax.php_ osoittaa php-tiedostoon _/home/laine/htdocs/lahja/lahjax.php_

### Virheilmoitukset
PHP:n virheilmoitukset kirjautuvat tiedostoon 
<code>/home/userlogs/käyttäjätunnuksesi.error</code>.
Uusimmat virheet löytyvät tiedoston lopusta. Kätevä tapa seurata PHP:n tuottamia virheviestejä on ajaa komento:

~~~~bash
tail -f /home/userlogs/$USER.error
~~~~

Komento näyttää viimeiset kymmenen virheviestiä ja jää komentoriville
seuraamaan virheviestejä näyttäen aina viimeisimmät. Kommenon pystyy sulkemaan
painamalla Ctrl+C:tä.

Virheloki saattaa ajoittain täyttyä seuraavanlaisista virheviesteistä:

~~~
[Mon Sep 09 16:58:56 2013] [error] [client 128.214.137.101] File does not exist: /home/consuegr/htdocs/favicon.ico
~~~

Virheistä pääsee halutessaan eroon laittamalla sovellukselleen [favicon.ico:n](http://fi.wikipedia.org/wiki/Favicon).

## PostgreSQL

PostgreSQL-kannan saat käyttöösi koneessa users.cs.helsinki.fi
skriptillä <code>wanna-postgres</code>. 
Ohjelma luo käyttäjätunnuksen ja arpoo salasanan ja kannan käyttöön tarvittavat porttinumerot ja hoitaa muut ympäristöasetukset.
Kun tunnus on luotu voi kantaa käsitellä käyttäen komentotulkkia <code>psql</code>. 
Tulkki ei kysy salasanaa, vaan siirtyy suoraan tietokantakomentoriville.

Testaa tulkkia luomalla kantaan muutama testitaulu.
Tulkkia käyttäessä kannattaa varoa, ettei jätä lainausmerkkejä auki:

~~~~
consuegr=> select * from test where t1 = 'asdasd;
consuegr'> 
consuegr'> quit
consuegr'> '
consuegr-> ;
 t1 
 ----
 (0 rows)

~~~~

Huomaa kuinka käyttäjänimen jälkeen tuleva merkki vaihtuu sen mukaan mitä merkkiä tietokantatulkki odottaa seuraavaksi.

<info>
Usersilla tietokantayhteyden luomiseen tarvittava uusin PostgreSQL-ajuri löytyy tiedostosta <code>/usr/local/pgsql-7.4/jdbc.jar</code>.
Ohjelmassa tarvittava ajuriluokan nimi on org.postgresql.Driver. 
Tietokantayhteyteen tarvittava yhteystunnus on <code>jdbc:postgresql://localhost/username</code>. 

PHP:n PDO:lle riittää 
</info>

## MySql

MySql-kannan saat käyttöösi koneessa users.cs.helsinki.fi
skriptillä <code>wanna-mysql</code>. 
Ohjelma kysyy sinulta uuden tietokannan pääkäyttäjän salasanaa.
Pistä se johonkin ylös, sillä sitä ei tallenneta mihinkään siltä varalta että unohdat sen!
Ohjelma myös käynnistää tietokannan. Voit kirjautua sen komentotulkkiin komennolla

~~~bash
mysql -u root -p
~~~

Usersin MySql-tietokannat eivät ole julkisia, vaan ne ajetaan käyttäjäkohtaisina prosesseina palvelimella.
Tietokannan käynnistyksestä ja sammuttamisesta huolehdit sinä.
Voit manuaalisesti käynnistää ja sammuttaa tietokantaasi komennoilla <code>start-mysql</code> ja <code>stop-mysql</code>.
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

## Lisäluettavaa

* [Users-palvelimen tiivis ohjetiedosto](http://users.cs.helsinki.fi/README.users.cs.helsinki.fi.txt)

<next>
Siirry suunnittelemaan sovelluksesi [käyttöliittymää](suunnittelu.html), 
</next>
