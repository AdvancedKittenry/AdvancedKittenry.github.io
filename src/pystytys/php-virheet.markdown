% PHP:n virheilmoitusten katselu

PHP:n virheilmoitukset kirjautuvat users-koneella tiedostoon 
`/home/userlogs/käyttäjätunnuksesi.error`.
Uusimmat virheet löytyvät tiedoston lopusta. 
Kätevä tapa seurata PHP:n tuottamia virheviestejä on ajaa usersilla komento:

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
