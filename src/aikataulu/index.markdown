% Aikataulu
<!-- order: 1 -->

Kurssi alkaa **pakollisella** aloitusluennolla {{aloitusluentopvm}}.

Alotusluennon kalvot löytyvät [googlen pilvestä](https://docs.google.com/presentation/d/1InGSgij8dJ5CxYH2U8M1TAzxP8CdSf0HOU0L_bwG0Bg/edit#slide=id.p), 
lisäksi kannattaa tutustua [web-sovelluksien erityispiirteisiin]({{rootdir}}web-sovelluksista.html).

Aloitusluennon jälkeen kannattaa tutustua 
[kurssin viikkoaikatauluun]({{rootdir}}aikataulu/viikkopalautukset/index.html) ja selvittää mitä ensimmäisellä viikolla tehdään.

Kurssi suoritetaan harjoitustyönä. Harjoitustyön ohjausta varten on
osallistujien ilmoittauduttava ohjausryhmään. Tarkalla
ryhmällä ei ole niin väliä, sillä ohjaus on pajamuotoista
ja kaikissa pajoissa saa käydä kysymässä neuvoa.

Opiskelijoille
yhteisiä tilaisuuksia ovat aloitustilaisuus {{aloitusluentopvm}} ja
lopussa oleva pakollinen demo-tilaisuus, jossa opiskelijat esittelevät työnsä muille
ohjausryhmän jäsenille. 
Kurssiin kuuluu lisäksi erillinen vapaaehtoinen [koodikatselmointi]({{rootdir}}aikataulu/koodikatselmointi.html).

### Paja-ajat

{{paja-ajat-intro}}

~~~~ {execute=python}
# -*- coding: utf8 -*-
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
