% HTML-versioiden luominen
<!-- order: 5 -->

<wip />

Tässä vaiheessa työtä siirrytään suunnittelusta käytäntöön
ja luodaan suunnitelluista sivuista oikean näköiset, mutta
vielä staattiset HTML-versiot.

## NetBeans-projektin luonti

Viimeistään tässä vaiheessa työlle kannattaa luoda NetBeans-projekti.
NetBeansia ei ole pakko käyttää, mutta etenkin Javalla koodatessa sen
koodingenerointi- ja refaktorointiominaisuuksista on paljon iloa.
Mikäli haluat ottaa NetBeansin käyttöön, klikkaa alla olevista
linkeistä auki NetBeans-ohjeita. 
Ohjeet on testattu toimiviksi laitoksen Linux-ympäristössä
NetBeansin versiolla 7.2.

Jos ohjeita seuratessa NetBeans kysyy sinulta keyringin salasanaa,
joka on vaihtunut, etkä tiedä mitä tehdä avaa vielä kolmas ohjelaatikko.
Tämä on hyvin yleinen ongelma laitoksen ympäristöissä, joissa salasanoja on vaihdettava usein.

<expandable title="Web-tuen asentaminen">
<box>
Mikäli et ole ladannut itsellesi web-tuen sisältävää NetBeansia
joudut tässä vaiheessa asentaaman NetBeansiisii käyttämäsi kielen web-tuen.

Tämä on melko helppoa, etsi <code>Tools</code>-valikosta kohta <code>Plugins</code> ja avaa se.
Tarkista välilehdeltä <code>Installed</code>, onko Java Web and EE tai PHP jo asennettuna.
Jos on, riittää että aktivoit sen. 

![Laajennosten aktivoiminen]({{myimgdir}}netbeans/activate-plugins.png)

Mikäli laajennokset eivät ole jo asennettuina, joudut etsimään ne <code>Available Plugins</code>-välilehden listasta
ja asentamaan ne sieltä. 
Javan tapauksessa etsi käsiisi laajennos Java EE Base, joka on kategoriassa Java Web and EE.
PHP-tukea varten riittää asentaa laajennos nimeltä PHP.

Saatat joutua ottamaan NetBeansin Update Centereitä käyttöön <code>Settings</code>-välilehdeltä käsin ja 
päivittämään laajennosten listan, että saat oikeat vaihtoehdot näkyviin. 

</box>
</expandable>


<expandable title="NetBeans-projektin pystytys Java-projektille">
<box>

Luo NetBeansiin uusi projekti Kategoriasta Java Web.
Valitse Web Application.

![Uusi projekti]({{myimgdir}}netbeans/java1-project.png)

Nimeä uusi projekti haluamallasi tavalla. 
Sijoita se sellaiseen paikkaan josta löydät sen tiedostot,
mutta **älä** kuitenkaan _samaan paikkaan git-repositoriosi_ kanssa!
NetBeans ei nimittäin anna luoda projektia kansioon, jossa on jo tiedostoja,
mutta luonnin jälkeen projektin voi siirtää repositorioon.

![Projektin tiedot]({{myimgdir}}netbeans/java2.png)

Tässä vaihessa lomake kysyy sinulta mitä palvelinta
haluat käyttää. Mikäli sinulla on jo Apache käytössä, valitse se.
Todennäköisesti listassa ei ole mitään valintaa, jolloin sinun pitää valita <code>Add</code>.
Valitse palvelimeksi Apache Tomcat.

![]({{myimgdir}}netbeans/java3-addserver.png)

