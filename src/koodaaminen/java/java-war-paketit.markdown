% Kotikoneella tehdyn Java-työn julkaisu
<!-- tags: viikko1,viikko2-usefull,viikko3-java-usefull,viikko4-java-usefull -->

Helpoin tapa omalla koneella testatun sovelluksen pystyttämiseen tomcatissa on nk. Web Archive eli WAR-paketti.
NetBeans osaa luoda WAR-paketin automaattisesti ja sijoittaa sen projektin `dist`-hakemistoon, kun klikkaat sovelluksessa Build-nappia. NetBeans saattaa kysyä haluatko todella tehdä näin, voit vastata dialogiin valitsemalla "Clean and Build".

Sijoita WAR-paketti users-palvelimelle `~/tomcat/webapps/`-kansioon.
Tähän voit käyttää [Nautilusta]({{rootdir}}suunnittelu_ja_tyoymparisto/nautilus-ssh.html)
tai komentorivillä [scp-komentoa](http://linux.fi/wiki/Scp) 
Windowsilla [WinSCP](http://winscp.net/eng/index.php) hoitaa homman.

Käynnistä Tomcat, jos se ei jo ole käynnissä. 
Usersin Tomcat on oletuksena konfiguroitu huomaamaan paketit automaattisesti 
ja hoitamaan niiden purkamisen ja asentamisen itsestään.
Nyt mikäli käyttäjätunnuksesi on `tunnus` ja pakettisi tiedostonimi on `paketti.war`,
sovelluksesi pitäisi olla käytettävissä osoitteessa
`http://t-tunnus.users.cs.helsinki.fi/paketti`.

## Tietokanta-asetusten säätäminen

Mikäli sinun pitää säätää sovelluksen tietokanta-asetuksia, joudut kikkailemaan hieman lisää.
Puretun sovelluksen tietokanta löytyvät 
sen META-INF-hakemistosta `context.xml`-tiedostosta.

Tomcat on kuitenkin sinua juonikkaampi
ja kopioi tästä tiedostosta oman kopionsa,
joten tiedoston muokkaaminen ei vaikuta mihinkään.
Saadaksesi oikeat asetukset säädettyä
sinun tulee mennä hakemistoon `tomcat/conf/Catalina/localhost`
ja avata sovelluksesi nimellä varustettu XML-tiedosto,
esim. `kissalista.xml`. 

Tätä tiedostoa muokkaamalla saat tietokanta-asetukset kuntoon.
Tämän voi tehdä esimerkiksi nanolla tai [etänä geditillä]({{rootdir}}suunnittelu_ja_tyoymparisto/nautilus-ssh.html).

Muokkausten jälkeen sinun pitää vielä käynnistää tomcat-uudestaan
komennoilla `stop-tomcat` ja `start-tomcat`, jotta muutokset
näkyvät sivuilla.

## Sovellukseni ei suostu näkymään. Mitä teen?

Tarkita, että Tomcat on käynnissä ja purkanut 
sovelluksesi kansioon `tomcat/webapps`. Jos
näin on, voi kyse olla viallisesta
`context.xml`-tiedostosta.
Tämän korjaamiseen on oma ohjeensa [täällä](tomcatin-korjaaminen.html).

## Lisätietoja

Aiheesta voi lukea teknisempiä lisätietoja [Tomcatin ohjesivuilta](http://tomcat.apache.org/tomcat-6.0-doc/deployer-howto.html)
