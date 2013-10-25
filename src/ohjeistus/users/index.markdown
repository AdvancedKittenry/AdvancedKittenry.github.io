% Users-palvelin ja töiden pystyttäminen

Lähes kaikki tietokantasovellukset tullaan pystyttämään laitoksen
users-palvelimelle, jolla on mahdollista pyörittää Javalla ja PHP:llä toteutettuja tietokantasovelluksia
käyttäen PostgreSQL- ja MySQL-tietokantapalvelimia.

Tällä kurssilla käytämme users-palvelinta ennenkaikkea 
töiden saamiseen julkisen internetin puolelle ajettavaksi.
Javaa käyttävät pystyvät melko helposti ajamaan [NetBeansin ja Tomcatin avulla](../netbeans.html)
töitänsä myös omalla koneellaan, mutta 
PHP:tä käytettäessä on käytännössä helpompi konfiguroida 
esim. NetBeans lähettämään tai tallentamaan tiedostot suoraan users-palvelimelle.
Tästä on [NetBeansille ohje](../netbeans.html) tai vaihtoehtoisesti voi käyttää
myös vaikkapa [Nautilusta ja Gedit:iä tiedostojen etämuokkaamiseen](../nautilus-ssh.html)


## Yhteyden ottaminen users-palvelimeen

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

# Jatkolukemista

* [Palvelinten ja tietokantojen käyttöönotto](kayttoonotto/index.html)
* [Omalla koneella tehdyn Java-työn vieminen users-palvelimelle](java-war-paketit.html)
* [Users-palvelimen tiivis ohjetiedosto](http://users.cs.helsinki.fi/README.users.cs.helsinki.fi.txt)