Tässä vaiheessa NetBeans haluaa tietää mihin Tomcat on asennettuna, joten sinun pitää ladat se.
Tomcat 6 löytyy sivuilta [http://tomcat.apache.org/download-60.cgi](http://tomcat.apache.org/download-60.cgi) 
löytyvän Binary Distributions-kohdan "Core" alta. Sekä zip että tar.gz-pakkaus käy hyvin.

Kun olet ladannut tomcatin, luo ensiksi palvelinta varten oma kansio "palvelimet", jonka jälkeen ladattu tomcat-paketti puretaan kansioon.
Nyt sinulla on kansiossa ~/palvelimet/apache-tomcat-xxx asennettuna tomcatin xxx-versio. Oletamme tästä eteenpäin, että versio on 6.0.32.
Muuta vielä palvelimen käynnistys- ja sammutusskriptit siten, että niitä voidaan käyttää. 
Käynnistysskriptit löytyvät bin-kansiosta, ja ovat .sh-päätteisiä (.bat-päätteisiä Windows-ympäristöissä).

~~~~
~$ cd palvelimet/apache-tomcat-6.0.32/bin
~/palvelimet/apache-tomcat-6.0.32/bin$ chmod 700 *.sh
<comment>* Lopetetaan tyhmä vim-hilight.</comment>
~~~~

Hienoa! Nyt Tomcatin pitäisi olla käyttövalmis. Lisätään se NetBeansiin!
Tomcat-asetuksissa voit asettaa "manager"-roolin käyttäjätunnukseksi ja salasanaksi esimerkiksi "manager".

NetBeans saattaa tässä vaiheessa pyytää sinulta Gnomen avainnipun salasanaa, jos et saa avainnippua toimimaan, katso kolmas ohjelaatikko.

![Apachen konfiguraatio]({{myimgdir}}netbeans/java4-configure-apache.png)

Aseta palvelimen asetuksissa Java EE:n versioksi 5.

![Palvelimen asetukset]({{myimgdir}}netbeans/java5.png)

Nyt voit klikkailla Next-nappia kunnes projekti on luotu:

![Projekti valmiina ajoon]({{myimgdir}}netbeans/java6-readyToCompile.png)

Koeta ajaa projektisi Run Project-napista. 
Saatat saada eteesi hyvin kryptisen virheilmoituksen
ainakin laitoksen koneilla:

![Kryptinen virheilmoitus]({{myimgdir}}netbeans/java7-virhe.png)

Ohjeen kirjoittaja sai projektinsa toimimaan
avaamalla <code>Tools</code>-valikosta 
valinta <ocde>Ant Library Manager</code> ja
säätämällä kirjaston CopyLibs Task ominaisuuksia.

Mikäli saat virheen laitoksen koneilla, lisää Classpathiin
osoite <code>/opt/netbeans-7.2/java/ant/extra</code>.
Tämän jälkeen NetBeans mystisesti löytää kirjastonsa.

![Kirjaston polkujen oikeat asetukset]({{myimgdir}}netbeans/java8-tools-antLibraryManager.png)

Tämän jälkeen projektin ajamisen tulisi toimia
ja ajaessa avautua iloinen selainikkuna:

![Uusi projekti ensi kertaa ajossa]({{myimgdir}}netbeans/java-final.png)

Mikäli et jostain syystä saa projektia toimimaan,
ota viipymättä yhteyttä ohjaajasi.

Saatuasi projektin kerran toimimaan, sulje se NetBeansisin näkymästä
sulkematta kuitenkaan NetBeansia. 
Etsi tämän jälkeen projektisi tiedostojärjestelmästä
ja siirrä kaikki sen kansiossa olevat tiedostot 
omaan repositorioosi. 
Jos et ole sitä jo aiemmin tehnyt, luo repositorioosi myös tiedosto
<code>.gitignore</code> ja laita siihen ainakin seuraavat rivit:

~~~
build
dist
nbproject/private
~~~

Näin versionhallintaan ei päästetä NetBeansiin koodia kääntäessä 
generoimia tiedostoja.
Lisää nyt repositorioosi kaikki uudet tiedostot, joita et juuri ignoroinut.
Nyt voit avata repositoriosi NetBeansillä uudestaan ja aloittaa koodauksen.

</box>
</expandable>
<expandable title="NetBeans-projektin pystytys PHP-projektille">
<box>

Luo NetBeansiin uusi projekti Kategoriasta PHP.
Valitse PHP Application.

![]({{myimgdir}}netbeans/php1-project.png)

Nimeä projektisi ja osoita valinta Source Folder
git-repositorioosi. NetBeans kertoo että kansiossa
on tiedostoja, mutta se ei haittaa.

![]({{myimgdir}}netbeans/php2.png)

Konfiguroi seuraavassa ikkunassa projektisi
tyypiksi "Remote Web Site (FTP, SFTP)".
Laita kohtaan Project URL osoite
<code>http://kayttajatunnuksesi.users.cs.helsinki.fi</code>
ja kohtaan Upload Directory polku
<code>/htdocs</code>
Paina sen jälkeen Remote Connections -kohdassa olevaa <code>Manage</code>-nappia

![]({{myimgdir}}netbeans/php2.5-config.png)

NetBeans kysyy heti uuden yhteyden tietoja, anna yhteydelle nimi
Users ja laita tyypiksi SFTP.

![]({{myimgdir}}netbeans/php3-connection.png)

Nyt NetBeans antaa täyttää yhteyden tarkemmat tiedot.
Laita Host Name -kohtaan osoite <code>users.cs.helsinki.fi</code>
käyttäjätunnukseksi ja salasanaksi cs-tunnuksesi käyttäjätunnus ja salasanaa
ja kohtaan Initial Directory teksti </code>/home/kayttajatunnuksesi</code>
omalla käyttäjätunnuksellasi toki. 
Paina sen jälkeen nappia Test Connection ja jos yhteys toimii tallenna yhteyden tiedot.

NetBeans saattaa tässä vaiheessa pyytää sinulta Gnomen avainnipun salasanaa, jos et saa avainnippua toimimaan, katso kolmas ohjelaatikko.

![]({{myimgdir}}netbeans/php4-connectiondetails.png)

Klikkaa Next -nappia kunnes saat projektin luotua.

![]({{myimgdir}}netbeans/php-final.png)

Kun ajat projektin, NetBeans lähettää tiedostosi laitoksen
users-palvelimelle, jossa on PHP:tä pyörittävä palvelin asennettuna
sekä avaa selaimen projektisi etusivulle.
Joudut vielä aktivoimaan tämän palvelintilan ennenkuin
sivut toimivat.
Tee se seuraamalla [näitä ohjeita](http://www.cs.helsinki.fi/u/laine/tikas/php_ohje.html).

Viimeistään tässä vaiheessa, luo repositorioosi tiedosto
<code>.gitignore</code> ja laita siihen ainakin seuraava rivi:

~~~
nbproject/private
~~~

Aktivoituasi usersin PHP-tilan voit aloittaa koodaukseen tutustumisen index.php:n parissa.

</box>
</expandable>

<expandable title="Ubuntun oletusavainnipun nollaus">
<box>

Jos ohjeita seuratessa NetBeans kysyy sinulta keyringin salasanaa,
ja kertoo että kirjautumissalasanan vaihtumisen takia ei enää pääse
avainnippunu käsiksi, etsi käsiisi valikoista ohjelma nimeltä
"Passwords and Keys", joka näyttää tältä:

![Avainnippujen hallintaohjelma]({{myimgdir}}netbeans/passwords-and-keys.png)

Avainnippu, johon NetBeans yrittää päästä käsiiksi on yleensä se ainut
avainnippu Passwords-tabin alla. 
Klikkaamalla sitä hiiren oikealla napilla saat esiin valikon,
josta voit vaihtaa sen salasanan, mikäli tiedät mikä vanha salasana
avainnippuun käy. 

Yleensä tässä vaiheessa on helpompi vain poistaa
koko avainnippu, jolloin toki menettää kaikki tallennetut salasanansa,
mutta mikäli luet näitä ohjeita, et todennäköisesti pääse niihin käsiksi muutenkaan.
NetBeans ei nipun poistamisesta kaadu, vaan ainoastaan pyrkii luomaan uuden nipun,
joka tällä kertaa myös toimii asianmukaisesti.

</box>
</expandable>

## HTML-sivujen luonti

Tähän tulossa lyhyet ohjeet siitä, miten selkeällä HTML:llä ja CSS:llä
sekä [Bootstrapilla](http://getbootstrap.com/) saa aikaan siistit sivut.

Hyviä HTML-referenssejä:

* [HTML Dogin tutoriaalit](http://www.htmldog.com/) (HTML ja CSS) ovat lupsakoita ja perusteellisia. Suositellaan selattavaksi sivuja tehdessä! Tutoriaaleissa tehdään XHTML-sivuja, mutta ne on helppo soveltaa HTML5-sivuiksi (korvaa alun pitkä DOCTYPE lyhyellä HTML5-doctypellä).
* W3-konsortion sivuilta löydät alkuperäiset, kattavat standardit: [HTML5](http://www.w3.org/TR/html5/) ja [CSS(3)](http://www.w3.org/TR/CSS/) sekä aika hyvän [tutoriaali- ja referenssisivun](http://w3schools.com/html/html5_intro.asp).

<next>
Siirry suunnittelemaan sovelluksesi [tietokantaa](tietokanta.html), 
tai mikäli teit sen jo pystytä aikaansaannoksesi 
[users-palvelimelle](tekniikka.html).
</next>
