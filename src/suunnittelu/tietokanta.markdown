% Tietokannan suunnittelu
<!-- order: 5 -->

<summary>
* Suunnittele tietokantasi
* Luo dokumentaatioon asiaanliittyvät kaaviot ja kappaleet: 
    * [Järjestelmän tietosisältö]({{rootdir}}dokumentaatio-ohje.html#j%C3%A4rjestelm%C3%A4n-tietosis%C3%A4lt%C3%B6)
    * [Relaatiotietokantakaavio]({{rootdir}}dokumentaatio-ohje.html#relaatiotietokantakaavio)
* Sijoita uudet kappaleet samaan pdf-tiedostoon kuin aikaisempikin dokumentaatio
* Tee tietokantasuunnitelmistasi myös SQL-muotoinen versio, jonka voi ajaa tietokantaan.
    * Tiedostot uuteen `sql`-nimiseen hakemistoon.
    * Luo oma tiedosto taulujen luomiselle, testidatan syöttämiselle ja taulujen poistamiselle: `create-tables.sql`, `drop-tables.sql` ja `add-test-data.sql`.
* Jos et ole pitkään aikaan käyttänyt SQL-kieltä, kannattaa lukea alla oleva [SQL-opas](#lyhyt-sql-opas).
</summary>

## Alustava suunnittelu

Tee sovelluksellesi alustava käsitekaavio erittelemällä
tekemiltäsi sivuilta ja aihekuvauksesta kaikki tietokohteet
sekä niiden väliset riippuvuudet yhdellä kaaviolla:

![Esimerkki alustavasta käsitekaaviosta]({{myimgdir}}kasitekaavio.jpg)

Tässäkin voi olla vielä järkevää käyttää paperia tai valkotaulua, mutta jos
suunnitelma on päässäsi jo selkeä, voit käyttää suoraan kaavio-ohjelmistoa, jolloin jälki on siistimpää.
<expandable title="Siistimpi käsitekaavioversio (avaa tästä)">
![Esimerkki käsitekaaviosta]({{imgdir}}dokumentaatio-ohje/information_diagram.png)
</expandable>

Kaikki tähän alustavaan käsitekaavioon tulevat asiat eivät välttämättä ole
relevantteja ohjelman toteutuksen kannalta. Esimerkiksi
palveluskunta ei kokonaisuutena näyttele mitään roolia
ohjelman toiminnassa, vaan pääosassa ovat sen jäsenet.
Lopullisessa kissalistan toteutuksessa ei tämän takia ole palveluskunta-taulua. 
Hyvänä valintakriteerinä on se, sisältävätkö tietokohteen instanssit omia kenttiään, edes vaikkapa nimen,
vai ovatko ne vain täysin osasistaan koostuvia kokoelma.

## Taulujen ja niiden kenttien määrittely

Ota nyt jokainen tietokohde, ja määrittele mitä kenttiä siinä 
pitää olla, jotta kaikki sovelluksen tarvitsemat tiedot saadaan tallennettua. 

Kirjoita kentät ja niiden kuvaukset dokumentaatio-ohjeistuksen mukaisesti.
Alta voi katsoa esimerkkiä.

<expandable title="Tietokohdekuvausesimerkki">
<box>

<include src="../examples/tietokohdekuvaus.markdown" />

Katso lisätietoja [dokumentaatio-ohjeesta]({{rootdir}}dokumentaatio-ohje.html#Järjestelmän tietosisältö).

</box>
</expandable>

Tässä vaiheessa ei vielä tarvitse miettiä tietokantateknisiä ratkaisuja kuten autogeneroituja id-kenttiä tai viiteavaimia
vaan riittää että kirjoitat pelkät kuvaukset taulujen tiedoista ja viittauksista.

## SQL-alustustiedostojen luonti.

Kun olet suunnitellut kannan rakenteen ja kentät
toteuta suunnitelmasi SQL-kielellä.

Luo repositorioosi sql-kansio ja sijoita siihen kolme sql-tiedostoa:
`create-tables.sql`, `drop-tables.sql` ja `add-test-data.sql`.
Kirjoita näihin tiedostoihin tietokantasi alustavat create table -lauseet, drop table -lauseet, ja testidatan (oletuskäyttäjätunnusten yms.) luominen.

SQL-lauseiden sijoittaminen tiedostoihin mahdollistaa kannan 
helpon pystyttämisen ja alasajon. 
Kannattaa testailla tiedostoja ajamalla niitä tietokantaan samalla
kun niitä tekee. Näin huomaat heti, jos teet jonkin virheen.
Joudut todennäköisesti testaamaan tiedostojasi moneen otteeseen
ennen kuin ne toimivat moitteettomasti. 

SQL-tiedoston kantaan syöttämiseen on oma ohjeensa
[täällä]({{rootdir}}koodaaminen/kannan-alustus.html).

## Lyhyt SQL-opas

Jos et ole vähään aikaan ollut SQL-kielen kanssa tekemisissä voit kerrata
tästä. Kannattaa lukea etenkin kohdat avainten ja viiteavainten käytöstä, sekä [monesta moneen -suhteen toteuttamisohje](#monesta-moneen--suhde).

Taulujen luomisen syntaksiin voi hakea muistutusta
[W3Schoolsin sivuilta](http://www.w3schools.com/sql/sql_create_table.asp)

<vinkki title="Vinkki: Käytä hakukonetta">

Usein on huomattavasti helpompaa etsiä hakukoneella 
jotain tiettyä tietokannan ominaisuutta hakusanoilla tyyliin
`autogenerate id mysql` tai `data types postgres`
kuin koettaa etsiä niitä käsin tietokannan sivuilta.

</vinkki>

### Pääavaimet ja viittausavaimet

Käytännössä jokaisella tietokantasi taululla on erinäinen määrä *avaimia*.
Näistä tärkein on *pääavain*, joka yksilöi taulunsa rivit, ja johon
muut taulut voivat viitata *viiteavaimilla*.

Pääavaimen on tehokkuussyitä hyvä olla sellainen, jota ei tarvitse 
myöhemmin muutella usein. Joskus se voi olla jonkin asian nimi,
mutta useimmiten on helpompi käyttää yksinkertaista sarjanumerointia.
Tietokannat tarjoavatkin tähän valmiita ratkaisuja:

*Sarjanumerointi*

<sidebyside>
<column>

*PostgreSQL*

~~~sql
id SERIAL PRIMARY KEY
~~~

</column>
<column>

*MySQL*

~~~sql
id INTEGER PRIMARY KEY AUTO_INCREMENT
~~~
</column>
</sidebyside>

Molempien kantojen tapauksessa tälläiseen pääavaimeen viitataan seuraavasti:

~~~sql
kissa_id INTEGER REFERENCES kissa(id)
~~~

Huomaa, että PostgreSQL:n tapauksessa viittaava tyyppi on aivan erinäköinen kuin siihen viittaava tyyppi.
Tämä johtuu siitä, että SERIAL on PostgreSQL:ssä pelkkä lyhennemerkintä lauseelle `integer DEFAULT nextval('tablename_colname_seq') NOT NULL`,
joka samalla luo erillisen sekvenssin, josta tietoja haetaan.

Tälläinen viittaus myös antaa kannan varmistaa, että viitattu rivi on olemassa taulussa.
Määritelmän perään on myös mahdollista laittaa lisämääreitä, joilla määritellään
mitä tapahtuu, jos viitattu tietue poistuu kannasta tai viitattu arvo muuttuu:

~~~sql
kissa_id INTEGER REFERENCES kissa(id) ON DELETE cascade
                                      ON UPDATE cascade
~~~

Yllä oleva määritelmä poistaa viittaavan rivin kannasta, jos viitattu rivi poistetaan kannasta.
Samoin viittaus päivitetään jos viitattu avain muuttuu. 
Ellei mitään määritteitä ole laitettu kumpaakaan muutosta ei anneta tehdä, ellei samalla muuteta viittaavaakin taulua.

<comment>

Ehkä mielenkiintoisin tyyppi
Serial vs. integer
Viittausavaimet
</comment>

### Taulujen väliset suhteet

Määrittele kaikki projektisi tietokohteiden väliset riippuvuudet 
ja kunkin kohdalla se, onko kyseessä 
monesta-moneen-suhde, yhdest-moneen-suhde vai yhdestä-yhteen-suhde.
Erityyppiset suhteet toteutetaan tietokantatasolla eri tavalla.

#### Monesta yhteen -suhde

Yleisin taulujen välinen suhde on monesta yhteen suhde.
Nämä kuvaavat suhteita, joissa jokin asia kuuluu johonkin tai jollekin,
esimerkiksi kissa kuuluu rotuun, tai joku omistaa kissan.
Näitä suhteita mallinnetaan siten, että omistetut oliot sisältävät viiteavaimen omistajaansa.

![Monesta yhteen -suhde: Yhdellä kissalla voi olla vain yksi rotu, mutta rotuun voi kuulua monta kissaa.]({{myimgdir}}one-to-many.png)

#### Monesta moneen -suhde

Toiseksi yleisin suhde on monesta moneen -suhde, jossa molemmat osapuolet voivat olla yhteydessä useaan toiseen olioon. Tämän toteuttamiseksi tarvitaan nk. välitaulua, jossa on viiteavaimet molempiin suhteen tauluihin.

![Monesta moneen -suhde: Yhdellä kissalla voi olla monta ruokkijaa ja yhdellä palvelijalla monta ruokittavaa.]({{myimgdir}}many-to-many.png)

Huomaa, että kummassakaan tietokohteessa *ei* ole suoraa viittausta toiseensa vaan kaikki viittailu tapahtuu välitaulun avulla.
Välitaulussa ei myöskään välttämättä ole muuta sisältöä kuin
viittausavaimet, jotka toimivat samalla välitaulun pääavainparina.

#### Yhdestä yhteen -suhde

Yhdestä yhteen -suhteet ovat hyvin harvinaisia ja niitä näkee
lähinnä optimointeina. Ne toteutetaan yleensä siten, että molempien taulujen pääavaimet ovat samat ja viittaavaat toisiinsa.

![Yhdestä yhteen -suhde: Kissalla on tasan yksi kissakohtainen lisätietotietue]({{myimgdir}}one-to-one.png)

Useimmiten näin ei kuitenkaan kannata tehdä, vaan kannattaa sijoittaa kaikki
yhtä asiaa koskevat tiedot yhteen tauluun.
Hajauttamisella saavutettu hyöty kun on käytännössä yleensä hyvin pieni.

### Yleisimmät tietotyypit

|Käyttökohde               |Tietotyyppi |Huomioita |
|--------------------------|------------|----------|
| Numeeriset pääavaimet    | SERIAL, INTEGER AUTO_INCREMENT     | SERIAL-tyyppiseen avaimeen viitataan aina Unsigned Integer-tyyppisellä kentällä. MYSQL:ssä käytetään samaa tietotyyppiä, mutta lisätään perään määre AUTO_INCREMENT |
| Kokonaisluvut            | INTEGER    | Käytössä myös SMALLINT, jolla lukualue -32768:sta 32767:aan. Laittamalla eteen UNSIGNED luku pakotetaan positiiviseksi|
| Desimaaliluvut           | DECIMAL(n,k) | n määrittää luvun kokonaisosan maksimipituuden ja k desimaalipilkun jälkeen tulevan osan. Euroja voi mitata siis esim. tyypillä Decimal(10,2). |
| Merkkijonot              | VARCHAR(n) | n määrittää merkkijonon maksimipituuden. MySQL:ää käytettäessä n ei voi ylittää 65535 merkkiä. On myös olemassa fiksatun pituisille merkkijonoille tarkoitettu CHAR(n)-tyyppi, mutta sille on hyvin harvoin oikeaa käyttöä. |
| Kellonajat               | TIME | |
| Päivämäärät              | DATE | |
| Päivämäärät + kellonaika | DATETIME tai TIMESTAMP | PostgreSQL tuntee vain TIMESTAMP-tyypin, jonka arvoalue on hyvin laaja. MySQL tukee molempia ja tallentaa ne eri tavalla: MySQL:n TIMESTAMP on lukalueeltaan rajatumpi (70-luvulta n. vuoteen 2038), kun taas DATETIME sisältää ainakin vuodet 1001-9999. |
| Binääridata (esim. kuvat)| [BYTEA][bytea] tai [BLOB][blob] | [BYTEA][bytea] on PostgreSQL:n binääridatatyyppi, [BLOB][blob] taas MySQL:n binäärityyppi, josta on olemassa useita eri kokoisia versioita. | 

[bytea]: http://www.postgresql.org/docs/8.4/static/datatype-binary.html
[blob]: http://dev.mysql.com/doc/refman/5.1/en/blob.html

Lisätietoja löytyy kantojen omilta dokumentaatiosivuilta:

* [PostgreSQL:n tietotyypit](http://www.postgresql.org/docs/7.4/static/datatype.html)
* [MySQL:n tietotyypit](http://dev.mysql.com/doc/refman/5.1/en/data-type-overview.html)

<vinkki>
Merkkijonokenttien kanssa kannattaa muistaa tehdä kentistä riittävän pitkiä sisältämälleen datalle. Esim. sähköpostit ovat
helposti 30 merkkiä pitkiä ja nimetkin voivat yhdysnimien yms. myötä 
yltää yli kahteenkymmeneen merkkiin.

Salasanankentän voi toteuttaa joko paljaana salasanan sisältävänä
tekstikenttänä tai käyttää salasanojen 
[*hashausta*](https://crackstation.net/hashing-security.htm), 
jolloin kenttään pitää varata riittävästi tilaa hash- eli
*tiivistefunktion* tuottamalle tiivisteelle.

</vinkki>

## Linkkejä

* [MySql:n dokumentaatio](http://dev.mysql.com/doc/refman/5.1/en/index.html)
* [PostgreSql:n dokumentaatio](http://www.postgresql.org/docs/8.4/interactive/index.html)
* [W3Schoolsin SQL-intro](http://w3schools.com/sql/default.asp)
* Laineen tietokantojen perusteet -kurssin SQL materiaaleja
    * [Osa 1](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa1.pdf)
    * [Osa 2](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa2.pdf)
    * [Osa 3](http://www.cs.helsinki.fi/u/laine/tikape/moniste/osa3.pdf)

<vinkki>
Jos SQL-taitosi ovat pahasti ruosteessa, etkä saa kantaa pystyyn on usein helpointa tulla pajaan kysymään SQL-vinkkejä.
</vinkki>

<next>
Suunniteltuasi tietokannan rakenteen varmista, että
[saat sen pystyyn palvelimelle]({{rootdir}}koodaaminen/kannan-alustus.html).
</next>
