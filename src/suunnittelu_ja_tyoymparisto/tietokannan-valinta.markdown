% Tietokannan valinta
<!-- order: 3 -->
<!-- tags: viikko1 -->

Laitoksen palvelimilla on käytössä kolme tietokantapalvelinta: Oracle, [MySQL](http://www.mysql.com/) ja [PostgreSQL](http://www.postgresql.org/).

Näistä Oracle on jo varsin vanhentunut, eikä sitä ole tietokantasovelluksessa käytetty aikoihin.
Sensijaan MySQL ja PostgreSQL ovat täysin tuettuja. Tämän kurssin näkökulmasta niillä ei ole juurikaan eroa.
MySQL on hieman yleisempi työmaailmassa, PostgreSQL taas on hieman edistyneempi joiltakin ominaisuuksiltaan.

Mikäli sinulla ei ole ennestään syytä valita jompaakumpaa, suositeltavaa on valita PostgreSQL,
sillä se on huomattavasti nätimmin tuettu laitoksen palvelimilla, sillä tarvitse erikseen käynnnistää ja sammuttaa siellä ja siihen saa myös etäyhteyden melko helposti, mikä on etenkin Javalla koodatessa kätevää.

MySql-tietokantaa ei pysty etäkäyttämään laitoksen tietokantasovelluspalvelimen ulkopuolelta.
Sitä on parasta käyttää ainoastaan, jos saat myös lokaaliin koodausympäristöösi MySql-tietokannan asennettua tai jos käytät esimerkiksi NetBeansia siirtääksesi PHP-sovelluksesi automaattisesti laitoksen palvelimelle, joka kerta kun testaat sitä.

Syy tähän on siinä, että kannan saa käynnistää users:illa vain unix-socketteja
kuuntelevaan tilaan, sillä usersin sisäiset TCP-portit on varattu tomcatin yhteyksille.

Samasta syystä MySQL:n käyttäminen Javalla users-palvelimella on hankalaa, sillä käytössä olevat kirjastot eivät tue suoria socket-yhteyksiä.

<next>
Kun olet valinnut aiheen ja haluamasi toteutustekniikat [dokumentoi ne työsi käyttötapaukset](alkudokumentointi.html).
</next>
