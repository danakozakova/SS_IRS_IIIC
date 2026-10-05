# IRS — Od číselníka k reálnej tabuľke (Excel)

Meno: ______________________  Trieda: ________

## Čo budeme robiť

```
 PRED                                   PO
 ┌─────────────────────┐                ┌──────────────────┐        ┌───────────────────┐
 │ hry                 │                │ hry              │        │ žáner (číselník)  │
 │ ... │ žáner (text)  │                │ ... │ žáner (id) │ ─────► │ id  │ názov       │
 │ ... │ RPG           │      ──►       │ ... │ 3          │        │  3  │ RPG         │
 │ ... │ FPS           │                │ ... │ 7          │        │  7  │ FPS         │
 │ ... │ RPG           │                │ ... │ 3          │        │ 10  │ Akcia       │
 └─────────────────────┘                └──────────────────┘        └───────────────────┘
   text dookola = preklepy                 len číslo = ušetrené           názov je len raz
```

Číslo, ktoré ukazuje do inej tabuľky, je **cudzí kľúč (FK)**. Číslo, ktoré riadok jednoznačne označuje, je **primárny kľúč (PK)**.
Názvy stĺpcov si dohodneme na hodine — nemusíš ich dodržať do písmena, ale **drž jeden štýl**.

---

## 0. Dva nástroje: MATCH a INDEX

```
 MATCH  =  „na ktorom riadku to je?“   →  vráti ČÍSLO riadku
 INDEX  =  „čo je v tom riadku?“       →  vráti HODNOTU
```

```
            id    názov
          ┌────┬───────────┐
 riadok 1 │  3 │ RPG       │
 riadok 2 │  5 │ Sandbox   │
 riadok 3 │  7 │ FPS       │
 riadok 4 │ 10 │ Akcia     │ ◄── MATCH("Akcia"; stĺpec názvov; 0)  →  4
 riadok 5 │ 13 │ Simulacia │
          └────┴───────────┘
                  INDEX(stĺpec id; 4)  →  10
```

Spolu: **`=INDEX( stĺpec, z ktorého chcem odpoveď ; MATCH( čo hľadám ; stĺpec, v ktorom hľadám ; 0 ) )`**

Nula na konci = hľadaj **presnú** zhodu.

---

## 1. Doplň cudzí kľúč (text → číslo)
Ku každej hre chceš číslo jej žánru.

```
 =INDEX( id žánrov ; MATCH( žáner v tejto hre ; názvy žánrov ; 0 ) )
          └─ odpoveď ┘        └─ čo hľadám ┘     └─ kde hľadám ┘
```
- ☐ Nový stĺpec vedľa textového žánru, vzorec skopíruj na všetky riadky.
- ☐ Žiadne `#N/A`? Ak áno → preklep v texte žánru alebo v číselníku.

## 2. Zabetónuj číslo
- ☐ Označ nový stĺpec → **Kopírovať** → **Prilepiť špeciálne → Hodnoty**.
- ☐ Zmaž stĺpec s textovým žánrom.

```
 vzorec  =INDEX(...)   →  prepočítava sa, závisí od zdroja
 hodnota  3            →  natrvalo zapísané číslo
```

## 3. Overenie údajov (stráž, čo sa smie zadať)
**Údaje → Overenie údajov**, ku každému nastav aj **chybové hlásenie**.
Stĺpce označ **s rezervou** — aj s pár prázdnymi riadkami navyše (napr. do riadku 50). Všetko, čo nastavíš, tak bude platiť aj pre budúce riadky.

```
 STĹPEC          POVOLIŤ            PODMIENKA
 ───────────────────────────────────────────────────
 hodnotenie      desatinné číslo    medzi 0 a 10
 cena            desatinné číslo    ≥ 0
 rok             celé číslo         medzi 1958 a 2026
 aktualizované   dátum              medzi 1.1.2000 a dnes
```
- ☐ Skús zadať nezmysel (cena −5, hodnotenie 12). Excel to **nepustí**.

