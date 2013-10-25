% Tiedostojen etämuokkaus Linuxilla

Gnomea työpöytäympäristönä käyttävissä Linux-jakeluissa, joihin laitoksenkin käyttämä Ubuntu kuuluu, on mahdollista käsitellä users-palvelimella sijaitsevia tiedostoja suoraan etäyhteyden yli.
Tämä onnistuu avaamalla järjestelmän oletustiedostoselain, Nautilus:
![Avaa nautilus]({{myimgdir}}nautilus-ssh/tsoha1crop.png)

Nautiluksen File-valikosta löytyy valinta Connect to server.
![File-valikosta löytyy Connect to server]({{myimgdir}}nautilus-ssh/tsoha2crop.png)

Valitse yhteystyypiksi SSH ja täytä loput tiedot kuvan mukaisesti. Laita tunnuksen tilalle Folder ja User name -valinnoissa oma käyttäjätunnuksesi.
![Loput tiedot täytetään näin]({{myimgdir}}nautilus-ssh/tsoha4crop.png)

Mikäli syötit tiedot oikein, pitäisi näytöllesi avautua users-palvelimen kotikansio.
Voit tästä navigoida esim. PHP-tiedostoja muokkaamaan kansioon htdocs.
Tiedostoja voi nyt avata, muokata, kopioida ja siirrellä kuten normaalisti.

![Avautuu uusi hakemistonäkymä]({{myimgdir}}nautilus-ssh/tsoha5crop.png)

Kätevä konsti on lisätä nyt avattu kansio nautiluksen bookmarkkeihin, niin siihen pääsee hyvin nopeasti käsiksi jatkossakin.

Hyvä kevyt editori tiedostojen muokkaamiseen on useimmissa Ubuntuissakin vakiona tuleva Gedit.

![Gedit]({{myimgdir}}nautilus-ssh/tsoha6crop.png)
