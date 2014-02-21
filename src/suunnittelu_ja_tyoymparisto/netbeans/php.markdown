% NetBeansin käyttö PHP:n kanssa
<!-- tags: viikko1,viikko2-usefull -->

Näissä ohjeissa oletetaan, että olet jo [asentanut NetBeansiin kielesi web-tuen](index.html#web-tuen-asentaminen).

Luo NetBeansiin uusi projekti Kategoriasta PHP.
Valitse PHP Application.

![]({{myimgdir}}php1-project.png)

Nimeä projektisi ja osoita valinta Source Folder
git-repositorioosi. NetBeans kertoo että kansiossa
on tiedostoja, mutta se ei haittaa.

![]({{myimgdir}}php2.png)

Konfiguroi seuraavassa ikkunassa projektisi
tyypiksi "Remote Web Site (FTP, SFTP)".
Laita kohtaan Project URL osoite
`http://kayttajatunnuksesi.users.cs.helsinki.fi`,
kohtaan Upload Directory polku
`/htdocs/tsoha` (tsohan voi korvata oman projektinsa nimellä)
ja kohtaan Upload Files
`On save`
Paina sen jälkeen Remote Connections -kohdassa olevaa `Manage`-nappia

![]({{myimgdir}}php2.5-config.png)

NetBeans kysyy heti uuden yhteyden tietoja, anna yhteydelle nimi
Users ja laita tyypiksi SFTP.

![]({{myimgdir}}php3-connection.png)

Nyt NetBeans antaa täyttää yhteyden tarkemmat tiedot.
Laita Host Name -kohtaan osoite `users.cs.helsinki.fi`
käyttäjätunnukseksi ja salasanaksi cs-tunnuksesi käyttäjätunnus ja salasanaa
ja kohtaan Initial Directory teksti `/home/kayttajatunnuksesi`
omalla käyttäjätunnuksellasi toki. 
Paina sen jälkeen nappia Test Connection ja jos yhteys toimii tallenna yhteyden tiedot.

NetBeans saattaa tässä vaiheessa pyytää sinulta Gnomen avainnipun salasanaa, jos et saa avainnippua toimimaan, katso kolmas ohjelaatikko.

![]({{myimgdir}}php4-connectiondetails.png)

Klikkaa Next -nappia kunnes saat projektin luotua.

![]({{myimgdir}}php-final.png)

Kun ajat projektin, NetBeans lähettää tiedostosi laitoksen
users-palvelimelle, jossa on PHP:tä pyörittävä palvelin asennettuna
sekä avaa selaimen projektisi etusivulle.
Joudut vielä aktivoimaan tämän palvelintilan ennenkuin
sivut toimivat.
Tee se seuraamalla [näitä ohjeita](http://www.cs.helsinki.fi/u/laine/tikas/php_ohje.html).

Viimeistään tässä vaiheessa, luo repositoriosi _juurikansioon_ tiedosto
`.gitignore` ja laita siihen ainakin seuraava rivi:

~~~
nbproject/private
~~~

Aktivoituasi usersin PHP-tilan voit aloittaa koodaukseen tutustumisen index.php:n parissa.

<last>

Pystytettyäsi työympäristön ja sivut usersille,
varmista, että olet laittanut kaiken vaaditun dokumentaation
git-repositorioosi ja
rekisteröidy 
[labtooliin](http://tsoha-labtool.herokuapp.com/register).

Tämän jälkeen [viikon 1]({{rootdir}}aikataulu/viikkopalautukset/viikko1.html)
työsi on valmis!

</last>
