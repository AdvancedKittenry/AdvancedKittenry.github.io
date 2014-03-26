% Git-repositoriot ja salasanat
<!-- order: 3.1 -->
<!-- tags: viikko2 -->

Yksityiseksi tarkoitettujen salasanojen tallentaminen
versionhallintaan ei ole ikinä kovin hyvä idea.
Salasanoja sisältäviä tiedostoja ei useimmiten kuitenkaan
kannata jättää versionhallinnasta poiskaan, sillä useimmiten niihin sisältyy 
muutakin oleellista informaatiota projektista.

Yksinkertainen ja hyvin yleisesti käytetty tapa hoitaa ongelma, on 
luoda tarvittava salasanan sisältävä tiedosto kahdesti:
ensiksi normaalina tiedostona, jossa on salasana, mutta jota ei laiteta versionhallintaan
ja sitten salasanattomana .dist-tiedostopäätteellisenä versiona, joka laitetaan versionhallintaan.

Esimerkiksi Javalla koodatessa tiedostoon `web/META-INF/context.xml` 
joutuu useimmiten sijoittamaan tietokannan salasanan.
Laittamalla `.gitignore`-tiedostoon rivi 
`web/META-INF/context.xml` voit pyytää git:iä 
olemaan lisäämättä tätä tiedostoa
versionhallintaan.

Jotta versionhallintaa tarkasteleville jäisi kuitenkin
jotain käsitystä puuttuvan tiedoston sisällöstä
tehdään tiedostosta dist-tiedostopäätteellä varustettu
kopio, `web/META-INF/context.xml.dist`,
joka on muuten samanlainen kuin alkuperäinen `context.xml`, mutta ei sisällä salasanaa.
Tätä kopiota ei tietenkään mainita `.gitignore`-tiedostossa. 

Näin repositorion kloonannut pystyy itse kopioimaan tiedoston paikalleen ja 
laittamaan siihen tarvittavan salasanan käsin.

<alert>
Kun käytät `.dist`-päätteisiä tiedostoja, laita dokumentaation asennusohjeisiin maininta niiden sijainnista
ja siitä mitä niihin pitää sijoittaa ohjelman käyttämiseksi.
</alert>
