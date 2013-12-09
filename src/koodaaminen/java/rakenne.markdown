% Sovelluksen rakenne ja servletit
<!-- order: 1 -->
<!-- addHeaderNavigation -->

<summary>

* Tee koodia varten oma pakettisi. Esim. `Kissalista`.
* Sijoita kaikki mallit omaan pakettiinsa. Esim. `Kissalista.Models`.
* Sijoita servlet-luokkasi omaan pakettiinsa. Esim. `Kissalista.Servlets`. Jatkossa samaan pakettiin tulevat kaikki muutkin servletit.

Lopullisen projektin pitäisi noudatella tämäntapaista kansiorakennetta

~~~~<include src="esimerkit/rakenne/kansiorakenne.txt" />~~~~

</summary>

Tietokantasovellukset Javalla kannattaa jakaa 
[arkkitehtuuriohjeen]({{rootdir}}koodaaminen/arkkitehtuuri/index.html) mukaisesti
malleihin, kontrollereihin ja näkymiin.
Keskitymme ensiksi malleihin ja kontrollereihin ja jatkamme sitten näkymiin [seuraavalla sivulla](nakymat.html).

## Mallit

Sijoita projektin mallit omaan pakettiinsa samaan tapaan kuin servletit.
Kolmannen viikon töihin tarvitset käytännössä vain yhden malliluokan,
joka kuvaa käyttäjää. Jos teit toisella viikolla
listauksesi käyttäjälistauksena, sinulla on jo sellainen valmiina.

Sijoita malliisi kentät tietokantataulun kenttiä varten
ja luo kentille getterit ja setterit sekä halutessasi konstruktori, joka ottaa kenttien arvot vastaan.

Työn edetessä teemme luokkiin metodeja, 
jotka osaavat hakea olioihin sisältöä tietokannasta,
sekä metodit, joilla tietoa päivitetään takaisin kantaan.

## Servletit

Servletit ovat Java EE:ssä eli Javan nettipuolessa 
käytettäviä luokkia, jotka edustavat jonkin nettisivun tai toiminnon
_kontrollereita_. 
Servletit ja kontrollerit ovat Javan näkökulmasta useimmiten käytännössä sama asia. 

Jokainen Servlet-luokka on sidottu johonkin URL-osoitteeseen,
johon ohjattu aineistopyyntö aktivoi sen.
Sitomiset on käyttämässämme Java-ympäristön versiossa
määritelty XML-pohjaisesti tiedostossa `web/WEB-INF/web.xml`.
Tiedoston muokkaus on hieman monimutkaista, mutta esimerkiksi
NetBeans osaa muokata tämän tiedoston määrityksiä
kätevällä käyttöliittymällä ja liittää esimerkiksi uusien Servlettien 
URL-osoitteet sinne samalla kun Servlettiä luodaan, 
jolloin käytännössä tiedostoon tarvitsee koskea käsin aika harvoin.

### Sovelluksen etusivun määrittely

Voit myös halutessasi tehdä servletistä sivujesi etusivun
lisäämällä tiedostoon `web/WEB-INF/web.xml` seuraavanlaista koodia

~~~xml
<welcome-file-list>
  <welcome-file>kirjautuminen</welcome-file>
</welcome-file-list>
~~~

Oletuksena Tomcat-sovellus käyttää etusivunaan index.jsp-tiedostoa.

### Servletin toiminta

Servletin toiminnan ytimessä ovat `doGet`- ja `doPost`-metodit,
jotka ottavat vastaan servletin osoitteeeseen
[GET- ja POST-metodeilla]({{rootdir}}web-sovelluksista.html#get-ja-post)
tehtyjä aineistopyyntöjä. 
NetBeansin vakiopohja Servlet-luokille luo nämä metodit automaattisesti
ja laittaa ne molemmat kutsumaan samaa `processRequest`-metodia.
Metodilla on parametreina HttpServletRequest-olio, joka sisältää pyynnön tiedot, ja HttpServletResponse-olio, johon voidaan lisätä vastaus.

**Esimerkki Netbeansillä tuotetusta Servlet-luokasta. Älä käytä tätä koodia suoraan!**

~~~~java<include src="esimerkit/rakenne/TestiServlet.java" />~~~~

Valmiin pohjan sisältämä vastauksen tuottava koodi sisältää 
suoraan kontrolleriin upotettua HTML-koodia. 
Tälläistä koodia ei kannata käyttää, vaan kannattaa tuottaa
HTML-sivut erillisillä näkymätiedostoilla.

Näistä kerrotaan enemmän seuraavalla sivuilla.

<next>
Seuraavaksi tutustumme tarkemmin 
[näkymien toteuttamiseen](nakymat.html).
</next>
