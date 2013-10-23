* Malli vastaa tiedon käsittelemisestä ja abstrahoinnista ja **ainoastaan** siitä. Mallissa ei **ikinä käsitellä HTML:ää** tai käyttäjän lähettämiä pyyntöjä ja parametrejä, nämä ovat näkymän ja kontrollerin tehtäviä.
* Kaikki HTML-koodi sijoitetaan *näkymiin*
* Kaikki käyttäjän lähettämät GET- ja POST-paremetrit vastaanotetaan *kontrollerissa*.
* SQL-kyselyjä ei ikinä tehdä kontrollereiden tai näkymien puolella.
