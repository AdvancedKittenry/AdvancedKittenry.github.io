% Tietokantojen ja palvelimien käyttöönotto
<!-- order: 1 -->
<!-- addHeaderNavigation -->

Ota käyttöösi users-palvelimen Java- tai PHP-tuki, sekä käyttämäsi tietokanta.
Ensiksi sinun pitää kirjautua laitoksen tietokantasovelluspalvelimelle 
SSH:llä. Käytä Windowsissa [Puttyä](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) ja muissa käyttäjärjestelmissä päätettä ja ssh-ohjelmaa.
Ohjelma kysyy cs-tunnuksesi salasanaa ja päästää sinut sisälle palvelimeen.

~~~~bash
ssh kayttajatunnuksesi@users.cs.helsinki.fi
~~~~

Laitoksen koneilla toimii myös lyhyempi ja kätevämpi muoto:

~~~~bash
ssh users
~~~~

Kun olet päässyt sisään aktivoi valitsemasi ohjelmointikielen tuki.

## Java-tuki

* [Servlettien käyttö Tietokantasovellusten harjoitustyössä](http://www.cs.helsinki.fi/u/laine/tikas/material/servlet_ohje.html) 

## PHP-tuki

PHP sivut sijoitetaan users-koneen käyttäjän htdocs hakemistoon tai sen alihakemistoon. 
Hakemiston htdocs saa luotua komentoskriptillä komennolla <code>wanna-htdocs</code>.

PHP sivut ajetaan käyttäjän oikeuksin, eikä niille tarvita mitään erityisiä
luku- tai suoritusoikeuksia. Kuitenkin, jos php-sivuilla on viittauksia kuviin
tai muihin tähän hakemistoon tai sen alihakemistoihin sijoitettuihin
resursseihin kuten tyylitiedostoihin tai javascript koodiin, on näille
annettava laaja lukuoikeus ja hakemistoille läpikulkuoikeus. Myös staattisille
tavallisille html-sivuille on annettava maailmalle lukuoikeus. Seuraava komento
varmistaa riittävät oikeudet sekä koodihakemistoille, että niissä oleville
tiedostoille:

~~~~bash
chmod -R a+X $HOME $HOME/htdocs
~~~~

Mikäli sinulla on jo tiedostoja tässä hakemistossa, saat niille lukuoikeudet komennolla:

~~~~bash
chmod -R a+r $HOME/htdocs/*
~~~~

Siinä vaiheessa kun sivut ovat pystyssä htdocs-kansiossa olevaan PHP-tiedostoon <code>sivu.php</code> viitataan osoitteella:
_http://käyttäjätunnuksesi.users.cs.helsinki.fi/sivu.php_

Esimerkiksi _http://laine.users.cs.helsinki.fi/lahja/lahjax.php_ osoittaa php-tiedostoon _/home/laine/htdocs/lahja/lahjax.php_

### Virheilmoitukset
PHP:n virheilmoitukset kirjautuvat tiedostoon 
<code>/home/userlogs/käyttäjätunnuksesi.error</code>.
Uusimmat virheet löytyvät tiedoston lopusta. Kätevä tapa seurata PHP:n tuottamia virheviestejä on ajaa komento:

~~~~bash
tail -f /home/userlogs/$USER.error
~~~~

Komento näyttää viimeiset kymmenen virheviestiä ja jää komentoriville
seuraamaan virheviestejä näyttäen aina viimeisimmät. Kommenon pystyy sulkemaan
painamalla Ctrl+C:tä.

## PostgreSQL

* [Tietokannat Helsingin yliopiston tietojenkäsittelytieteen laitoksella](http://www.cs.helsinki.fi/u/laine/tikas/material/tietokannat.html) (vanhentunut, elä käytä oraclea)


<next>
Siirry suunnittelemaan sovelluksesi [käyttöliittymää](suunnittelu.html), 
</next>
