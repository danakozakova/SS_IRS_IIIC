# IRS — Testík: SELECT a filtrovanie (tabuľka `filmy`)

[LINK](https://forms.cloud.microsoft/e/tkEvvQzCe9)

Meno: ______________________  Trieda: ________  Body: ____ / 10

**Ako na to:** otvor **sqliteonline.com** (engine SQLite), vlož a spusti príkaz nižšie
(vytvorí tabuľku `filmy`), a potom k úlohám **napíš SQL príkaz** (a over si ho spustením).
Žánre píš bez diakritiky, presne ako v tabuľke.

```sql
DROP TABLE IF EXISTS filmy;
CREATE TABLE filmy (id INTEGER PRIMARY KEY, nazov TEXT, reziser TEXT, zaner TEXT,
  rok INTEGER, dlzka_min INTEGER, hodnotenie REAL);
INSERT INTO filmy VALUES
 (1,'Interstellar','Christopher Nolan','Sci-fi',2014,169,8.7),
 (2,'Inception','Christopher Nolan','Sci-fi',2010,148,8.8),
 (3,'Titanic','James Cameron','Drama',1997,195,7.9),
 (4,'Avatar','James Cameron','Sci-fi',2009,162,7.9),
 (5,'Joker','Todd Phillips','Drama',2019,122,8.4),
 (6,'Parasite','Bong Joon-ho','Drama',2019,132,8.5),
 (7,'The Dark Knight','Christopher Nolan','Akcia',2008,152,9.0),
 (8,'Frozen','Chris Buck','Animovany',2013,102,7.4),
 (9,'Coco','Lee Unkrich','Animovany',2017,105,8.4),
 (10,'Dune','Denis Villeneuve','Sci-fi',2021,155,8.0),
 (11,'Gladiator','Ridley Scott','Akcia',2000,155,8.5),
 (12,'Up','Pete Docter','Animovany',2009,96,8.3);
```

---

**1.** Vypíš celú tabuľku `filmy`. *(1 b)*

`_______________________________________________________`

**2.** Vypíš len **názov a rok** všetkých filmov. *(1 b)*

`_______________________________________________________`

**3.** Vypíš filmy žánru **Sci-fi**. *(1 b)*

`_______________________________________________________`

**4.** Vypíš filmy dlhšie ako **150 minút**. *(1 b)*

`_______________________________________________________`

**5.** Vypíš filmy z rokov **2009 až 2019** (vrátane). *(1 b)*

`_______________________________________________________`

**6.** Vypíš filmy žánru **Drama alebo Akcia**. *(1 b)*

`_______________________________________________________`

**7.** Vypíš filmy, ktorých názov **začína na písmeno A**. *(1 b)*

`_______________________________________________________`

**8.** Vypíš filmy s hodnotením **nad 8.5**, zoradené **od najlepšie hodnoteného**. *(2 b)*

`_______________________________________________________`

**9. (teória)** Napíš **doménu** stĺpca `hodnotenie` a jednu hodnotu, ktorá do nej **nepatrí**. *(1 b)*

`_______________________________________________________`
