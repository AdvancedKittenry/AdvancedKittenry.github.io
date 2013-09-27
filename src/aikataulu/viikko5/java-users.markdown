% Java-työn vieminen users-palvelimelle

Helpoin tapa sovelluksen pystyttämiseen tomcatissa on nk. Web Archive eli WAR-paketti.
NetBeans osaa luoda WAR-paketin automaattisesti ja sijoittaa sen projektin `dist`-hakemistoon.

Sijoita WAR-paketti users-palvelimelle `~/tomcat/webapps/`-kansioon.
Tähän voit käyttää [scp-komentoa](http://linux.fi/wiki/Scp) tai Windowsilla [WinSCP](http://winscp.net/eng/index.php):tä.

Käynnistä Tomcat, jos se ei jo ole käynnissä. 
Usersin Tomcat on oletuksena konfiguroitu huomaamaan paketit automaattisesti 
ja hoitamaan niiden purkamisen ja asentamisen itsestään.
Nyt mikäli käyttäjätunnuksesi on `tunnus` ja pakettisi tiedostonimi on `paketti.war`,
sovelluksesi pitäisi olla käytettävissä osoitteessa
`http://t-tunnus.users.cs.helsinki.fi/paketti`.

Aiheesta voi lukea teknisempiä lisätietoja [Tomcatin ohjesivuilta](http://tomcat.apache.org/tomcat-6.0-doc/deployer-howto.html)
