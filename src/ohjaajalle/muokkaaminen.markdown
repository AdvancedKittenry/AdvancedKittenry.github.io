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
Sivusto on kirjoitettu hieman laajennetulla markdown-syntaksilla.
Markdown-tiedostot sijaitsevat `src`-kansiossa, ja se pitää erikseen kääntää käyttäen
Pandoc-nimistä dokumenttigeneraattoria ja make-ohjelmaa.

Käytetyn Markdown-kielen perussyntaksia voi tiirailla 
[Pandoc-dokumenttigeneraattorin sivustolta](http://johnmacfarlane.net/pandoc/README.html).

### Työkalujen asentaminen

Tarvitset sivujen kääntämiseen
koneen, jolle on asennettuna Haskell-kielen kirjastot
ja käytettävissä ohjelmat ghc ja cabal. 
Lisäksi tarvitset järkevät versiot pythonista, perlistä ja make:sta.

Laitoksen koneilta nämä kaikki löytyvät vakiona, ja useimmille 
linux-distroille ne saa asennettua helposti.

Kun peruskirjatot ovat käytössä, pitää vielä asentaa dokumenttigeneraattori Pandoc.
Sinulla on tähän kaksi vaihtoehtoa:

* Voit asentaa Pandocin cabal-ohjelmalla, joka kääntää sen sinulle. Tähän menee n. vartti.
* Voit ladata kaksi valmiiksikäännettyä Pandoc-binääriä ja laittaa ne sopiviin hakemistoihin.

#### Cabal-asennus

Kun cabal on käytössäsi aja seuraavat komennot:

~~~
cabal update
cabal install pandoc
~~~

Seuraa n. puolikkaan vartin pituinen ohjelmien käännösputki.

#### Binääriasennus

Voit halutessasi myös kokeilla itse melkillä ja omalla koneella kääntämiäni
[binäärejä](http://www.cs.helsinki.fi/u/consuegr/pandoc/).
Säästät kääntämisen vaivan. 64-bittinen versio toimii esim. melkinpaadella eronomaisesti. 
(Melkki on jostain syystä kapinallinen. Viimeksi koettaessani make ei toiminut melkillä kovin hyvin.)
Joudut lisäksi lataamaan ja sijoittamaan repositoriosi `lib`-kansioon `generatedoc`-tiedoston, 
jotta skriptituki toimisi kunnolla, sillä muuten make yrittää kääntää sen puolestasi ja 
tämä ei toimi ilman Pandocin lähdekoodeja.

Lopuksi varmista, että Pandoc löytyy PATH-muuttujastasi. 
Sen voi tehdä esim. laittamalla .bashrc:hen seuraavan rivin: 

~~~
export PATH="$HOME/.cabal/bin:$PATH"
~~~

#### Lopputoimet

Pandocin asentamisen jälkeen 
sivujen pitäisi generoitua komentamalla `make`.
Tällöin make kääntää kaikki `src`-hakemiston alla olevat markdown-tiedostot automaattisesti.

Kannattaa varmistaa, että ohjelmat tuottavat suurinpiirtein samannäköistä jälkeä kuin 
mitä gitissä on ajamalla ensin kokeeksi:

~~~
make cleanpages
make
git diff
~~~

<info>
Jos sinulla on aikaisempi versio Pandocista, saattaa ohjelma
tuottaa hieman erilaista HTML:ää. Yleensä on hyvä idea päivittää
ohjelma. Tämä voi tosin olla joskus hyvin hankalaa, ja joskus 
vasta kotihakemistossa olevien kansioiden .ghc ja .cabal poistaminen 
kokonaan ja kaiken asentaminen uudestaan saa kaiken toimimaan.

Tekniikka on ihanaa.
</info>

### Kurssideadlinet ja muut tärkeät muuttujat

Sivuille on viritelty erinäisillä perl-skripteillä erinäisiä
lyhennemerkintöjä ja virityksiä, joista normaalin kurssiylläpidon
kannalta ehkä tärkein on kurssin deadlinejen asettaminen.
Kaikki kurssin kannalta olennaiset tiedonpalat on keskitetty yhteen
tiedostoon `course_instances.json`, josta ne voi muokata kerralla kuntoon.

JSON-tiedostossa esiteltyjä tietoja voi käyttää muodossa \{{deadline1}}.
Linkkejä varten on lisäksi olemassa muutamia tämänhetkistä kansiota
koskevia pikamerkintöjä:

Merkintä       Merkitys                           Arvo tässä tiedostossa
-------------- ---------------------------------- ----------------------
\{{curdir}}    Tämänhetkisen hakemiston nimi      {{curdir}}
\{{rootdir}}   Juurikansion polku                 {{rootdir}}
\{{imgdir}}    Kuvien hakemiston polku            {{imgdir}}
\{{myimgdir}}  Tämänhetkisen sivun kuvahakemisto  {{myimgdir}}

JSON-tiedostoon kohdistuvien
muokkausten jälkeen on usein parasta generoida koko sivusto uusiksi:

~~~
make cleanpages && make
~~~

Samoin kannattaa tehdä mikäli tulee siirtäneeksi jotain tiedostoa,
tai muokattua jotakin tiedostoa, jonka sisältöä käytetään muilta sivuilta käsin (etusivu ja kaksi sen alla olevaa aikataulusivua esim. riippuvat toisistaan). Myös uuden sivun lisäämiseen jälkeen uudelleenkääntäminen on hyvä idea,
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
ohjeissa olevat navigaatiolinkkilistat löytävät ne.
Tägäämisen voi tehdä seuraavasti:

~~~
<!-- tags: viikko1,viikko2-usefull -->
~~~

### Widgetit

Näiden merkintöjen lisäksi sivuilla on muutamia widgettejä, joita käytetään HTML:ää muistuttavilla tägeillä.
Näistä hyviä esimerkkejä löytyy 
[widgets-sivulta](widgets.html)
ja sen [lähdekoodista]({{rootdir}}src/{{curdir}}/widgets.markdown)

### Skriptaus

Markdown-koodin seassa on myös mahdollista ajaa erinäköisiä skriptejä
kirjoittamalla ne omaan erityiseen koodiblokkiinsa:

~~~~~~~~
~~~~ {execute=python}
print "Tittelituure"
~~~~
~~~~~~~~

Normaalisti skriptin tulostama koodi laitetaan sellaisenaan markdown-koodin sekaan. Se on myös mahdollista tulkita plaintextina 
tai koodiblokkina laittamalla aaltosulkujen sisään type-attribuutti.

~~~~~~~~
~~~~ {.html execute=bash type=block}
# Extract-tag.pl ottaa HTML-sivusta vain tietyn tägin sisällön. 
# Sitä käytetään HTML-koodiesimerkkien lyhentämiseen.
./extract-tag.pl body src/{{curdir}}html-esimerkit/tabit.html
~~~~
~~~~~~~~

## Arkkitehtuurista

Sivujen generoinnnista ja muusta magiasta
vastaava koodi on valitettavasti aika sekavaa ja koodattu turhan monella ohjelmointikielellä.

Pääasiallisesti dokumenttigeneraatiosta huolehtii shell-skripti `make-html.sh`,
joka ajaa unix-putkessa muutaman tägit toteuttavan skriptin, Pandocin päälle
rakennetun skriptituen (`lib/inlinescripting`), Pandocin, ja lopulta erinäköisiä pieniä korjauksia tekevän perl-skriptin `lib/fix-styles.pl`.

Ennen HTML:n generointia ajetaan navigaatiopuusta
huolehtiva `make-navigation.sh`, joka tekee erillisen 
navigaatiopohjatiedoston kaikille kansiorakenteen tasoille.
(Sivusto käyttää ainoastaan relatiivisia linkkejä ollakseen toimiva myös kovalevylle kloonattuna).

Navigaationgeneroinnista vastaa ennenkaikkea python-skripti
`make-indexes.py`, joka osaa luetella sivuston
sivut navigaatiotagien mukaisessa järjestyksessä.
Samaa skriptiä käytetään myös muutamalla sivulla erinäköisten
alinavigaatioiden tuottamiseen. 

Kts. esim. 
[ohjelmointiohjeistuksen pääsivun lähdekoodi]({{rootdir}}src/koodaaminen/index.markdown)
