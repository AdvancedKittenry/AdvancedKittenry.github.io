% Aikataulu

Kurssi alkaa **pakollisella** aloitusluennolla {{aloitusluentopvm}}.

Alotusluennon kalvot löytyvät [googlen pilvestä](https://docs.google.com/presentation/d/1vKy0Kf6uFCz_2Gp0jTAyjCRrVl_yHBMg15IFzKRgr1k/pub?start=false&loop=false&delayms=3000), 
lisäksi kannattaa tutustua [web-sovelluksien erityispiirteisiin]({{rootdir}}web-sovelluksista.html).

Kurssi suoritetaan harjoitustyönä. Harjoitustyön ohjausta varten on osallistujien ilmoittauduttava ohjausryhmään. Ohjaus on kuitenkin henkilökohtaista, muodostuen pajatyyppisestä ohjauksesta. 
Paja-ajat sijoittuvat  ohjausryhmälle ilmoitettuun kokoontumisaikaan. Opiskelijoille yhteisiä tilaisuuksia ovat aloitustilaisuus {{aloitusluentopvm}} ja  lopussa oleva demo-tilaisuus, jossa opiskelijat esittelevät työnsä muille ohjausryhmän jäsenille. 

### Paja-ajat

{{paja-ajat-intro}}

~~~~ {execute=python}
ajat={{{paja-ajat-data}}}

print "|Aika|Huone|Ohjaaja|"
print "|----|-----|-------|"

for (aika,ohjaaja,huone) in ajat:
  print "|%s|%s|%s|" % (aika, huone, ohjaaja)

print "\n\n"

~~~~

### Palautukset

Tällä kurssilla on käytössä viikottaiset palautukset.
Jokainen ajoissa tehty palautus on kolmen pisteen arvoinen.
Myöhästynyt ei pisteitä saa ja yli kahdesta myöhästymisestä kurssin suorius keskeytyy.

Viikottaisten palautusten deadline on aina kunkin viikon perjantaina klo 23:00. Tämän jälkeen palautuksia ei enää oteta vastaan ilman hyvää syytä (eli lähinnä sairastapauksissa).
Palautukset suoritetaan ensimmäisellä viikolla ohjaajalle sähköpostitse
ja siitä eteenpäin [versionhallinnan]({{rootdir}}aikataulu/viikko1/git-ohje.html) kautta.

Viikkojen 3-5 materiaali on vielä työn alla. Sivut aukeavat sitä mukaa kun ohjeet valmistuvat.

### Deadlinet

| Tilaisuus              | Työaihe                                                                | Deadline |
|------------------------|------------------------------------------------------------------------|-----------------------|
| [Viikko I][viikko1]    | Aiheen ja toteutustekniikkojen valinta, alustava dokumentointi         | {{deadline1}}         |
| [Viikko II][viikko2]   | Sovelluksen suunnittelu, työympäristön pystytys                        | {{deadline2}}         |
| [Viikko III][viikko3]  | Koodauksen alku, sovellusarkkitehtuuri, lomakkeet ja kirjautuminen     | {{deadline3}}         |
| [Viikko IV][viikko4]   | Syvennytään tietokantaohjelmointiin                                    | {{deadline4}}         |
| [Viikko V][viikko5]    | Työn jatkamista, dokumentaatio valmiiksi                               | {{deadline5}}         |
| [Demotilaisuus][demo]  | Esitellään työtä ja sen koodia muille opiskelijoille                   | {{demodeadline}}      |
| [Palautus][palautus]   | Valmis työ palautetaan ohjaajalle                                      | {{palautusdeadline}}  |

<comment>
| [Viikko III][viikko3]  |                                                                        | {{deadline3}}         |
| [Viikko IV][viikko4]   |                                                                        | {{deadline4}}         |
| [Viikko V][viikko5]    |                                                                        | {{deadline5}}         |
</comment>

[viikko1]: {{rootdir}}aikataulu/viikko1/index.html
[viikko2]: {{rootdir}}aikataulu/viikko2/index.html
[viikko3]: {{rootdir}}aikataulu/viikko3/index.html
[viikko4]: {{rootdir}}aikataulu/viikko4/index.html
[viikko5]: {{rootdir}}aikataulu/viikko5/index.html
[demo]: {{rootdir}}aikataulu/demo.html
[palautus]: {{rootdir}}aikataulu/palautus.html
