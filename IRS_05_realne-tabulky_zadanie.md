# IRS — Od číselníka k reálnej tabuľke a výstupu (Excel)

Meno: ______________________  Trieda: ________

Minule sme vytvorili číselník a začali dopĺňať id. Dnes dokončíme prevod na **reálnu databázovú
štruktúru**, pridáme **kontrolu vstupu** a nakoniec **prehľadný spojený výstup**.

> ## 🎯 O čo tu ide (po ľudsky)
> V tabuľke hier píšeme žáner (`RPG`, `FPS`, `Akcia`…) **stále dookola**. To je plytvanie a ľahko sa preklepneš.
>
> **Nápad (ako to robia databázy):** urobíme **malý zoznam žánrov**, každý dostane **číslo**.
> V tabuľke hier potom necháme **len to číslo** namiesto textu. A keď chceme vidieť názov, číslo si podľa
> zoznamu **„preložíme" späť** — na samostatnom hárku, ktorý slúži len na čítanie.
>
> **Prečo:** menej miesta, žiadne preklepy, a premenovanie žánru sa robí **na jednom mieste**.
> Presne takto vyzerá databáza: **hlavná tabuľka + malý číselník**, prepojené cez číslo, a **pohľad** na čítanie.
>
> *Predstav si šatňu: nepíšeš „červená bunda s kapucňou" na každý lístok — dostaneš **číslo 7**, a zoznam „7 = červená bunda" visí pri okienku len raz.*

## Pomenovanie (dohodneme si a použijeme aj v Exceli)
Máme dve tabuľky: **`hry`** a **`zaner`** (číselník žánrov). Kľúčové stĺpce pomenúvame podľa vzoru
**`nazovtabulky_pk|fk_nazovstlpca`**:
- **PK = primárny kľúč** — jednoznačne identifikuje riadok v tabuľke. Napr. `zaner_pk_id`, `hry_pk_id`.
- **FK = cudzí kľúč** — odkazuje na PK inej tabuľky. Napr. `hry_fk_zaner` (v `hry` ukazuje na `zaner_pk_id`).

Tabuľka `zaner` má stĺpce **`zaner_pk_id` (prvý stĺpec — ako v reálnej tabuľke)** a `zaner_nazov`.

---

## Časť 1 — XLOOKUP: doplň cudzí kľúč
👉 *Po ľudsky: ku každej hre priradíme **číslo** jej žánru.*

V `hry` máš zatiaľ textový stĺpec so žánrom (`hry_zaner_txt`). Do nového stĺpca **`hry_fk_zaner`** doplň id žánru:
`=XLOOKUP(hry_zaner_txt; zaner_nazov; zaner_pk_id)`  *(nájdi text v stĺpci názvov a vráť id)*.
Skontroluj, že **každá hra má id**.
> Používame **XLOOKUP** (moderná funkcia): hľadá v **ľubovoľnom** stĺpci a vracia ľubovoľný — preto môže mať `zaner` **id ako prvý stĺpec**, ako v skutočnej databáze. (Klasický `VLOOKUP` by potreboval hľadaný stĺpec vľavo.)
> `hry_fk_zaner` je zatiaľ **vzorec** — živé prepojenie na číselník.

## Časť 2 — Reálna tabuľka (hodnoty namiesto vzorca)
👉 *Po ľudsky: to číslo „zabetónujeme" a textový žáner vyhodíme — v hrách ostane len číslo.*

1. Označ `hry_fk_zaner` → **Kopírovať** → **Prilepiť špeciálne → Hodnoty** (`Ctrl+Shift+V` → *Hodnoty*).
2. **Zmaž textový stĺpec `hry_zaner_txt`.** V `hry` ostane `hry_fk_zaner` (číslo).

**Výsledok:** `hry` (fakty, `hry_fk_zaner` = cudzí kľúč) + `zaner` (číselník). **Presne takto vyzerajú tabuľky v databáze.**

## Časť 3 — Overenie údajov (najprv jednoduché)
👉 *Po ľudsky: nastavíme, aby sa do stĺpcov nedali zadať nezmysly (napr. záporná cena).*

Údaje → **Overenie údajov** (zoznam necháme na časť 4):
- `hodnotenie`: Desatinné číslo, *medzi* 0 a 10
- `cena`: Desatinné číslo, *≥* 0
- `rok`: Celé číslo, *medzi* 1958 a 2026
- `aktualizovane`: Dátum, *medzi* 1.1.2000 a dnes

