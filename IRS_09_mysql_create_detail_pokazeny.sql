-- =====================================================================
--  IRS — "Zrecenzuj návrh od AI"  (POKAZENÝ návrh)
--  Toto nám údajne napísala AI z nášho ERD diagramu.
--  Spustí sa to bez chyby... ale je návrh naozaj dobrý?
--  Úloha: nájdi chyby, zdôvodni ich a oprav. Potom spusti opravenú verziu.
--  Prostredie: MySQL / phpMyAdmin (karta SQL).
-- =====================================================================

-- Pre opakované spustenie najprv zmažeme tabuľky
DROP TABLE IF EXISTS faktura_polozka;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS polozka_cennika;
DROP TABLE IF EXISTS zakaznik;

-- --- faktúry -----------------------------------------------------------
CREATE TABLE faktura (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    datum       VARCHAR(20),
    stav        VARCHAR(30) NOT NULL,
    zakaznik_id INT
);

-- --- zákazníci ---------------------------------------------------------
CREATE TABLE zakaznik (
    id      INT PRIMARY KEY,
    meno    VARCHAR(100),
    email   VARCHAR(5),
    adresa  VARCHAR(150)
);

-- --- cenník ------------------------------------------------------------
CREATE TABLE polozka_cennika (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    nazov   VARCHAR(100) NOT NULL,
    cena    FLOAT
);


-- --- položky na faktúre (väzobná tabuľka M:N) --------------------------
CREATE TABLE faktura_polozka (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    faktura_id          INT NOT NULL,
    polozka_cennika_id  INT NOT NULL,
    mnozstvo            INT
);

-- =====================================================================
--  Otázky pri recenzii (prejdi každý stĺpec):
--    1) Má stĺpec SPRÁVNY dátový typ?
--    2) Smie byť PRÁZDNY (NULL), alebo tam musí byť NOT NULL?
--    3) Kľúče: je PK správny? Kde majú byť FOREIGN KEY?
--    4) Doména: nemá stĺpec mať CHECK (povolené hodnoty)?
-- =====================================================================
