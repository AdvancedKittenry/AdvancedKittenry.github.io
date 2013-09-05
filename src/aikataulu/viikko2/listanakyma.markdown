% Listanäkymän suunnittelu
<!-- order: 2 -->

Tietokohteen listausta suunnitellessa tärkeintä ovat helppous ja selkeys.
Yksinkertaisimmillaan listaus voi olla pelkkä lista listattavien asioiden nimiä,
koodeja tai muita vastaavia tunnisteita, josta nimeä klikkaamalla pääsee käsiksi
lisätietoihin.  Usein on kuitenkin hyvä listata sovelluksen toiminnan kannalta
olennaisimmat tiedot (joskus peräti kaikki tiedot) listaukseen, jolloin tietoa
on helppo ja nopea löytää. Liikaa tietoa ei kuitenkaan yhteen näkymään kannata
ahtaa, sillä se vaikeuttaa olennaisten asioiden löytämistä.

Mikäli lista on hyvin pitkä, näytetään tarvittaessa siitä vain 
osa ja mahdollistetaan loppuosan selailu _sivunavigaation_ avulla.
Myös hakutoimintojen liittämistä sovellukseen kannattaa harkita,
varsinkin jos lista on pitkä ja sivutettu. Lyhyemmissä listoissa
voidaan turvautua selaimen hakutoimintoon. 
Myös listan näyttäminen aakkosjärjestyksessä helpottaa siitä hakemista.

![Kissalista, aakkosjärjestys tosin näkyy unohtuneen suunnittelijalta]({{myimgdir}}kissalista.png)

Listaa suunnitellessa kannattaa muistaa, että listalla on käytännössä kaksi
käyttötarkoitusta: tiedon ylimalkaisen selailun mahdollistaminen ja pääsy muokkaustoimintoihin.
Yleensä listan kohdetta klikkaamalla pääsee muokkaamaan sitä lomakkeella.
Lomake on yleensä omalla sivulla, mutta joskus on pätevää myös upottaa se
suoraan listauksen sisään, mahdollisesti niin, että se näytetään dynaamisesti
javascriptillä. Myös erilaiset yleisesti käytetyt toiminnot esim. asioiden
poistaminen, aktivoiminen tai sulkeminen, tai vaikka kissojen syöttäminen
saattaa olla järkevä laittaa listalle suoraan erilaisten nappien muodossa.
Samaan tapaan uuden kohteen lisääminen listaan on yleensä luontevaa laittaa
listan yhteyteen joko erillisenä linkkinä tai nappina, tai lomakkeena listan
ohessa.

<next>
Listanäkymien jälkeen on aika suunnitella [lomakenäkymät](lomake.html).
</next>
