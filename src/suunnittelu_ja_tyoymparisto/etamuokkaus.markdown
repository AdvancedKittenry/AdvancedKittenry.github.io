% Tiedostojen etämuokkaus Linuxilla
<!-- order: 8 -->
<!-- tags: viikko1,viikko2-usefull -->

Gnomea työpöytäympäristönä käyttävissä Linux-jakeluissa, joihin laitoksenkin käyttämä Ubuntu kuuluu, on mahdollista käsitellä users-palvelimella sijaitsevia tiedostoja suoraan etäyhteyden yli.
Tämä onnistuu avaamalla järjestelmän oletustiedostoselain, Nautilus:
![Avaa nautilus]({{myimgdir}}nautilus-ssh/tsoha1crop.png)

Paina näppäinyhdistelmää `Ctrl+L`. 
Selaimen osoitepalkkiin pitäisi avautua vapaa `Location`-tekstikenttä.
Kirjoita tähän kenttään seurava osoite siten, että korvaat molemmat sanat 
`tktlkayttajatunnus` omalla cs-tunnuksellasi.

~~~
sftp://tktlkayttajatunnus@users.cs.helsinki.fi/home/tktlkayttajatunnus
~~~

Paina seuraavaksi enteriä. Nautiluksen pitäisi kysyä salasanaa. Syötä cs-tunnuksesi salasana.

Mikäli syötit osoitteen ja salasanan oikein, pitäisi näytöllesi avautua users-palvelimella oleva kotikansiosi.
Voit tästä navigoida esim. PHP-tiedostoja muokkaamaan kansioon htdocs.
Tiedostoja voi nyt avata, muokata, kopioida ja siirrellä kuten normaalisti.

![Avautuu uusi hakemistonäkymä]({{myimgdir}}nautilus-ssh/tsoha5crop.png)

Kätevä konsti on lisätä nyt avattu kansio nautiluksen bookmarkkeihin, niin siihen pääsee hyvin nopeasti käsiksi jatkossakin.

Hyvä kevyt editori tiedostojen muokkaamiseen on useimmissa Ubuntuissakin vakiona tuleva Gedit.

![Gedit]({{myimgdir}}nautilus-ssh/tsoha6crop.png)
