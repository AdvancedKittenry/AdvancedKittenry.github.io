% NetBeansin käyttö Javan kanssa
<!-- tags: viikko1,viikko2-usefull -->

Näissä ohjeissa oletetaan, että olet jo [asentanut NetBeansiin kielesi web-tuen](index.html#web-tuen-asentaminen).

Luo NetBeansiin uusi projekti Kategoriasta Java Web.
Valitse Web Application.

![Uusi projekti]({{myimgdir}}java1-project.png)

Nimeä uusi projekti haluamallasi tavalla. 
Sijoita se sellaiseen paikkaan josta löydät sen tiedostot,
mutta **älä** kuitenkaan _samaan paikkaan git-repositoriosi_ kanssa!
NetBeans ei nimittäin anna luoda projektia kansioon, jossa on jo tiedostoja,
mutta luonnin jälkeen projektin voi siirtää repositorioon.

![Projektin tiedot]({{myimgdir}}java2.png)

Tässä vaihessa lomake kysyy sinulta mitä palvelinta
haluat käyttää. Mikäli sinulla on jo Apache käytössä, valitse se.
Todennäköisesti listassa ei ole mitään valintaa, jolloin sinun pitää valita `Add`.
Valitse palvelimeksi Apache Tomcat.

![]({{myimgdir}}java3-addserver.png)

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

![Apachen konfiguraatio]({{myimgdir}}java4-configure-apache.png)

Aseta palvelimen asetuksissa Java EE:n versioksi 5.

![Palvelimen asetukset]({{myimgdir}}java5.png)

Nyt voit klikkailla Next-nappia kunnes projekti on luotu:

![Projekti valmiina ajoon]({{myimgdir}}java6-readyToCompile.png)

Koeta ajaa projektisi Run Project-napista. 
Saatat saada eteesi hyvin kryptisen virheilmoituksen
ainakin laitoksen koneilla:

![Kryptinen virheilmoitus]({{myimgdir}}java7-virhe.png)

Ohjeen kirjoittaja sai projektinsa toimimaan
avaamalla `Tools`-valikosta 
valinta `Ant Library Manager` ja
säätämällä kirjaston CopyLibs Task ominaisuuksia.

Mikäli saat virheen laitoksen koneilla, lisää Classpathiin
osoite `/opt/netbeans-7.2/java/ant/extra`.
Tämän jälkeen NetBeans mystisesti löytää kirjastonsa.

![Kirjaston polkujen oikeat asetukset]({{myimgdir}}java8-tools-antLibraryManager.png)

Tämän jälkeen projektin ajamisen tulisi toimia
ja ajaessa avautua iloinen selainikkuna:

![Uusi projekti ensi kertaa ajossa]({{myimgdir}}java-final.png)

Mikäli et jostain syystä saa projektia toimimaan,
ota viipymättä yhteyttä ohjaajasi.

## Työn lisääminen versionhallintaan

Saatuasi projektin kerran toimimaan on aika lisätä se git-repositorioon.
Tämä tapahtuu suoraviivaisesti siirtämällä sen tiedostot 
repositorion juurikansioon.
Sulje kuitenkin ennen siirtoa projekti NetBeansin näkymästä ettei NetBeans mene siirrosta sekaisin.
Etsi tämän jälkeen projektisi tiedostojärjestelmästä
ja siirrä kaikki sen kansiossa olevat tiedostot 
omaan repositorioosi. 
Voit tämän jälkeen avata projektisi NetBeansillä
suoraan git-repositoriosi kansion avaamalla.

Siirron jälkeen repositoriosi sisältö on suurinpiirtein seuraava:

~~~
build/
  ... Projektin käännetyt luokat yms. ...
doc/
  ... Oma dokumentaatiosi ...
nbproject/
  ... NetBeansin projektitiedostoja ...
src/
  ... lähdekooditiedostoja ...
web/
  META-INF
  WEB-INF
  index.jsp
  ... näkymätiedostoja ...
build.xml
~~~

Osa näistä tiedostoista on käännösprosessin ja NetBeansin automaattisesti luomia ja niitä emme halua versionhallintaan.
Siispä, jos et ole sitä jo aiemmin tehnyt, luo repositoriosi _juurikansioon_ myös tiedosto
`.gitignore` ja laita siihen ainakin seuraavat rivit:

~~~
build
dist
nbproject/private
~~~

Näin versionhallintaan ei päästetä NetBeansiin koodia kääntäessä 
generoimia tiedostoja.
Lisää nyt repositorioosi kaikki uudet tiedostot, joita et juuri ignoroinut.
Nyt voit avata repositoriosi NetBeansillä uudestaan ja aloittaa koodauksen.

## Työn julkaiseminen usersille

Palutusta varte nsinun pitää vielä siirtää kotikoneella pyörivästä työstäsi versio
users-palvelimelle. 
Tämän voi tehdä kätevästi luomalla sovelluksesta julkaisua varte nwar-paketti ja siirtämällä sen usrsille.
Tähän on ohje [omalla sivullaan]({{rootdir}}koodaaminen/java/java-war-paketit.html).

<last>

Pystytettyäsi työympäristön ja sivut usersille,
varmista, että olet laittanut kaiken vaaditun dokumentaation
git-repositorioosi ja
rekisteröidy 
[labtooliin](http://tsoha-labtool.herokuapp.com/register).

Tämän jälkeen [viikon 1]({{rootdir}}aikataulu/viikkopalautukset/viikko1.html)
työsi on valmis!

</last>
