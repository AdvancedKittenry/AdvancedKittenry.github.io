% Aikataulu
<!-- order: 1 -->

Kurssi alkaa **pakollisella** aloitusluennolla {{aloitusluentopvm}}.

Alotusluennon kalvot löytyvät [googlen pilvestä](https://docs.google.com/presentation/d/1vKy0Kf6uFCz_2Gp0jTAyjCRrVl_yHBMg15IFzKRgr1k/pub?start=false&loop=false&delayms=3000), 
lisäksi kannattaa tutustua [web-sovelluksien erityispiirteisiin]({{rootdir}}web-sovelluksista.html).

Kurssi suoritetaan harjoitustyönä. Harjoitustyön ohjausta varten on osallistujien ilmoittauduttava ohjausryhmään. Ohjaus on kuitenkin henkilökohtaista, muodostuen pajatyyppisestä ohjauksesta. 
Paja-ajat sijoittuvat  ohjausryhmälle ilmoitettuun kokoontumisaikaan. Opiskelijoille yhteisiä tilaisuuksia ovat aloitustilaisuus {{aloitusluentopvm}} ja  lopussa oleva demo-tilaisuus, jossa opiskelijat esittelevät työnsä muille ohjausryhmän jäsenille. 

### Paja-ajat

{{paja-ajat-intro}}

~~~~ {execute=python}
ajat={{{paja-ajat-data}}}

if (len(ajat) == 0):
  exit()

print "|Aika|Huone|Ohjaaja|"
print "|----|-----|-------|"

for (aika,ohjaaja,huone) in ajat:
  print "|%s|%s|%s|" % (aika, huone, ohjaaja)

print "\n\n"

~~~~

### Palautukset

<include src="viikkopalautukset/index.markdown" />
