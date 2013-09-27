% SSH-tunnelointi
<!-- order: 2 -->

Jos haluat käyttää users-palvelimen tietokantaa, etkä 
pystytä ohjelmaasi suoraan users-palvelimelle, joudut
tekemään palvelimen palomuuriin reiän tietokantayhtettä varten.
Tähän nk. ssh-tunneli on paras ja tietoturvallisin vaihtoehto.

Seuraava komento pystyttää SSH-tunnelin users-palvelimelle välittäen kaiken liikenteen tietokantapalvelimen portissa 5432 omalle koneellesi:

~~~ssh
ssh -L 5432:localhost:5432 tunnus@users.cs.helsinki.fi
~~~

Komento kirjautuu usersille normaalisti, mutta ohjaa samalla portin 5432
palvelimelta omalle koneellesi.
Jätä tämä komento pyörimään taustalle reitittämään tietokantayhteyksiä.

<alert>
Jos tietokantayhteytesi eivät yhtäkkiä toimikaan, kannattaa tarkistaa, että ssh-tunneli
on pystyssä.
</alert>

## Windows ja Putty

Windowsilla käytetään putty-ohjelmaa, jolle annetaan seuraavan näköiset asetukset:

![users-palvelimen yhteyden luominen]({{imgdir}}aikataulu/viikko2/putty-users.png)

![SSH-tunnelien määritteleminen putty-ohjelmalla]({{myimgdir}}users-tunneli.png)
