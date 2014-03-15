% Työn esittelysivu
<!-- order: 0 -->

Jokaisella viikolla sovelluksen kannalta olennaisimmat tiedot 
ja linkit kootaan nettiin erillisille työn esittelysivulle, 
joka myös syötetään labtoolin testiosoitteeksi.

Tämän osoitteen on näyttävä internetissä. Paras tapa on 
sijoittaa se repositorionsa juureen ja varmistaa että 
repositorio näkyy [users-palvelimella]({{rootdir}}suunnittelu_ja_tyoymparisto/users/index.html).

Suositeltavaa on nimetä esittelysivu nimellä `esittelysivu.html` 
ja laittaa se oman repositorion juureen.

## Sivun sisältö

Ensimmäisellä viikolla sivulle laitetaan linkit työn
dokumentaatioon (githubissa tai users-palvelimella)
sekä linkki sovelluksen pystytettyyn versioon users-palvelimella.

Tällöin sivusta tulee aikalailla seuraavan näköinen:

<box>
<iframe style="min-height:220px; border: 0px;" src="{{rootdir}}src/{{curdir}}esittelysivu/esittelysivu.html" ></iframe>
</box>

Kuten kuvasta näkyy sivun ei tarvitse olla mitenkään erityisen tyylikäs.
Riittää että linkit olennaisiin asioihin löytyvät sivulta ja toimivat.

## Valmis pohja esittelysivulle

Yllä olevan sivun voi kopioida itselleen pohjaksi 
[täältä]({{rootdir}}src/{{curdir}}esittelysivu/esittelysivu.html).

Alla olevassa versiossa kaikki paitsi ensimmäiselle viikolle tulevat 
tiedot on kommentoitu HTML-kommenteilla tähän tyyliin: `<!-- kommentti -->`
Sivusta on myös olemassa 
[näköisversio, jossa kaikki tiedot ovat näkyvillä]({{rootdir}}src/{{curdir}}esittelysivu/esittelysivu-lopullinen.html).

~~~~html<include src="esittelysivu/esittelysivu.html" />~~~~

<alert>
Muista pitää esittelysivusi ajan tasalla. 
Sen päivittämättä jättämisestä voi menettää hyvinkin helposti pisteitä.
</alert>

<info>
Voit vaihtoehtoisesti tehdä esittelysivusi myös markdown-kielellä ja 
laittaa se github-repositoriosi readme-tiedostoksi nimellä `README.md`.
Esittelysivun tarkka toteutustapa ei ole olennainen, kunhan siinä olevat linkit toimivat.
</info>

[labtool]: http://tsoha-labtool.herokuapp.com/
