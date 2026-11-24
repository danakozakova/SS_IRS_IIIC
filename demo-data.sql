-- Demo tabuľka pre 1. hodinu IRS (funguje v Supabase/PostgreSQL, aj v MySQL a SQLite)
-- Zámerne bez SERIAL/AUTO_INCREMENT, aby to bežalo všade rovnako.

CREATE TABLE hry (
  id         int PRIMARY KEY,
  nazov      text,
  zaner      text,
  rok        int,
  hodnotenie numeric,   -- 0 až 10
  cena       numeric    -- v eurách
);

INSERT INTO hry (id, nazov, zaner, rok, hodnotenie, cena) VALUES
  (1,  'The Witcher 3',        'RPG',        2015, 9.3, 29.99),
  (2,  'Minecraft',            'Sandbox',    2011, 9.0, 23.95),
  (3,  'Counter-Strike 2',     'FPS',        2023, 8.1,  0.00),
  (4,  'Red Dead Redemption 2','Akcia',      2018, 9.5, 59.99),
  (5,  'Stardew Valley',       'Simulácia',  2016, 9.1, 13.99),
  (6,  'Hollow Knight',        'Plošinovka', 2017, 9.2, 14.99),
  (7,  'FIFA 23',              'Šport',      2022, 7.4, 39.99),
  (8,  'Portal 2',             'Logická',    2011, 9.4,  9.99),
  (9,  'Cyberpunk 2077',       'RPG',        2020, 7.9, 49.99),
  (10, 'Among Us',             'Párty',      2018, 8.0,  3.99);

-- Rýchla kontrola, že sa dáta nahrali:
-- SELECT * FROM hry;