Ku každému nastav **Chybové hlásenie**. Skús zadať nezmysel (cena −5, hodnotenie 12) — Excel to **nepustí**.

## Časť 4 — Pomenované oblasti (referencia názvom, nie adresou)
👉 *Po ľudsky: zoznamu žánrov dáme meno, nech sa naň dá odkazovať po mene, nie cez adresy buniek.*

1. V tabuľke `zaner` označ stĺpec s názvami → do **Poľa názvov** (vľavo hore) napíš **`zaner_nazov`** → Enter.
   Rovnako stĺpec s id pomenuj **`zaner_pk_id`**.
2. Pomocná bunka „výber žánru": Overenie údajov → **Zoznam** → Zdroj: `=zaner_nazov`.
   Odkazuješ sa **na názov `zaner_nazov`**, nie na adresu `$A$2:$A$10`.
> Prečo lepšie: čitateľné, prežije presun buniek, netreba pamätať adresy.

## Časť 5 — Spojený („joinovaný") výstup na 3. hárku, len na čítanie
👉 *Po ľudsky: na treťom hárku číslo zase „preložíme" späť na názov, aby to bolo čitateľné.*

1. Na **nový (3.) hárok** doplň ku každej hre **názov žánru** podľa `hry_fk_zaner`:
   `=XLOOKUP(hry_fk_zaner; zaner_pk_id; zaner_nazov)`
   *(vezmi cudzí kľúč z `hry`, nájdi ho v primárnom kľúči `zaner`, vráť názov)*.
   > Ten istý `XLOOKUP` ako v časti 1, len naopak: hľadáme podľa id a vraciame názov.
2. Čitateľné stĺpce: `nazov`, `zaner (názov)`, `rok`, `hodnotenie`, `cena`, `aktualizovane`.
3. Hárok **zamkni na čítanie**: Skontrolovať → **Zamknúť hárok** — je to len **výstup**.

> **Ako výstup rozšíriť pri raste?** Najčistejšie: sprav z `hry` **tabuľku** (`Ctrl+T`) a použi dynamický
> vzorec (rozleje sa sám) — výstup rastie automaticky. Jednoduchšia alternatíva: predvyplniť riadky a
> každý obaliť do `=IF(zdroj=""; ""; XLOOKUP(...))`, nech prázdne riadky ostanú prázdne (má pevný strop).

**Výsledok:** dáta uložené efektívne (`hry` + `zaner`), 3. hárok = **spojený pohľad** len na čítanie.

## Časť 6 — Pridaj nový žáner do `zaner` (a uprav pomenované rozsahy)
👉 *Po ľudsky: skúsime pridať nový žáner — a zariadime, aby ho všetko „videlo".*

1. Do `zaner` pridaj nový riadok: nový `zaner_nazov` + ďalšie `zaner_pk_id`.
2. **Problém:** pomenované rozsahy boli po pevnú oblasť — nový riadok **nezahŕňajú**.
3. **Rieš:** Vzorce → **Správca názvov** → uprav rozsah. **Lepšie:** `zaner` ako **tabuľka** (`Ctrl+T`) → rozsahy rastú samy.
4. Over: nový žáner je v rozbaľovacom zozname.

## Časť 7 — Pridaj novú hru do `hry`
👉 *Po ľudsky: pridáme novú hru a overíme, že celý systém funguje.*

1. Nový riadok v `hry`: `nazov`, `hry_fk_zaner` (pokojne nový žáner z časti 6), `rok`, `hodnotenie`, `cena`, `aktualizovane`.
2. Pozri **3. hárok** — nová hra sa objaví aj s **názvom žánru**.
3. **Záver:** funkčný mini-systém — číselník + hlavná tabuľka + spojený výstup, ktorý **rastie** a **stráži správnosť**.

---

## Zamysli sa
- Prečo `hry` drží `hry_fk_zaner` ako číslo a názov žánru je len v tabuľke `zaner`?
- Čím sa líši **vzorec** od **prilepenej hodnoty**? Kde chceme čo?
- 3. hárok je „len výstup" — na čo taký slúži v databáze? *(pohľad, ktorý spája tabuľky)*
