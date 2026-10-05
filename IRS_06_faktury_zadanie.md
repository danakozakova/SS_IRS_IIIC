# IRS — Mini-projekt: Evidencia faktúr (Excel)

Meno: ______________________  Trieda: ________

**Situácia:** Malá firma (weby a grafika) si vedie evidenciu vystavených faktúr v jednom Exceli.
**Jeden riadok = jedna položka na faktúre.** Dostala si od zákazníka súbor `IRS_06_faktury_data.xlsx`.
Tvoja úloha: urobiť z neho **poriadnu databázu** — oddeliť tabuľky, ohlídať údaje a nájsť chyby.

```
 DNES                                      CIEĽ
 ┌──────────────────────────────┐          ┌───────┐   ┌───────┐   ┌───────┐
 │  jedna veľká tabuľka,        │   ──►    │  ???  │───│  ???  │───│  ???  │
 │  všetko stále dookola        │          └───────┘   └───────┘   └───────┘
 └──────────────────────────────┘           spojené cez PK / FK
```

---

## 1. Prezri si evidenciu
- ☐ Koľko je riadkov? Ktoré údaje sa **opakujú** dookola?
- ☐ Ktoré stĺpce patria **jednej faktúre**? Ktoré patria **zákazníkovi**? Zafarbi ich (každé inou farbou).
- ☐ Na papier nakresli **3 tabuľky** (názov + stĺpce) a **šípky** medzi nimi (PK → FK).

## 2. Tabuľka zákazníkov
- ☐ Nový hárok. Skopíruj doň stĺpce zákazníka → **Údaje → Odstrániť duplicity**.
- ☐ **Kontrola: zákazníkov má byť 6.** Vyšlo viac? V evidencii je **preklep**. Nájdi ho, oprav **v pôvodnom hárku** a skús znova.
- ☐ Pridaj prvý stĺpec s **id (PK)** — 1, 2, 3…
- ☐ Pomenuj stĺpce podľa vzoru z minulej hodiny (`..._pk_...`).

## 3. Tabuľka faktúr
- ☐ Nový hárok. Skopíruj stĺpce faktúry (+ meno zákazníka) → **Odstrániť duplicity**.
- ☐ **Kontrola: faktúr má byť 8.** Vyšlo viac? Tá istá faktúra má v dvoch riadkoch **rôzny údaj** — oprav v zdroji.
- ☐ Pridaj stĺpec **FK na zákazníka** (id) cez `INDEX`/`MATCH`:

```
=INDEX( id zákazníkov ; MATCH( meno z tohto riadku ; mená v tabuľke zákazníkov ; 0 ) )
```
- ☐ Vzorec **prilep ako hodnoty** → potom **zmaž stĺpec s menom**.
- ☐ Vo `faktura` vidíš teraz len číslo zákazníka. Vedľa pridaj stĺpec **meno zákazníka** (len na čítanie), opačným smerom (číslo → meno). Vzorec s podmienkou „ak je prázdne, nič nezobrazuj“:

```
=IF( FK v tomto riadku = "" ; "" ; INDEX( mená zákazníkov ; MATCH( FK v tomto riadku ; id zákazníkov ; 0 ) ) )
```
  Tento stĺpec je **vzorec** — nič sa do neho nezapisuje, len ukazuje, čo číslo znamená. **Neprilepuj ho ako hodnoty.**
- ☐ Vzorec skopíruj **aj do rezervných riadkov** pod dátami (napr. do riadku 30), aby bolo vidieť, kam až systém siaha.
- ☐ Zamkni ho až na konci, po bode 5 (overenia).

## 4. Tabuľka položiek
- ☐ Nový hárok: **číslo faktúry** (bude FK), položka, množstvo, cena. Pridaj vlastné **id (PK)**.
- ☐ Stĺpce, ktoré patria faktúre alebo zákazníkovi, tu **nesmú ostať**.

## 5. Overenie údajov
Údaje → **Overenie údajov**. Ku každému nastav aj **chybové hlásenie**.
Stĺpce označ **s rezervou** — aj s pár prázdnymi riadkami navyše (rovnako ako vzorec v bode 3), nech nastavenia platia aj pre budúce riadky.

```
 TABUĽKA     STĹPEC            PRAVIDLO
 ─────────────────────────────────────────────────────────────────
 zákazník    meno              text, dĺžka aspoň 3
             e-mail            Vlastné:  =COUNTIF(C2;"*@?*.?*")=1     (C2 = prvá bunka výberu)
             adresa            text, dĺžka aspoň 5
 faktúra     dátum             dátum od 1.1.2026 do dnes
             stav              zoznam: čaká na zaplatenie; zaplatená; po lehote splatnosti
             FK zákazník       zoznam: id zo zákazníkov
 položky     FK faktúra        zoznam: id z faktúr
             množstvo          celé číslo, aspoň 1
             cena              desatinné číslo, väčšie ako 0 — navrhni rozumný strop
```

## 6. Zamkni stĺpec s menom zákazníka (bez hesla)
```
 1. Ctrl+A  →  Formát buniek → Zámok → ODŠKRTNI „Zamknuté“   (odomkni všetko)
 2. Označ stĺpec s menom zákazníka (aj rezervu) → Formát buniek → Zámok → ZAŠKRTNI „Zamknuté“
 3. Skontrolovať → Zamknúť hárok → heslo nechaj PRÁZDNE → OK
 4. Skús do stĺpca s menom písať — Excel to nepustí. Ostatné stĺpce ostali upraviteľné.
```
Zamykáš **raz, na konci**. Hárok potom neodomykaj — nové faktúry píš do prvého prázdneho riadku, meno sa doplní samo.

## 7. Nájdi chyby
- ☐ Na každom hárku: **Údaje → Overenie údajov ▾ → Zakrúžiť neplatné údaje**. Červené kruhy = nezmysly.
- ☐ Zapíš si, **koľko kruhov** si našla a **čo v nich bolo** (preklep? zlé číslo? posunutá čiarka?).
- ☐ Oprav ich → kruh zmizne. Nevieš, aká je správna hodnota? Vlož **komentár** do bunky.
- ☐ Na koniec: **Vymazať kruhy**.

---

## ✔ Odfajkovací zoznam — mám hotové?
- ☐ 3 samostatné tabuľky, každá má **PK** ako prvý stĺpec
- ☐ Cudzie kľúče sú **čísla** (nie texty), žiadne `#N/A`
- ☐ Vo `faktura` je vedľa FK stĺpec s menom zákazníka (vzorec s podmienkou „ak je prázdne“) až do konca rezervy a je **zamknutý**
- ☐ Zákazníkov 6, faktúr 8, položiek 23
- ☐ Overenie je nastavené na **každom** stĺpci z tabuľky v bode 5, aj v rezerve
- ☐ Všetky červené kruhy opravené / okomentované
- ☐ Súbor uložený a odovzdaný

## Zamysli sa
- Prečo je lepšie, že adresa zákazníka je uložená **raz**, a nie pri každej položke?
- Čo by sa stalo, keby si v pôvodnej tabuľke zmenila adresu len v jednom riadku?
- Ktorý preklep by overenie údajov **nechytilo**?
