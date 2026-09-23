# IRS — Pracovný list: od jednej tabuľky k číselníku (žánre)

Meno: ______________________  Trieda: ________

Tabuľka `hry` má stĺpec `zaner`, ktorý sa **opakuje** — veľa hier má `RPG`, `FPS`, `Akcia`…
Ten istý text píšeme dokola = **redundancia**. Dnes si ukážeme, ako to databázy riešia: žánre dáme
do samostatnej **číselníkovej** tabuľky a v hrách sa na ne budeme odvolávať **číslom (id)**.
Spravíme si to v **Exceli**.

## Kroky

**1.** V **sqliteonline** maj tabuľku `hry` (dáta z minulej hodiny — aj so stĺpcom `aktualizovane`).

**2.** Exportuj tabuľku `hry` do **CSV** a otvor ju v **Exceli**.
*(sqliteonline: Export → CSV; alebo skopíruj výsledok `SELECT * FROM hry;` a vlož do Excelu.)*

**3.** Pozri stĺpec `zaner`. Vypíš, ktoré žánre sa **opakujú**. Koľko rôznych žánrov je?

**4.** Na nový hárok sprav **číselník** `zanre` s dvoma stĺpcami: `id_zanru`, `nazov_zanru`.
Každý žáner zapíš **len raz** a daj mu poradové id (1, 2, 3, …).

**5.** Vráť sa do tabuľky `hry`: pridaj stĺpec `zaner_id` a ku každej hre doplň **id jej žánru**
podľa číselníka (ručne alebo cez `VLOOKUP`/`XLOOKUP`). Pôvodný textový `zaner` potom môžeš skryť/zmazať.

**6.** Výsledok: máš **dve tabuľky** — `zanre` (id + názov) a `hry` (… + `zaner_id`).
`zaner_id` v `hry` **ukazuje** na `id_zanru` v `zanre`.

## Zamysli sa
- Čo sme týmto **získali**? (koľkokrát je teraz uložený názov žánru „RPG"?)
- Keby sme chceli žáner premenovať (napr. „RPG" → „Rolová hra"), koľko miest musíme zmeniť teraz a koľko predtým?
- Ako databáza vie, že `zaner_id = 1` znamená konkrétny žáner? Ako sa volá také **prepojenie** medzi tabuľkami?
- Koľko riadkov má číselník `zanre` a koľko `hry`? Prečo je v poriadku, že sa líšia?
