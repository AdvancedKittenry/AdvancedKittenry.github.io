% Tietokantayhteyden pystytys
<!-- hidden! -->


## Java ja SSH-tunnelointi

Seuraava komento pystyttää SSH-tunnelin users-palvelimelle välittäen kaiken liikenteen tietokantapalvelimen portissa 5432 omalle koneellesi:

~~~ssh
ssh -L 5432:localhost:5432 tunnus@users.cs.helsinki.fi
~~~

### Windows ja Putty

Windowsilla käytetään putty-ohjelmaa, jolle annetaan seuraavan näköiset asetukset:

![users-palvelimen yhteyden luominen]({{imgdir}}aikataulu/viikko2/putty-users.png)

![SSH-tunnelien määritteleminen putty-ohjelmalla]({{myimgdir}}users-tunneli.png)
