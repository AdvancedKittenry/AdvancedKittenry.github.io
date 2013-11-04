% ConnectionTest-testisovellus
<!-- order: 2 -->

Yhteystestiohjelma on pieni tiivis ohjelmapaketti, jolla sekä 
kurssilainen että ohjaaja pystyvät tarkastelemaan työssä käytetyn tietokannan tilaa
ja testaamaan tietokantayhteyttä.

Sovellus osaa myös ilmoittaa alkeellisella tasolla toimiiko yhteys 
ja mikä meni pieleen, jos yhteys ei toimi.

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
Ei siis välttämättä kannata ottaa sovelluksen arkkitehtuurista oppia omaan työhön.

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

Testisovelluksen Java-versio on helpointa asentaa [war-pakettina]({{rootdir}}ohjeistus/users/java-war-paketit.html).

Voit ladata paketin [githubista][javaConnectionTest]. 
Paketti on valitettavasti aika iso, sillä siihen on sisällytetty kaikki tarvittavat tietokanta-ajurit.

Lataamisen jälkeen sinun pitää säätää
XML-tiedostosta tietokannan yhteystiedot oikeiksi.
Tomcat tekee tiedostosta oman kopionsa oletuksena polkuun 
`tomcat/conf/Catalina/localhost/ConnectionTest.xml`.

Muista käynnistää tomcat uudelleen asetusten säätämisen jälkeen.

Sovelluksen pitäisi asennuksen jälkeen pyöriä osoitteessa [http://t-kayttajatunnuksesi.users.cs.helsinki.fi/ConnectionTest/](http://t-kayttajatunnuksesi.users.cs.helsinki.fi/ConnectionTest/)

[connectionTest]: https://github.com/AdvancedKittenry/connectionTest
[javaConnectionTest]: https://raw.github.com/AdvancedKittenry/connectionTest/master/java/dist/ConnectionTest.war
[phpConnectionTest]: https://raw.github.com/AdvancedKittenry/connectionTest/master/php/connectiontest.php

<next>
Kun olet saanut testisovelluksen näyttämään kannasta tietoja,
on aika koodata itse [ensimmäinen tietokantalistaus](listaustesti/index.html)
</next>