## 4. Pomenuj zoznam žánrov
- ☐ Označ stĺpec s **názvami žánrov** → do **Poľa názvov** (vľavo hore) napíš meno → Enter.
- ☐ To isté pre stĺpec s **id**.
- ☐ Bunka „výber žánru“: **Overenie údajov → Zoznam** → zdroj `=` + tvoje meno oblasti.

```
 =$A$2:$A$10     ✗  adresa — pri zmene sa rozbije
 =zaner_nazov    ✔  meno — čitateľné, prežije presun buniek
```

## 5. Ukáž, čo číslo znamená (číslo → názov)
V `hry` vidíš len číslo žánru. Vedľa pridaj stĺpec s **názvom** — opačný smer ako v bode 1.

```
 =INDEX( názvy žánrov ; MATCH( id žánru v tomto riadku ; id žánrov ; 0 ) )
          └─ odpoveď ┘        └─ čo hľadám ┘             └─ kde hľadám ┘
```

```
   hry                                    číselník
   ... │ žáner (id) │ žáner (názov)       id │ názov
   ... │     3      │ RPG      ◄──vzorec   3 │ RPG
        └ zapisuješ ┘ └ len na čítanie ┘
```
- ☐ Vzorec dopíš s podmienkou „ak je prázdne, nič nezobrazuj“ — aby prázdne riadky ostali prázdne:

```
 =IF( id žánru v tomto riadku = "" ; "" ; INDEX( názvy žánrov ; MATCH( id žánru v tomto riadku ; id žánrov ; 0 ) ) )
```
- ☐ Skopíruj ho nadol **aj do rezervných riadkov** — aby bolo vidieť, kam až systém siaha.
- ☐ Tento stĺpec **neprilepuj ako hodnoty** — musí ostať vzorec.
- ☐ Až teraz ho **zamkni na čítanie** (bez hesla):

```
 1. Ctrl+A  →  Formát buniek → Zámok → ODŠKRTNI „Zamknuté“   (odomkni všetko)
 2. Označ stĺpec s názvom žánru (aj rezervu) → Formát buniek → Zámok → ZAŠKRTNI „Zamknuté“
 3. Skontrolovať → Zamknúť hárok → heslo nechaj PRÁZDNE → OK
 4. Skús do stĺpca s názvom písať — Excel to nepustí. Ostatné stĺpce ostali upraviteľné.
```
Zamykáš **raz, na konci**. Potom už hárok neodomykaš.

## 6. Nový žáner
- ☐ Pridaj do číselníka nový riadok (názov + ďalšie id).
- ☐ Nový žáner sa nezobrazuje v zozname? Oblasť je pevná. → **Vzorce → Správca názvov** → rozšír ju.
- ☐ Lepšie: číselník ako **tabuľka** (`Ctrl+T`), oblasť potom rastie sama.

## 7. Nová hra
- ☐ Piš do **prvého prázdneho riadku** v `hry` (pokojne s novým žánrom). Hárok **neodomykaj**.
- ☐ Overenie ťa pri zlom údaji zastaví a názov žánru sa v zamknutom stĺpci **zobrazí sám**.
- ☐ Došli ti rezervné riadky? Systém je potrebné rozšíriť — zisti, čo všetko (overenie, vzorec, zámok).

---

## ✔ Odfajkovací zoznam — mám hotové?
- ☐ V `hry` je žáner len ako **číslo** (FK), textový stĺpec je preč
- ☐ Číselník má id ako **prvý stĺpec**
- ☐ Žiadne `#N/A`
- ☐ Overenie je nastavené na všetkých štyroch stĺpcoch, **aj v rezerve**
- ☐ Zoznam žánrov má **meno oblasti** a funguje ako rozbaľovací zoznam
- ☐ Vedľa čísla žánru je stĺpec s názvom (vzorec s podmienkou „ak je prázdne“) až do konca rezervy a je **zamknutý** — písať do neho nejde
- ☐ Nový žáner aj nová hra sa v systéme objavia

## Zamysli sa
- Prečo je v `hry` len číslo a názov žánru je uložený raz?
- Čím sa líši **vzorec** od **hodnoty**? Kde chceme čo?
- Prečo je stĺpec s názvom zamknutý? Čo by sa stalo, keby si do neho prepísala názov ručne?
