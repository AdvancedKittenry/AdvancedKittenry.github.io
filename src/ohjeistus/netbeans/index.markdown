% NetBeansin käyttöönotto

Mikäli haluat ottaa NetBeansin käyttöön, asenna ensiksi siihen web-tuki
jonka jälkeen voit aloittaa projektin haluamallais kielellä.

Nämä ohjeet on testattu toimiviksi laitoksen Linux-ympäristössä
NetBeansin versiolla 7.2.

Jos ohjeita seuratessa NetBeans kysyy sinulta keyringin salasanaa,
joka on vaihtunut, etkä tiedä mitä tehdä, sinun pitää [nollata Ubuntun oletusavainnippu](keyring-reset.html).
Tämä on hyvin yleinen ongelma laitoksen ympäristöissä, joissa salasanoja on vaihdettava usein.

##Web-tuen asentaminen

Mikäli et ole ladannut itsellesi web-tuen sisältävää NetBeansia
joudut tässä vaiheessa asentaaman NetBeansiisii käyttämäsi kielen web-tuen.

Tämä on melko helppoa, etsi `Tools`-valikosta kohta `Plugins` ja avaa se.
Tarkista välilehdeltä `Installed`, onko Java Web and EE tai PHP jo asennettuna.
Jos on, riittää että aktivoit sen. 

![Laajennosten aktivoiminen]({{myimgdir}}activate-plugins.png)

Mikäli laajennokset eivät ole jo asennettuina, joudut etsimään ne `Available Plugins`-välilehden listasta
ja asentamaan ne sieltä. 
Javan tapauksessa etsi käsiisi laajennos Java EE Base, joka on kategoriassa Java Web and EE.
PHP-tukea varten riittää asentaa laajennos nimeltä PHP.

Saatat joutua ottamaan NetBeansin Update Centereitä käyttöön `Settings`-välilehdeltä käsin ja 
päivittämään laajennosten listan, että saat oikeat vaihtoehdot näkyviin. 

## Kielikohtaiset ohjeet

* [PHP-ohje](php.html)
* [Java-ohje](java.html)
