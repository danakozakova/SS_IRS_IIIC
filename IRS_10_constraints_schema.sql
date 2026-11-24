-- =====================================================================
--  IRS 10 — Zjednotená schéma + obmedzenia (constraints)
--  Nadväzuje na 09 (recenzia a oprava CREATE). Teraz máme VŠETCI
--  rovnakú, kanonickú verziu a pridávame troch nových strážcov:
--     • UNIQUE   na email            (žiadne dva rovnaké e-maily)
--     • CHECK    na stav             (len povolené stavy faktúry)
--     • UNSIGNED na číslo faktúry     (nezáporné číslo)
--  Prostredie: MySQL / MariaDB 10.4 / phpMyAdmin (karta SQL).
--  Dá sa spúšťať opakovane (DROP na začiatku).
-- =====================================================================

-- (voliteľné) vlastná databáza:
-- CREATE DATABASE IF NOT EXISTS faktury CHARACTER SET utf8mb4;
-- USE faktury;

-- Mazanie v opačnom poradí ako FK (najprv deti, potom rodičia) ----------
DROP TABLE IF EXISTS faktura_polozka;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS polozka_cennika;
DROP TABLE IF EXISTS zakaznik;

-- =====================================================================
--  1) zakaznik  —  rodičovská tabuľka
-- =====================================================================
CREATE TABLE zakaznik (
    id      INT AUTO_INCREMENT PRIMARY KEY,   -- umelé id, čísluje databáza
    meno    VARCHAR(100) NOT NULL,
    email   VARCHAR(100) UNIQUE,              -- NOVÉ: žiadne dva rovnaké e-maily
    adresa  VARCHAR(150)                      -- email smie byť NULL; NULL sa pri UNIQUE smie opakovať
);

-- =====================================================================
--  2) polozka_cennika  —  rodičovská tabuľka
-- =====================================================================
CREATE TABLE polozka_cennika (
    id      INT AUTO_INCREMENT PRIMARY KEY,
    nazov   VARCHAR(100) NOT NULL,
    cena    DECIMAL(8,2) NOT NULL CHECK (cena >= 0)   -- doména z 09: cena nesmie byť záporná
);

-- =====================================================================
--  3) faktura  —  odkazuje na zakaznik
-- =====================================================================
CREATE TABLE faktura (
    id          INT UNSIGNED PRIMARY KEY,     -- NOVÉ: číslo faktúry (2026001...) je nezáporné → UNSIGNED, zadávame ho sami
    datum       DATE NOT NULL,
    stav        VARCHAR(30) NOT NULL
                CHECK (stav IN ('čaká na zaplatenie', 'zaplatená', 'stornovaná')),  -- NOVÉ: vymenovaná doména stavu
    zakaznik_id INT NOT NULL,
    FOREIGN KEY (zakaznik_id) REFERENCES zakaznik(id)
);

-- =====================================================================
--  4) faktura_polozka  —  väzobná tabuľka (rozbité M:N)
-- =====================================================================
CREATE TABLE faktura_polozka (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    faktura_id          INT UNSIGNED NOT NULL,   -- POZOR: typ MUSÍ sedieť s faktura.id (INT UNSIGNED), inak FK neprejde
    polozka_cennika_id  INT NOT NULL,
    mnozstvo            INT NOT NULL CHECK (mnozstvo > 0),   -- doména z 09: aspoň 1 kus
    FOREIGN KEY (faktura_id)         REFERENCES faktura(id),
    FOREIGN KEY (polozka_cennika_id) REFERENCES polozka_cennika(id)
);

-- =====================================================================
--  Kontrola: celá definícia tabuľky vrátane CHECK/UNIQUE/UNSIGNED
-- =====================================================================
-- SHOW CREATE TABLE faktura;
-- SHOW CREATE TABLE zakaznik;
