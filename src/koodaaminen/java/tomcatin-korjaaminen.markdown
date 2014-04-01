% Tomcatin ongelmien ratkominen
<!-- tags: viikko1,viikko2-usefull,viikko3-java-usefull -->

Tälle sivulle on koottu muutamia hyväksi havaittuja havaintoja 
Tomcatin ja context.xml-tiedoston kanssa tulleiden ongelmien korjaamisesta.

## Mistä virhettä kannattaa lähteä selvittämään?

NetBeansillä koodatessa kannattaa katsoa tarkkaan ohjelmaa ajettaessa tulevia lokitietoja.
Usersille siirrytyllä Tomcat-sovelluksella nämä eivät tosin näy suoraan missään,
mutta löytyvät silti kotihakemiston alla kansiosta `tomcat/logs`.
Viimeisimmät lokit ovat aina tiedostossa `tomcat/logs/catalina.out`.

Tiedoston sisältöä tutkimalla saa lähes aina selville ongelman syyn.
Hyvin usein syynä on väärinmuodostettu `context.xml`-tiedosto.

## Väärinmuodostettu context.xml

Useimmiten Tomcatin kanssa vastaantuleva ongelma on `context.xml`,
johon on pujahtanut epäkäypää XML:ää.
Alla hyvä esimerkki:

~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<Context antiJARLocking="true" path="/Kissalista-java" />
    <Resource name="jdbc/tietokanta" auth="Container"
        type="javax.sql.DataSource" removeAbandoned="true"
        removeAbandonedTimeout="30" maxActive="100"
        maxIdle="30" maxWait="10000" username="tunnus"
        password="salasana"
        driverClassName="org.postgresql.Driver"
        url="jdbc:postgresql://localhost/tunnus" />
</Context>
~~~

Koodi näyttää päällisin puolin oikealta,
mutta rivillä kaksi on virhe: `context`-tägin lopussa on tägin loppua symboloiva
kauttaviiva, vaikka tägin pitäisi loppua vasta viimeisellä rivillä olevaan lopetustägiin.

Seurauksena on toteutusympäristöstä riippuen erilaisia virheitä.
Esimerkiksi NetBeansillä ajettaessa seuraavanlainen tulee virhe:

~~~
[Fatal Error] :3:6: The markup in the document following the root element must be well-formed.
/home/tunnus/tsoha/Kissalista-java/nbproject/build-impl.xml:1038: 
Deployment error:
Tomcat configuration file /home/tunnus/tsoha/Kissalista-java/web/META-INF/context.xml seems to be broken. Please make sure it is parseable and valid.
See the server log for details.
~~~

### Context.xml:n korjaaminen usersin Tomcatilla

Jos virheellisen XML-tiedoston sisältävän sovelluksen pystyttää [WAR-tiedostona](java-war-paketit.html)
usersille, tulee sovelluksen tilalle vain 404 -sivu virheellä
"The requested resource (/Kissalista-java/) is not available."

Tomcatin lokeihin ilmaantuu tästä seuraavanlainen virhe:

~~~
1.4.2014 15:10:19 org.apache.catalina.startup.HostConfig deployWAR
SEVERE: Error deploying web application archive Kissalista-java.war
org.xml.sax.SAXParseException: The markup in the document following the root element must be well-formed.
~~~

Kinkkiseksi ongelman tekee se, että kun tähän virheeseen on kerran törmätty, ei 
Tomcat enää suostu purkamaan samalla nimellä olevaa WAR-pakettia, eikä edes näytä
myöhemmin palvelimelle laitetuista paketeista uusia virheitä lokeissa ellei Tomcat-palvelinta käynnistetä uudelleen!

Ongelma on kuitenkin onneksi melko helppo korjata. Ensiksi kannattaa sammuttaa
Tomcat komennolla `stop-tomcat`. 
Poista tämän jälkeen kansiosta `tomcat/conf/Catalina/localhost` omaa
projektiasi vastaava XML-tiedosto sekä kansiosta `tomcat/webapps` Tomcatin purkama
projektikansio.
Käynnistä sitten Tomcat uusiksi komennolla `start-tomcat`.

Sovelluksen pitäisi tämään jälkeen toimia normaalisti.
Joissain tilanteissa eteen tulee kuitenkin virhe `Service Temporarily Unavailable`.
Tästä ei kannata huolestua. Virhe johtuu pitkälti siitä, että usesin välityspalvelin on hieman hidas ja sen pitäisi mennä ohi ajan myötä. 
Jos näin ei kuitenkaan muutaman minuutin sisällä käy, pysäytä ja käynnistä Tomcat uudelleen.

