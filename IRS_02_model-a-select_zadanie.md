# IRS — Pojmy databázy, doména a precvičenie SELECT

Meno: ______________________  Trieda: ________

Minule sme sa databázy **pýtali** (SELECT). Dnes spoznáme pojmy, ktorými odborne opíšeme tabuľku,
zameriame sa na **doménu** (čo do stĺpca smie a čo nie — a kde vznikajú chyby), a potom si
**precvičíme dopyty**. Ostávame pri tabuľke `hry` — pribudol jej stĺpec `aktualizovane`.

---

# ČASŤ 1 — Teória

## Ukážka tabuľky `hry`

| id | nazov            | zaner   | rok  | hodnotenie | cena  | aktualizovane      |
|----|------------------|---------|------|-----------|-------|--------------------|
| 1  | The Witcher 3    | RPG     | 2015 | 9.3       | 29.99 | 2026-07-15 09:20   |
| 2  | Minecraft        | Sandbox | 2011 | 9.0       | 23.95 | 2026-09-01 12:00   |
| 3  | Counter-Strike 2 | FPS     | 2023 | 8.1       | 0.00  | 2026-09-10 18:45   |
| 8  | Portal 2         | Logicka | 2011 | 9.4       | 9.99  | 2026-01-20 11:00   |
| 11 | Elden Ring       | RPG     | 2022 | 9.6       | 59.99 | 2026-08-28 07:40   |
| 10 | Among Us         | Party   | 2018 | 8.0       | 3.99  | 2026-09-12 13:05   |

**Entita** = „vec", o ktorej si vedieme údaje → tu **hra**.
**Atribút** = vlastnosť = **stĺpec** (`nazov`, `zaner`, `rok`, `hodnotenie`, `cena`, `aktualizovane`, `id`).
**Záznam = N-tica** = jeden riadok, napr. `(1, The Witcher 3, RPG, 2015, 9.3, 29.99, 2026-07-15 09:20)`.

## Doména — čo do stĺpca smie

**Doména** = množina **povolených hodnôt** pre atribút. Nie je to len „typ": hovorí, ktoré hodnoty
dávajú **zmysel**. Pozor — dátový typ býva **širší** než doména: typ `číslo` dovolí aj `-5`, hoci do
domény ceny `-5` nepatrí. Preto sa doména v praxi stráži **obmedzeniami** (o tých neskôr).

Príklady domén v tabuľke `hry`:
- `rok` → celé čísla, rozumne 1958–tento rok
- `cena` → **nezáporné** desatinné čísla (0 a viac)
- `hodnotenie` → čísla v rozsahu **0–10**
- `zaner` → **konečná množina** žánrov {RPG, FPS, Akcia, Sandbox, …}
- `aktualizovane` → platný **dátum a čas**

### Kde vznikajú typické chyby (dôležité!)

**1) Záporné čísla a rozsah.** `cena = -5` alebo `hodnotenie = 12` sú síce „čísla", ale mimo domény.
Databáza ich bez obmedzenia pokojne uloží — a máš v dátach nezmysel.

**2) Desatinné čísla a zaokrúhľovanie (peniaze!).** Typ „desatinné číslo" (REAL/FLOAT) ukladá hodnoty
**nepresne** — napr. `0.1 + 0.2` nevyjde presne `0.3`. Pri peniazoch to spôsobí zaokrúhľovacie chyby.
Preto sa ceny v praxi ukladajú ako **presný typ (DECIMAL)** alebo **v centoch ako celé číslo**.

**3) Konečná množina a preklepy.** Ak do `zaner` niekto napíše `'RGP'` (preklep), typ TEXT to prijme,
ale hodnota do domény **nepatrí**. Riešenie: povolené hodnoty držať v samostatnom zozname (číselníku).

**4) Dátumy a časy.**
- **Formát:** `03/04/2026` — je to 3. apríl alebo 4. marec? Nejednoznačné! Databázy používajú
  **ISO 8601: `RRRR-MM-DD`** (napr. `2026-04-03`), ktoré je jednoznačné a správne sa **zoraďuje**.
- **Platnosť:** `2026-02-30` neexistuje; 31. apríl neexistuje; `29. február` je len v priestupných rokoch.
- Čas: `HH:MM:SS` (24-hodinový).

**5) Časové pásmo a letný čas.** Ten istý **okamih** má v rôznych pásmach iný „lokálny čas".
Keď server zapíše `12:00 UTC`, u nás je vtedy 13:00 (zima) alebo 14:00 (leto). Preto sa čas často
ukladá v **UTC** a používateľovi sa zobrazí v jeho pásme.

