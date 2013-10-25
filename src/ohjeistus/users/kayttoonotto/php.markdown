% PHP-tuen käyttöönotto

PHP sivut sijoitetaan users-koneen käyttäjän htdocs hakemistoon tai sen alihakemistoon. 
Hakemiston htdocs saa luotua komentoskriptillä komennolla `wanna-htdocs`.

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

Siinä vaiheessa kun sivut ovat pystyssä htdocs-kansiossa olevaan PHP-tiedostoon `sivu.php` viitataan osoitteella:
_http://käyttäjätunnuksesi.users.cs.helsinki.fi/sivu.php_

Esimerkiksi _http://laine.users.cs.helsinki.fi/lahja/lahjax.php_ osoittaa php-tiedostoon _/home/laine/htdocs/lahja/lahjax.php_

Liitä PHP-tuen pystytyksen jälkeen dokumentaatiosi [Käynnistys- / käyttöohje -kappaleeseen]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje) 
sovelluksesi nettiosoite usersilla (tai muulla palvelimella, mikäli haluat käyttää sellaista).
Kappaleeseen ei tässä vaiheessa tarvitse kirjoittaa muuta sisältöä.

#### Virheilmoitukset
PHP:n virheilmoitukset kirjautuvat tiedostoon 
`/home/userlogs/käyttäjätunnuksesi.error`.
Uusimmat virheet löytyvät tiedoston lopusta. Kätevä tapa seurata PHP:n tuottamia virheviestejä on ajaa komento:

~~~~bash
tail -f /home/userlogs/$USER.error
~~~~

Komento näyttää viimeiset kymmenen virheviestiä ja jää komentoriville
seuraamaan virheviestejä näyttäen aina viimeisimmät. Kommenon pystyy sulkemaan
painamalla Ctrl+C:tä.

Virheloki saattaa ajoittain täyttyä seuraavanlaisista virheviesteistä:

~~~
[Mon Sep 09 16:58:56 2013] [error] [client 128.214.137.101] File does not exist: /home/consuegr/htdocs/favicon.ico
~~~

Virheistä pääsee halutessaan eroon laittamalla sovellukselleen [favicon.ico:n](http://fi.wikipedia.org/wiki/Favicon).
