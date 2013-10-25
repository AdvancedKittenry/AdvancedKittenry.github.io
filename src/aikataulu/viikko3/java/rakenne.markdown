% Sovelluksen rakenne ja servletit
<!-- order: 1 -->
<!-- addHeaderNavigation -->

<summary>

* Tee koodia varten oma pakettisi. Esim. `Kissalista`.
* Luo ensin itsellesi servlet-luokka.
    * Sijoita servlet-luokkasi omaan pakettiinsa. Esim. `Kissalista.Servlets`. Jatkossa samaan pakettiin tulevat kaikki muutkin servletit.
* Laita sitten servlettisi käyttämään HTML:n tulostukseen JSP-tiedostoa.
* Tee JSP-tägitiedosto, ja laita JSP-sivusi HTML-runko siihen. Ota tägitiedostosi käyttöön servlettisi JSP-tiedosssa.
* Tee sovelluksesi servleteille yläluokka, johon voi sijoittaa yleiskäyttöisiä toimintoja.
* Tee käyttäjien käsittelyä varten alustava malliluokka.
    * Sijoita kaikki mallit omaan pakettiinsa. Esim. `Kissalista.Models`.

Projektissa pitäisi tällöin olla seuraavanlainen kansiorakenne:

~~~~<include src="kansiorakenne.txt" />~~~~

</summary>

Tietokantasovellukset Javalla kannattaa jakaa 
[arkkitehtuuriohjeen]({{rootdir}}mvc-opas.html) mukaisesti
malleihin, kontrollereihin ja näkymiin.
Keskitymme ensiksi kontrollereihin ja näkymiin.

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

### Etusivut

Voit myös halutessasi tehdä servletistä sivujesi etusivun
lisäämällä tiedostoon `web/WEB-INF/web.xml` seuraavanlaista koodia

~~~xml
<welcome-file-list>
  <welcome-file>kirjautuminen</welcome-file>
</welcome-file-list>
~~~

### Servletin toiminta

