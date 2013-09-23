% Tietokantojen ja palvelimien käyttöönotto
<!-- order: 1 -->
<!-- addHeaderNavigation -->

Ota käyttöösi users-palvelimen Java- tai PHP-tuki, sekä käyttämäsi tietokanta.

## SSH-yhteydet

[putty]: http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html

Ensiksi sinun pitää kirjautua laitoksen tietokantasovelluspalvelimelle 
SSH:llä. Käytä Windowsissa [Puttyä][putty] ja muissa käyttäjärjestelmissä komentoriviä ja ssh-ohjelmaa.

Ssh-ohjelma toimii kirjoittamalla alla esitetyn tapainen komento komentoriville.
Ohjelma kysyy cs-tunnuksesi salasanaa ja päästää sinut sisälle palvelimeen.

~~~~bash
ssh kayttajatunnuksesi@users.cs.helsinki.fi
~~~~

Laitoksen koneilla toimii myös lyhyempi ja kätevämpi muoto:

~~~~bash
ssh users
~~~~

### SSH-yhteydet Windowsilla

Windowsin oma komentorivi on senverran kömpelö, että SSH-yhteyksiä varten on 
kehitetty oma komentoriviohjelmansa [Putty][putty].
Yhteyden saa aikaan kuvan mukaisella tavalla. 
Luotu yhteys kannattaa tallentaa
kirjoittamalla Saved sessions-tekstin alla olevaan kenttään yhteydelle nimi
ja painamalla Save-nappia. Yhteys tallentuu kentän alla olevaan listaan,
josta sen voi helposti avata kaksoisklikkaamalla sitä.

![users-palvelimen yhteyden luominen]({{imgdir}}aikataulu/viikko2/putty-users.png)

## Ohjelmointikielten ja tietokantojen aktivointi

Kun olet päässyt käyttämälläsi ssh-ohjelmalla sisään aktivoi valitsemasi ohjelmointikielen ja tietokannan tuki.

### Java-tuki

Lue sivu [Servlettien käyttö Tietokantasovellusten harjoitustyössä](http://www.cs.helsinki.fi/u/laine/tikas/material/servlet_ohje.html)
ja noudata sen ohjeita. 
Liitä tämän jälkeen dokumentaatiosi [Käynnistys- / käyttöohje -kappaleeseen]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje) 
sovelluksesi nettiosoite usersilla (tai muulla palvelimella, mikäli haluat käyttää sellaista).
Kappaleeseen ei tässä vaiheessa tarvitse kirjoittaa muuta sisältöä.

### PHP-tuki

PHP sivut sijoitetaan users-koneen käyttäjän htdocs hakemistoon tai sen alihakemistoon. 
Hakemiston htdocs saa luotua komentoskriptillä komennolla `wanna-htdocs`.

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

Siinä vaiheessa kun sivut ovat pystyssä htdocs-kansiossa olevaan PHP-tiedostoon `sivu.php` viitataan osoitteella:
_http://käyttäjätunnuksesi.users.cs.helsinki.fi/sivu.php_

Esimerkiksi _http://laine.users.cs.helsinki.fi/lahja/lahjax.php_ osoittaa php-tiedostoon _/home/laine/htdocs/lahja/lahjax.php_

Liitä PHP-tuen pystytyksen jälkeen dokumentaatiosi [Käynnistys- / käyttöohje -kappaleeseen]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje) 
sovelluksesi nettiosoite usersilla (tai muulla palvelimella, mikäli haluat käyttää sellaista).
Kappaleeseen ei tässä vaiheessa tarvitse kirjoittaa muuta sisältöä.

#### Virheilmoitukset
PHP:n virheilmoitukset kirjautuvat tiedostoon 
`/home/userlogs/käyttäjätunnuksesi.error`.
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

### PostgreSQL

PostgreSQL-kannan saat käyttöösi koneessa users.cs.helsinki.fi
skriptillä `wanna-postgres`. 
Ohjelma luo käyttäjätunnuksen ja arpoo salasanan ja kannan käyttöön tarvittavat porttinumerot ja hoitaa muut ympäristöasetukset.
Kun tunnus on luotu voi kantaa käsitellä käyttäen komentotulkkia `psql`. 
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
Usersilla tietokantayhteyden luomiseen tarvittava uusin PostgreSQL-ajuri löytyy tiedostosta `/usr/local/pgsql-7.4/jdbc.jar`.
Ohjelmassa tarvittava ajuriluokan nimi on org.postgresql.Driver. 
Tietokantayhteyteen tarvittava yhteystunnus on `jdbc:postgresql://localhost/username`. 

PHP:n PDO:lle riittää seuraava hyvin yksinkertainen koodi:

~~~php
<?php $yhteys = new PDO('psql:'); ?>
?>
~~~

</info>

### MySql

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

## Lisäluettavaa

* [Users-palvelimen tiivis ohjetiedosto](http://users.cs.helsinki.fi/README.users.cs.helsinki.fi.txt)

<next>
Siirry suunnittelemaan sovelluksesi [käyttöliittymää](suunnittelu.html), 
</next>
