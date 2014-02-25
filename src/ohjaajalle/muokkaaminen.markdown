% Kurssisivujen muokkaaminen
<!-- hidden! -->

Nämä kurssisivut sijaitsevat githubin palvelimella 
ns. [organisaation github-tilillä](https://github.com/AdvancedKittenry/).
Samalla tilillä on myös kurssin labtoolin lähdekoodi, sekä muutaman
testiohjelman repositoriot.

## Githubin ryhmään pääseminen

Jos haluat muokata sivuja voit pyytää  pääsyä github-organisaation jäseneksi.
Parhaiten asia hoitunee kysymällä kurssin entisiltä/muilta assareilta tai sivujen alkuperäistekijältä David Consuegralta.
Davidin yhteystiedot ovat:

Email: davicon@gmail.com \
IRC: Purrrrr@IRCNet

Muita kurssin assareita saa kiinni heidän sähköposteistaan tai 
irc-kanavalta `#tsohaaa` IRCNetissä.

## Itse sivujen muokkaaminen

Itse sivujen muokkaamiseksi on parasta kloonata
repositorio omalle koneelleen. 
Sivusto on kirjoitettu hieman laajennetulla markdown-syntaksilla
`src`-kansiossa, ja se pitää erikseen kääntää käyttäen
pandoc-nimistä dokumenttigeneraattoria ja make-ohjelmaa.

Tarvitset sivujen kääntämiseen
koneen, jolle on asennettuna Haskell-kielen kirjastot
ja käytettävissä ohjelmat ghc ja cabal. 
Lisäksi tarvitset järkevät versiot pythonista, perlistä ja make:sta.

Laitoksen koneilta cabal löytyykin vakiona, ja useimmille 
linux-distroille sen saa asennettua helposti.
Kun cabal on käytössäsi aja seuraavat komennot:

~~~
cabal update
cabal install pandoc
~~~

Seuraa hämmentävän pitkä ohjelmien käännösputki, jonka jälkeen 
sivujen pitäisi generoitua komentamalla `make`.

<info>
Jos sinulla on aikaisempi versio pandocista, saattaa ohjelma
tuottaa hieman erilaista HTML:ää. Yleensä on hyvä idea päivittää
ohjelma. Tämä voi tosin olla joskus hyvin hankalaa, ja joskus 
vasta kotihakemistossa olevien kansioiden .ghc ja .cabal poistaminen 
kokonaan ja kaiken asentaminen uudestaan saa kaiken toimimaan.

Tekniikka on ihanaa.
</info>

### Teknisiä yksityiskohtia

Itse sivujen lähdekoodit sijaitsevat kansiossa `src`. Makefile
kääntää kaikki kansioissa sijaitsevat markdown-tiedostot automaattisesti.

Sivuille on viritelty erinäisillä perl-skripteillä erinäisiä
lyhennemerkintöjä ja virityksiä, joista normaalin kurssiylläpidon
kannalta ehkä tärkein on kurssin deadlinejen asettaminen.
Kaikki kurssin kannalta olennaiset tiedonpalat on keskitetty yhteen
tiedostoon `course_instances.json`, josta ne voi muokata kerralla kuntoon.

JSON-tiedostossa esiteltyjä tietoja voi käyttää muodossa \{{deadline1}}.
Linkkejä varten on lisäksi olemassa muutamia tämänhetkistä kansiota
koskevia pikamerkintöjä:

\{{curdir}}
\{<!-- -->{rootdir}}
\{{imgdir}}
\{{myimgdir}}

Muokkausten jälkeen on usein parasta generoida koko sivusto uusiksi:

~~~
make cleanpages && make
~~~

Samoin kannattaa tehdä mikäli tulee siirtäneeksi jotain tiedostoa,
tai muokattua jotakin tiedostoa, jonka sisältöä käytetään muilta sivuilta käsin (etusivu ja kaksi sen alla olevaa aikataulusivua esim. riippuvat toisistaan). Myös uuden sivun lisäämiseen uudelleenkääntäminen on hyvä idea,
sillä make ei aina havaitse kunnolla kaikkea, ja sivu saattaa
jäädä pois autogeneroidussta navigaatiosta.

### Navigaation hallinta

Sivuston navigaatio autogeneroidaan käyttäen
hyväksi markdown-tiedostojen ensimmäisellä rivillä
olevia prosenttimerkillä alkavia otsikkorivejä.

Sivuja voi lisäksi järjetää antamalle niille erilaisia
järjestyspainoarvoja laittamalla
tiedoston ensimmäisille riveille sopiva kommentti:

~~~
<!-- order: 5 -->
~~~

Jos jonkin sivun haluaa piilottaa navigaatiosta, riittää laittaa sen alkuun:

~~~
<!-- hidden! -->
~~~

### Tägit

Osa sivuista on tägätty siten, että viikottaisissa
ohjeissa olevat navigaatilinkkilistat löytävät ne.
Tägäämien voi tehdä seuraavasti:

~~~
<!-- tags: viikko1,viikko2-usefull -->
~~~

### Widgetit

* widgetit