Servletin toiminnan ytimessä ovat `doGet`- ja `doPost`-metodit,
jotka ottavat vastaan servletin osoitteeeseen
[GET- ja POST-metodeilla]({{rootdir}}web-sovelluksista.html#get-ja-post)
tehtyjä aineistopyyntöjä. 
NetBeansin vakiopohja Servlet-luokille luo nämä metodit automaattisesti
ja laittaa ne molemmat kutsumaan samaa `processRequest`-metodia.
Metodilla on parametreina HttpServletRequest-olio, joka sisältää pyynnön tiedot, ja HttpServletResponse-olio, johon voidaan lisätä vastaus.

**Esimerkki Netbeansillä tuotetusta Servlet-luokasta. Älä käytä tätä koodia suoraan!**

~~~~java<include src="esimerkit/TestiServlet.java" />~~~~

Valmiin pohjan sisältämä vastauksen tuottava koodi sisältää 
suoraan kontrolleriin upotettua HTML-koodia. 
Tälläistä koodia ei kannata käyttää, vaan kannattaa tuottaa
HTML-sivut erillisillä näkymätiedostoilla.

## Näkymät ja JSP

Javassa näkyminä käytetään JSP-päätteisiä tiedostoja,
jotka koostuvat pääasiassa HTML-koodista, jonka seassa on 
nettijavaa varten toteutetulla 
[Unified Expression Language -kielellä](http://docs.oracle.com/javaee/5/tutorial/doc/bnahq.html) 
koodattuja käskyjä.

Yksinkertaisimmillaan JSP-tiedosto näyttää tältä:

~~~~jsp<include src="esimerkit/index.jsp" />~~~~


JSP-tiedoston käyttäminen tapahtuu RequestDispatcher-tyyppisen 
olion metodilla forward, 
jolle annetaan parametrina HttpServletRequest ja HttpServletResponse-oliot. 
RequestDispatcher-olion saa HttpServletRequest-oliolta antamalla sille sivun, jolle pyyntö ohjataan.

Luo tässä vaiheessa projektisi luokille oma paketti.
Esim. kissalistan paketti voisi olla `Kissalista`.
Tee pakettiisi alipaketit servlettejä ja malleja varten. 
Esimerkiksi `Kissalista.Servlets` ja `Kissalista.Models`.

Luo sitten itsellesi JSP-tiedosto ja servlet-luokka ja 
laita servletin pyynnön käsittelymetodiin
RequestDispatcher-oliota käyttävää koodia, joka ohjaa luomaasi JSP-tiedostoon
ja kutsuu metodia forward.

~~~~java<include src="esimerkit/RequestDispatcher.java" />~~~~

Viimeistään tässä vaiheessa joutunet lisäämään muutaman importin servlettiisi. 
Näissä esimerkeissä niitä ei tulla erikseen luettelemaan, mutta esim.
NetBeans osaa lisätä ne varsin kätevästi tiedoston alkuun, kunhan klikkailee sen antamia virhepalluroita.

### Muuttujien käyttö

JSP-koodiin on mahdollista sijoittaa muuttujia ja mm. ehtolausekkeita.
esimerkiksi virheviestin näyttämisen voi toteuttaa seuraavasti:

Asetetaan `processRequest`-metodissa aineistopyyntöä mallintavalle `HttpServletRequest`-oliolle _attribuutti_, joka sisältää viestin.

~~~~java
protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
  response.setContentType("text/html;charset=UTF-8");
  
  /* Asetetaan virheviesti */
  request.setAttribute("virheViesti", "Sinulla ei ole ainuttakaan kissaa!");  

  /* Näytetään JSP-sivu sivux.jsp */
  RequestDispatcher dispatcher = request.getRequestDispatcher("sivux.jsp");
  dispatcher.forward(request, response);
}
~~~~

JSP-sivulla on mahdollista näyttää pyyntöön asetettuja
attribuutteja suoraan syntaksilla `${attribuutin_nimi}`.
Myös erilaisia koodirakenteita kuten ehtolausekkeita
voi käyttää ottamalla käyttöön _JSTL-tägikirjaston_
laittamalla tiedoston alkuun taglib-referenssin:

~~~~jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
~~~~

Saatat joutua lisäämään projektiisi JSTL-kirjaston, että viite toimisi.
Tämä tapahtuu NetBeansissä avaamalla valikosta projektin ominaisuusikkuna kohdasta `File->Project Properties`.
Paina _Libraries_-kategoriassa nappia _Add Library_ ja lisää listasta projektiin kirjasto nimeltä `JSTL 1.1`.

![JSTL 1.1 -kirjaston lisääminen projektiin]({{myimgdir}}jstl.png)

Tämän jälkeen voimme näyttää virheviestin ehtolausekkeen avulla:

~~~~jsp
<c:if test="${virheViesti != null}">
  <div class="alert alert-danger">Virhe! ${virheViesti}</div>
</c:if>
~~~~

Yllä oleva koodi näyttää virheviestin ja siihen liittyvän div-elementin
vain jos attribuutti `virheViesti` on asetettu. 

### Listojen läpikäynti

Attribuutteihin voidaan laittaa käytännössä mitä tahansa olioita:

~~~~java
/* Oletetaan että Kissa on luokka, joka tallettaa nimettyjä kissoja.
 * Jokaisella kissalla on konstruktori, joka ottaa parametrina kissan nimen.
 * Nimen saa kissasta ulos getNimi()-metodilla
 */
List<Kissa> katit = new ArrayList<Kissa>();
katit.add(new Kissa("Ville"));
katit.add(new Kissa("Minttu"));

request.setAttribute("kissat", katit);  
~~~~

Yllä olevan kissalistan voi näyttää seuraavanlaisella silmukalla:

~~~~jsp
<c:forEach var="kissa" items="${kissat}">
  <div class="kissa">{kissa.nimi}</div>
</c:if>
~~~~

Yllä oleva komento `${kissa.nimi}` kutsuu käsiteltävän Kissa-olion
`getNimi`-metodia, ja tulostaa sen palauttaman arvon.

### Toisen tiedoston sisällön upottaminen koodiin

Myös muita tiedostoja on mahdollista sisällyttää
yhteen JSP-tiedostoon. 
Nämä sisällytettävät tiedostot käyttävät yleensä
tiedostopäätettä JSPF, eli JSP Fragment.

~~~jsp
<%@include file="navigaatio.jspf" %>
~~~

Sisällytetyn tiedoston sisältö tulee include-lauseen kohtaan
sellaisenaan ikäänkuin tiedosto olisi copy-pastettu siihen suoraan.

## Template-pohjatiedoston käyttö

Käytännössä suurin osa ohjelmaasi tulevista sivuista
tulee sisältämään samanlaisen HTML-rungon,
johon sisältyvät sivunavigaatio sekä 
head-tägin sisältämät otsakkeet ja tyylitiedostolinkit.

Tämän rungon koodia ei turhaan kannata toistaa, 
vaan se kannattaa sijoittaa omaan uudelleenkäytettävään tiedostoonsa.
Javalla tälläiset uudelleenkäytettävät HTML-pätkät
kannattaa toteuttaa erityisinä JSP-tägitiedostoina.

Tagitiedoston sisälle voi laittaa mitä tahansa HTML-koodia
aivan kuten JSP-tiedostoonkin. 
Tärkein kohta koodissa on kuitenkin käsky `<jsp:doBody/>`,
jolla voi upottaa tägiin jotain tägin käyttäjän määrittelemää sisältöä.

Myös omia tägispesifisiä muuttujia voi määritellä.
Rivi `<%@attribute name="pageTitle"%>` määrittelee muuttujan
pageTitle, jota voi käyttää normaaliin tapaan tagin koodissa
kirjoittamalla `${pageTitle}`. 

Muuttujan sisällön määrittää tägin käyttäjä.
Alla olevassa esimerkissä tiedostossa `web/WEB-INF/tags/pohja.tag`
määritellylle tägille 
annetaan muuttuja `pageTitle` 
ja sisältönä yksi h1-elementti.

**helloworld.jsp**

~~~~jsp<include src="esimerkit/templated.jsp" />~~~~

Tägitiedosto sijoittaa annetut tiedot 
sen mukaan mitä tägitiedostossa käsketään.
Esimerkiksi kissalistan pohjatägitiedosto sijoittaa
tägin sisällön navigaatioelementin viereen käyttäen Bootstrap-kirjastoa:

**pohja.tag**

~~~~jsp<include src="esimerkit/template.tag" />~~~~

Kun yllä oleva JSP-koodi ja tägitiedosto ajetaan syntyy sivu, jonka
otsikko on "Kissalista!" ja 
jonka sisältönä on sivunavigaatio ja Hello World -toivotus.

----------

Tee nyt projektillesi HTML-pohjatiedosto kansioon `web/WEB-INF/tags/pohja.tag`. Ja sijoita siihen oma sivupohjasi.

NetBeansistä löydät tägitiedoston uusien tiedostojen valikosta 
`Web`-kohdan alta nimellä `Tag File`. Voit käyttää seuraavia asetuksia:

![Tagitiedoston luonti]({{myimgdir}}tagi.png)

## Koodin sijoittamineen uudelleenkäytettävään luokkaan

Siinä vaiheessa kun servlet-luokkia alkaa tulla projektiin
useampia alkavat tietyt toiminnot toistua luokasta toiseen.
Hyvänä esimerkkinä JSP-sivun näyttämiseen tarvittu koodinpätkä,
virheilmoitusten lähettäminen näkymälle näkyviin, ja kirjautumisen tarkistaminen.

Tee itsellesi uusi luokka, ja lähde rakentamaan siihen yleisiä toiminnallisuuksia omina metodeinaan.
Laita siihen ensimmäiseksi metodi, jolla saat näytettyä JSP-sivun. 
Kehittele myös tapa näyttää sivupohjassasi sovelluksen virheitä
ja tee metodi joka aktivoi tuon tavan. 
Useimmiten tähän kannattaa käyttää `setAttribute`-metodia ja jotain sovittua attribuuttia, jonka arvo näytetään virheviestinä.

Voit halutessasi myös laittaa uuden luokkasi perimään HttpServletin ja periyttää kaikki muut servlettisi siitä.
Näin luokkasi metodit ovat kaikissa projektisi servlet-luokissa suoraan käytettävissä.

## Mallien luominen

Sijoita projektin mallit omaan pakettiinsa samaan tapaan kuin servletit.
Tämän viikon töihin tarvitset käytännössä vain yhden malliluokan,
joka kuvaa käyttäjää. 
Sijoita malliisi kentät käyttäjäsi tietokantataulun kenttiä varten
ja luo kentille getterit ja setterit sekä halutessasi konstruktori, joka ottaa kenttien arvot vastaan.

Myöhemmin työn edetessä teemme tähän luokkaan staattisia metodeja, 
jotka osaavat hakea näihin olioihin sisältöä tietokannasta.

# Linkkejä

* [Introduction to the Java Standard Tag Library](http://www.sitepoint.com/java-standard-tag-library/)

<next>
Seuraavaksi otamme käyttäjämallin ja servletit käyttöön
[yksinkertaisen kirjautumisen](lomakkeet.html) toteuttamiseen.
</next>

