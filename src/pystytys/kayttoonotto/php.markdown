% PHP-tuen käyttöönotto

PHP sivut sijoitetaan users-koneen käyttäjän htdocs hakemistoon tai sen alihakemistoon. 
Hakemiston htdocs saa luotua komentoskriptillä ajamalla komentotulkissa komento `wanna-htdocs`.

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

## Virheilmoitukset

<include src="../php-virheet.markdown" />

## Testitiedoston tekeminen

Testataksesi htdocs-nettisivutilaasi luo sinne tiedosto index.php
ja sijoita sinne jotain seuraavantapaista:

```php
<?php 
  $tervehdys = "Moi maailma!"; 
?><!DOCTYPE HTML>
<html>
<head><title><?php echo $tervehdys; ?></title></head>
<body>
  <h1><?php echo $tervehdys; ?></h1>
</body>
</html>
```

Sivun pitäisi näyttää tervehdys osoitteessa:
[http://kayttajatunnuksesi.users.cs.helsinki.fi/index.php](http://kayttajatunnuksesi.users.cs.helsinki.fi/index.php)

Liitä PHP-tuen pystytyksen jälkeen dokumentaatiosi [Käynnistys- / käyttöohje -kappaleeseen]({{rootdir}}dokumentaatio-ohje.html#käynnistys--käyttöohje) 
sovelluksesi nettiosoite usersilla (tai muulla palvelimella, mikäli haluat käyttää sellaista).
Kappaleeseen ei tässä vaiheessa (viikolla 2) tarvitse kirjoittaa muuta sisältöä.
