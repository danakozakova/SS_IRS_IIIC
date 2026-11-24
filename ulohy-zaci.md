# SQL pieskovisko — úlohy (tabuľka `hry`)

Meno: ______________________  Trieda: ________

Pracujeme v **SQL pieskovisku**. Tabuľka `hry` má stĺpce:
`id`, `nazov`, `zaner`, `rok`, `hodnotenie` (0–10), `cena` (v €).

Postup: napíš príkaz, spusti (**Spustiť** alebo `Ctrl`+`Enter`), pozri výsledok a premýšľaj, čo sa stalo.
Keď niečo pokazíš, klikni *Vynulovať dáta*.

---

## ČASŤ A — Úlohy (od najľahšej po najťažšiu)

**Úloha 1.** Vypíš celú tabuľku — všetky hry a všetky stĺpce.

**Úloha 2.** Vypíš iba názvy hier (len jeden stĺpec).

**Úloha 3.** Nájdi všetky hry žánru **RPG**.

**Úloha 4.** Nájdi hry, ktoré stoja **menej ako 15 €**.

**Úloha 5.** Zoraď hry **od najlepšie hodnotenej** po najhoršiu.

**Úloha 6.** Nájdi hry vydané **po roku 2017** a zoraď ich od najnovšej.

**Úloha 7. (bonus)** Zisti, **koľko hier** je v tabuľke. *(Nápoveda: skús `COUNT(*)`.)*

**Úloha 8. (bonus)** Vypíš **jednu najdrahšiu** hru. *(Nápoveda: zoraď podľa ceny a použi `LIMIT 1`.)*

---

## ČASŤ B — Testík: čo ktorý príkaz znamená?

### B1 — Spoj príkaz s jeho významom (napíš písmeno)

| # | Príkaz |
|---|--------|
| A | `SELECT * FROM hry;` |
| B | `SELECT nazov, cena FROM hry;` |
| C | `SELECT * FROM hry WHERE zaner = 'RPG';` |
| D | `SELECT * FROM hry ORDER BY cena;` |
| E | `SELECT * FROM hry WHERE hodnotenie >= 9;` |
| F | `SELECT * FROM hry WHERE rok = 2011;` |

- ___ vyberie len stĺpce názov a cena
- ___ vyberie celú tabuľku (všetky stĺpce, všetky riadky)
- ___ vyberie len hry žánru RPG
- ___ zoradí hry podľa ceny od najlacnejšej
- ___ vyberie hry hodnotené 9 a viac
- ___ vyberie hry vydané v roku 2011

### B2 — Predpovedz výsledok (najprv tipni, potom si over v pieskovisku)

1. Čo vráti `SELECT * FROM hry WHERE cena = 0;` ? Koľko hier to bude?

   ________________________________________________________________

2. Čím sa líši `ORDER BY cena` od `ORDER BY cena DESC`?

   ________________________________________________________________

3. Doplň príkaz, ktorý vyberie **všetky hry žánru Logická**:

   `SELECT * FROM hry WHERE __________________________ ;`
