% Näkymien tekeminen ja JSP
<!-- order: 2 -->
<!-- addHeaderNavigation -->

<summary>

* Laita servlettisi käyttämään HTML:n tulostukseen JSP-tiedostoa.
* Tee JSP-tägitiedosto, ja laita JSP-sivusi HTML-runko siihen. Ota tägitiedostosi käyttöön servlettisi JSP-tiedosssa.
* Tee sovelluksesi servleteille yläluokka, johon voi sijoittaa yleiskäyttöisiä toimintoja.

</summary>

Javassa näkyminä käytetään JSP-päätteisiä tiedostoja,
jotka koostuvat pääasiassa HTML-koodista, jonka seassa on 
nettijavaa varten toteutetulla 
[Unified Expression Language -kielellä](http://docs.oracle.com/javaee/5/tutorial/doc/bnahq.html) 
koodattuja käskyjä.

Yksinkertaisimmillaan JSP-tiedosto näyttää tältä:

~~~~jsp<include src="esimerkit/rakenne/index.jsp" />~~~~


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

~~~~java<include src="esimerkit/rakenne/RequestDispatcher.java" />~~~~

Viimeistään tässä vaiheessa joutunet lisäämään muutaman importin servlettiisi. 
Näissä esimerkeissä niitä ei tulla erikseen luettelemaan, mutta esim.
NetBeans osaa lisätä ne varsin kätevästi tiedoston alkuun, kunhan klikkailee sen antamia virhepalluroita.

## Muuttujien käyttö

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

## Listojen läpikäynti

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
</c:forEach>
~~~~

Yllä oleva komento `${kissa.nimi}` kutsuu käsiteltävän Kissa-olion
`getNimi`-metodia, ja tulostaa sen palauttaman arvon.

## Toisen tiedoston sisällön upottaminen koodiin

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

~~~~jsp<include src="esimerkit/rakenne/templated.jsp" />~~~~

Tägitiedosto sijoittaa annetut tiedot 
sen mukaan mitä tägitiedostossa käsketään.
Esimerkiksi kissalistan pohjatägitiedosto sijoittaa
tägin sisällön navigaatioelementin viereen käyttäen Bootstrap-kirjastoa:

**pohja.tag**

~~~~jsp<include src="esimerkit/rakenne/template.tag" />~~~~

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

## Linkkejä

* [Introduction to the Java Standard Tag Library](http://www.sitepoint.com/java-standard-tag-library/)

<next>
Seuraavaksi otamme käyttäjämallin, JSP-sivut ja servletit käyttöön
[yksinkertaisen kirjautumisen](lomakkeet.html) toteuttamiseen.
</next>