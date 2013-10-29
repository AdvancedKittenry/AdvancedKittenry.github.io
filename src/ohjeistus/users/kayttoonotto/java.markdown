% Java ja Tomcatin käyttöönotto

Javalla tehdyt tietokantasovellukset 
asennetaan laitoksen users-palvelimella Tomcat-ohjelmiston alle.
Ohjelmisto osaa pyörittää allaan useita Javalla tehtyjä *sovelluksia*,
jotka ovat käytännössä toisistaan erillään pyöriviä ohjelmistopaketteja.

## Tomcatin käyttöönotto

Tomcatin saa otettua käyttöön omille tunnuksilleen
kirjautumalla users-palvelimelle ja ajamalla siellä komento `wanna-tomcat`

Komento luo hakemiston `tomcat` ja asentaa sinne tarvittavat tiedostot
tietokantasovellusten ajamiseen.
Se luo myös hakemiston `tomcat/webapps`,
jonne voidaan sijoittaa ajettavia Java-sovelluksia
kunkin omaan hakemistoonsa. 
Lisäksi asennusskripti luo `webapps`-hakemistoon valmiiksi testiprojektin nimeltä `tsoha`.

Jotta mitään tietokantasovellusta voidaan ajaa, pitää tomcat ensin käynnistää.
Tähän voi käyttää komentoa `start-tomcat`.
Komento käynnistää Tomcat-palvelimen ja kertoo samalla
mistä osoitteesta työsi tulee löytymään.

Osoite on mallia
[http://t-käyttäjätunnuksesi.users.cs.helsinki.fi/](http://t-käyttäjätunnuksesi.users.cs.helsinki.fi/)
Missä aivan ensimmäisenä osana on yliopiston käyttäätunnuksesi,
jota edeltää merkkijono "t-".
Laittamalla osoitteen perään jonkin `webapps` hakemistossa olevan
sovelluksen nimen, pääsee käyttämään tätä sovellusta.
Esimerkiksi tsoha-sovellusta voi käyttää laittamalla osoitteen perään `tsoha/esim.html`.

Tomcatin voi myös sammuttaa komennolla `stop-tomcat`.
Kurssin ajan lienee hyvä pitää Tomcat:ia päällä melko jatkuvasti,
että ohjaajasi pystyy testaamaan työtäsi.

Mikäli työsi ei näy internetissä on siihen useimmiten syynä se, ettei Tomcat ole päällä.

## Sovelluksien pystyttäminen ja koodaus

Kun olet saanut testisovelluksen toimimaan,
sinulla on kaksi vaihtoehtoa sovelluskehitykseen.

Voit lähteä rakentamaan sovellusta suoraan users-palvelimelle.
Tällöin tsoha-sovelluksen rakenteesta voi ottaa mallia.
Ratkaisu on siitä hyvä, että kaikki pyörii silloin samalla koneella,
mutta joudut [muokkaamaan tiedostoja etänä](../nautilus-ssh.html) ja kääntämään työtäsi käsin.
Työn kääntäminen tsoha-projektissa tapahtuu menemällä komentorivillä hakemistoon `src`
ja ajamalla ohjelma `ant`. Ant kääntää työn puolestasi ja asentaa luokat oikeisiin paikkoihin.
Tätä varten tarvitset samassa hakemistossa olevan `build.xml`-tiedoston, jonka voi kopioida tsoha-projektin `src`-hakemistosta.

<comment>
Löpinää `WEB-INF`-kansiosta, xml-tiedostoista, src-kansiosta.
</comment>

Toinen ja useimmiten kätevämpi vaihoehto on käyttää [NetBeansiä ja asentaa tomcat omalle koneelleen](../../netbeans.html). 
Tässä vaihtoehdossa on se hyvä puoli, että alkuosan koodin kirjoittamisen
voi tehdä kokonaan omalla tietokoneellaan, mutta tietokannan käyttöä varten
tarvitsee aina [muodostaa etäyhteys](../postgres-ssh-tunneli.html),
ellet asenna tietokantapalvelinta koneellesi itse.
NetBeansin käytössä on myös se hyvä puoli, että sen tarjoama
tuki nettipuolen Javalle on erinomainen ja auttaa monien koodausongelmien kanssa.

### Muualla testatun sovelluksen asentaminen

Mikäli käytät NetBeansiä lokaaliin koodailuun, 
joudut aika-ajoin kuitenkin pystyttämään työsi users-palvelimelle testattavaksi.
Tämä on onneksi melko yksinkertainen toimenpide ja siihen on [oma ohjeensa](../java-war-paketit.html).

## Testitiedoston tekeminen

index.jsp

Sivun pitäisi näyttää tervehdys osoitteessa: \
[http://t-kayttajatunnuksesi.users.cs.helsinki.fi/sovelluksen_nimi/index.jsp](http://t-kayttajatunnuksesi.users.cs.helsinki.fi/sovelluksen_nimi/index.jsp)

Liitä Tomcatin asennuksen jälkeen dokumentaatiosi [Käynnistys- / käyttöohje -kappaleeseen]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje) 
sovelluksesi nettiosoite usersilla (tai muulla palvelimella, mikäli haluat käyttää sellaista).
Kappaleeseen ei tässä vaiheessa (viikolla 2) tarvitse kirjoittaa muuta sisältöä.

## Linkkejä

* Hieman vanhentunut, mutta kattava alkuperäinen Servlet-opas: [Servlettien käyttö Tietokantasovellusten harjoitustyössä](http://www.cs.helsinki.fi/u/laine/tikas/material/servlet_ohje.html)