## Dáta vs. informácia
*Dáta* = surové hodnoty (`29.99`). *Informácia* = zmysluplný výsledok z dát („najlacnejšia hra je
Counter-Strike 2"). Reťazec: **dáta → dopyt → informácia.**

---

## Úlohy k teórii

**T1.** Ukáž v tabuľke: (a) entitu, (b) tri atribúty, (c) jeden záznam (N-ticu).

**T2. (doména – rozsah a znamienko)** Ktoré hodnoty **nepatria** do svojej domény a prečo?
`cena = -5` · `hodnotenie = 12` · `rok = 2015` · `zaner = 'RGP'` · `aktualizovane = '2026-02-30 10:00'`

**T3. (doména – vlastný návrh)** Napíš doménu (povolené hodnoty + pravidlá) pre tieto atribúty:
(a) `rok`, (b) `hodnotenie`, (c) `zaner`, (d) `aktualizovane`.

**T4. (otvorená – peniaze a zaokrúhľovanie)** Prečo je riziko ukladať `cena` ako „desatinné číslo"
(REAL)? Čo sa môže stať, keď spočítaš ceny tisícok hier? Ako by si to riešil?

**T5. (otvorená – dátumy)** Dátum `03/04/2026` môže znamenať dva rôzne dni. Vysvetli ktoré a prečo je
zápis `2026-04-03` (ISO 8601) pre databázu lepší.

**T6. (otvorená – časové pásmo)** Server uloží `aktualizovane = 2026-09-16 12:00` v čase UTC.
Koľko je vtedy u nás (letný čas, UTC+2)? Prečo veľké systémy ukladajú čas v UTC a nie v lokálnom čase?

**T7. (otvorená – návrh domény)** Do tabuľky by sme chceli pridať atribút `pocet_hracov`
(koľko hráčov hru hrá naraz). Navrhni jeho doménu. Aké nezmysly by mala doména zakázať?

**T8. (dáta vs. informácia)** Rozhodni: „59.99" → ______ · „Najnovšie aktualizovaná hra je
Valorant" → ______ · „2026-09-14 19:30" → ______

---

# ČASŤ 2 — Precvičenie: SELECT a filtrovanie

Pracujeme v **sqliteonline.com** (engine SQLite). Na začiatku raz vlož a spusti príkaz nižšie
(vytvorí tabuľku `hry` – 20 hier aj so stĺpcom `aktualizovane`), potom rieš úlohy.
Žánre píš bez diakritiky, dátumy v úvodzovkách vo formáte `'RRRR-MM-DD'`.

```sql
DROP TABLE IF EXISTS hry;
CREATE TABLE hry (id INTEGER PRIMARY KEY, nazov TEXT, zaner TEXT, rok INTEGER,
  hodnotenie REAL, cena REAL, aktualizovane TEXT);
INSERT INTO hry VALUES
 (1,'The Witcher 3','RPG',2015,9.3,29.99,'2026-07-15 09:20'),(2,'Minecraft','Sandbox',2011,9.0,23.95,'2026-09-01 12:00'),
 (3,'Counter-Strike 2','FPS',2023,8.1,0.00,'2026-09-10 18:45'),(4,'Red Dead Redemption 2','Akcia',2018,9.5,59.99,'2026-05-02 10:00'),
 (5,'Stardew Valley','Simulacia',2016,9.1,13.99,'2026-08-20 14:30'),(6,'Hollow Knight','Plosinovka',2017,9.2,14.99,'2026-03-11 08:15'),
 (7,'FIFA 23','Sport',2022,7.4,39.99,'2026-08-05 16:00'),(8,'Portal 2','Logicka',2011,9.4,9.99,'2026-01-20 11:00'),
 (9,'Cyberpunk 2077','RPG',2020,7.9,49.99,'2026-06-30 22:10'),(10,'Among Us','Party',2018,8.0,3.99,'2026-09-12 13:05'),
 (11,'Elden Ring','RPG',2022,9.6,59.99,'2026-08-28 07:40'),(12,'Valorant','FPS',2020,8.3,0.00,'2026-09-14 19:30'),
 (13,'Celeste','Plosinovka',2018,9.0,19.99,'2026-04-18 15:50'),(14,'The Sims 4','Simulacia',2014,7.6,0.00,'2026-02-27 09:00'),
 (15,'God of War','Akcia',2018,9.4,49.99,'2026-07-01 12:12'),(16,'Rocket League','Sport',2015,8.5,0.00,'2026-08-09 20:00'),
 (17,'Baldurs Gate 3','RPG',2023,9.7,59.99,'2026-09-05 10:30'),(18,'Fall Guys','Party',2020,7.8,0.00,'2026-09-08 17:15'),
 (19,'DOOM Eternal','FPS',2020,8.8,39.99,'2026-06-14 11:45'),(20,'Tetris Effect','Logicka',2018,8.9,29.99,'2026-08-02 13:20');
```

## Zopakuj si (SELECT z minula)
**S1.** Vypíš celú tabuľku.  **S2.** Vypíš len **názvy a ceny**.  **S3.** Vypíš hry žánru **FPS**.
**S4.** Zoraď hry **od najdrahšej**.

## Presnejšie filtrovanie
**F1.** RPG hry vydané **po roku 2019**. *(`AND`)*
**F2.** Hry, ktoré sú **zadarmo** (cena 0).
**F3.** Hry s cenou **od 10 do 30 €** (vrátane). *(`BETWEEN`)*
**F4.** Hry, ktoré sú **RPG alebo FPS**. *(`IN`)*
**F5.** Hry, ktorých názov **začína na C**. *(`LIKE 'C%'`)*
**F6.** Hry drahšie ako **40 € a zároveň** hodnotené **nad 9**.

## Práca s dátumom (nový stĺpec)
**F7.** Hry **aktualizované po** `2026-08-01`. *(`WHERE aktualizovane > '2026-08-01'`)*
**F8.** Zoraď hry **od najnovšie aktualizovanej**. *(`ORDER BY aktualizovane DESC`)*
**F9. (rozmysli)** Skús `SELECT * FROM hry ORDER BY aktualizovane;` — zoradí sa dátum správne? Prečo áno? *(súvis s ISO formátom a doménou)*

---

## 🔜 Na zamyslenie do budúcej hodiny
Žáner `RPG` sa v tabuľke **opakuje**. Čo keby sme si ku každému žánru chceli uložiť aj popis?
Museli by sme ho písať znova pri každej hre… Preto databáza často potrebuje **viac prepojených
tabuliek** — o tom bude ďalšia hodina.
