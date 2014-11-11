% ConnectionTest-testisovellus
<!-- order: 2 -->
<!-- tags: viikko2 -->

Yhteystestiohjelma *ConnectionTest* on pieni tiivis ohjelmapaketti, jolla sekä 
kurssilainen että ohjaaja pystyvät tarkastelemaan työssä käytetyn tietokannan tilaa
ja testaamaan tietokantayhteyttä.

Sovellus osaa myös ilmoittaa alkeellisella tasolla toimiiko yhteys 
ja mikä meni pieleen, jos yhteys ei toimi.

ConnectionTest ei ole varsinaisesti osa tietokantasovellustasi,
vaan sen tarkoitus on toimia työkaluna tietokannan kanssa
säätämiseen. 
Joillekin suora tietokantakomentorivin käyttö
voi olla nopeampaa, joskaan ohjaajasi ei tätä tapaa sinun kantaasi pysty käyttämään.

<alert>
Ladatessasi testisovelluksen tulet ajaneeksi omilla tunnuksillasi 
vierasta koodia. Varmista aina että lataat koodia luotettavasti lähteestä.

ConnectionTest-ohjelma on kurssin ohjaajien ylläpitämä
ja tarkoitettu täysin harmittomaksi työkaluksi.
Kurssin ohjaajat eivät kuitenkaan ota mitään vastuuta siitä, että
ohjelman käytön jälkeen leivänpaahtimesi syö kissasi tai mistään 
muistakaan ohjelman mahdollisesti tuottamista ikävyyksistä.
Ohjelmaa kuitenkin pyritään kehittämään, mikäli siitä löytyy bugeja.

Toisinsanoen: Käyttö omalla vastuulla. Bugiraportteja otetaan mieluusti vastaan.
</alert>

Ohjelman lähdekoodia voi tutkia myös [githubissa][connectionTest],
joskaan koodi ei ole aivan kaikista selkeintä mahdollista,
johtuen yrityksistä pitää sovellus mahdollisimman tiiviinä.
Ei siis välttämättä kannata ottaa testisovelluksen arkkitehtuurista oppia omaan työhön.

## PHP-testisovellus

PHP:llä toimiva testisovellus on helppokäyttöisyyden nimissä mahdutettu yhteen tiedostoon
ja sen voi ladata osoitteesta 
[https://raw.github.com/AdvancedKittenry/connectionTest/master/php/connectiontest.php][phpConnectionTest]

Eräs tapa asentaa sovellus on kirjautua usersille ja syöttää komentoriville

```
cd ~/htdocs
wget https://raw.github.com/AdvancedKittenry/connectionTest/master/php/connectiontest.php

```

Avaa tämän jälkeen sovellus jollain ohjelmalla (esim. nano) ja korjaa
sen ensimmäisillä riveillä olevat tietokantatunnukset omiksesi.
Korjausta vaativissa kohdissa lukee isolla FIXME.

## Java-testisovellus

Testisovelluksen Java-versio on helpointa asentaa war-pakettina.

Voit ladata paketin [githubista][javaConnectionTest]. 
Paketti on valitettavasti aika iso, sillä siihen on sisällytetty kaikki tarvittavat tietokanta-ajurit.
Noudata paketin ladattuasi [asennusohjeita täältä]({{rootdir}}koodaaminen/java/java-war-paketit.html).

Kun paketti on asennettu usersille sinun pitää vielä säätää
XML-tiedostosta tietokannan yhteystiedot oikeiksi.
Tomcat tekee tiedostosta oman kopionsa oletuksena polkuun 
`tomcat/conf/Catalina/localhost/ConnectionTest.xml`.

Avaa tämä XML-tiedosto jollain ohjelmalla (esim. nano) ja korjaa
siinä olevat tietokantatunnukset omiksesi.
Korjausta vaativia kohtia on kolme ja niissä lukee isolla FIXME. 
Tee muutoksia vain näihin kohtiin. 

Jos teet projektia Users-palvelimella ja käytät Postgresql-tietokantaa, 
täytä kohdat seuraavasti: "username" on yliopiston käyttäjätunnuksesi, 
ja kohdassa "password"-kysytyn salasanan löydät Users-palvelimen 
kotihakemistostasi tiedostosta nimeltä `.psql_password`. 
Viimeinen kohta, `url="jdbc:postgresql://localhost/FIXME_dbname"` 
kertoo Tomcatille tietokannan sijainnin ja nimen. 
Users-palvelimella tietokannan nimi on aina oma käyttäjätunnuksesi.

Esimerkiksi tunnuksella kumikumi ja tietokannan salasanalla abc123 
näyttää xml-tiedoston sisältö seuraavalta:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Context antiJARLocking="true" path="/ConnectionTest">
    <Resource name="jdbc/tietokanta" auth="Container"
        type="javax.sql.DataSource" removeAbandoned="true"
        removeAbandonedTimeout="30" maxActive="100"
        maxIdle="30" maxWait="10000" username="kumikumi"
        password="abc123"
        driverClassName="org.postgresql.Driver"
        url="jdbc:postgresql://localhost/kumikumi" />
</Context>

```

Muista käynnistää tomcat uudelleen asetusten säätämisen jälkeen.

Sovelluksen pitäisi asennuksen jälkeen pyöriä osoitteessa [http://t-kayttajatunnuksesi.users.cs.helsinki.fi/ConnectionTest/](http://t-kayttajatunnuksesi.users.cs.helsinki.fi/ConnectionTest/)

[connectionTest]: https://github.com/AdvancedKittenry/connectionTest
[javaConnectionTest]: https://raw.github.com/AdvancedKittenry/connectionTest/master/java/dist/ConnectionTest.war
[phpConnectionTest]: https://raw.github.com/AdvancedKittenry/connectionTest/master/php/connectiontest.php

<next>
Kun olet saanut testisovelluksen näyttämään kannasta tietoja,
on aika koodata itse ensimmäinen tietokantalistaus.

Tähän on kielikohtaiset ohjeet [PHP:lle](php/listaustesti.html)
ja [Javalle](java/listaustesti.html)
</next>
