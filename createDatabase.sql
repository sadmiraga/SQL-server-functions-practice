REPLACE INDEX "IX_drzave_osebe" ON "public"."osebe" ("id_drzave")
;;
CREATE INDEX "IX_fk_drzave_postne_stevilke" ON "public"."postne_stevilke" ();
CREATE SCHEMA "public" AUTHORIZATION "postgres";
COMMENT ON SCHEMA "public" IS 'standard public schema';
CREATE DOMAIN "public"."tspol" AS Character varying(10) CONSTRAINT "tspol_check" CHECK (lower((VALUE)::text) = ANY (ARRAY['moški'::text, 'ženski'::text]));
CREATE TABLE "public"."drzave"(
 "id_drzave" Serial NOT NULL,
 "drzava" Character varying(120) NOT NULL,
 "oznaka_drzave" Character varying(3)
)
WITH (
 autovacuum_enabled=true);
ALTER TABLE "public"."drzave" ADD CONSTRAINT "pk_drzave" PRIMARY KEY ("id_drzave");
CREATE TABLE "public"."osebe"(
 "id_osebe" Serial NOT NULL,
 "ime" Character varying(25),
 "priimek" Character varying(35) NOT NULL,
 "emso" Character varying(20),
 "spol" Character varying(1) NOT NULL
        CONSTRAINT "ckSpol" CHECK (upper(value) in ('MOŠKI', 'ŽENSKI')),
 "datum_rojstva" Date,
 "naslov" Character varying(120),
 "enaslov" Character varying(80),
 "telefon" Character varying(20),
 "davcna_stevilka" Character varying(15),
 "id_drzave" Integer,
 "id_postne_stevilke" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE TABLE "public"."osebe"(
 "id_osebe" Serial NOT NULL,
 "ime" Character varying(25),
 "priimek" Character varying(35) NOT NULL,
 "emso" Character varying(20),
 "spol" Character varying(1) NOT NULL,
 "datum_rojstva" Date,
 "naslov" Character varying(120),
 "enaslov" Character varying(80),
 "telefon" Character varying(20),
 "davcna_stevilka" Character varying(15),
 "id_drzave" Integer,
 "id_postne_stevilke" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_fk_postne_stevilke_osebe" ON "public"."osebe" ();
CREATE INDEX "IX_drzave_osebe" ON "public"."osebe" ("id_drzave");
CREATE INDEX "IX_postne_stevilke_osebe" ON "public"."osebe" ("id_postne_stevilke");
ALTER TABLE "public"."osebe" ADD CONSTRAINT "pk_osebe" PRIMARY KEY ("id_osebe");
CREATE TABLE "public"."postne_stevilke"(
 "id_postne_stevilke" Serial NOT NULL,
 "postna_stevilka" Character varying(15),
 "kraj_mesto" Character varying(120) NOT NULL,
 "id_drzave" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_drzave_postne_stevilke" ON "public"."postne_stevilke" ("id_drzave");
ALTER TABLE "public"."postne_stevilke" ADD CONSTRAINT "pk_postnestevilke" PRIMARY KEY ("id_postne_stevilke");
CREATE TABLE "uporabniki"(
 "id_uporabnika" Serial NOT NULL,
 "uporabnisko_ime" Character varying(80) NOT NULL,
 "geslo" Character varying(80),
 "datum_registracije" Date,
 "id_osebe" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_osebe_uporabniki" ON "uporabniki" ("id_osebe");
ALTER TABLE "uporabniki" ADD CONSTRAINT "PK_uporabniki" PRIMARY KEY ("id_uporabnika");
ALTER TABLE "uporabniki" ADD CONSTRAINT "id_uporabniki" UNIQUE ("id_uporabnika");
ALTER TABLE "uporabniki" ADD CONSTRAINT "uporabnisko_ime" UNIQUE ("uporabnisko_ime");
CREATE TABLE "knjiznica_specijalov"(
 "id_knjiznice" Serial NOT NULL,
 "id_specijala" Integer,
 "id_uporabnika" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_specijali_knjiznica_specijalov" ON "knjiznica_specijalov" ("id_specijala");
CREATE INDEX "IX_uporabniki_knjiznica_specijalov" ON "knjiznica_specijalov" ("id_uporabnika");
ALTER TABLE "knjiznica_specijalov" ADD CONSTRAINT "PK_knjiznica_specijalov" PRIMARY KEY ("id_knjiznice");
ALTER TABLE "knjiznica_specijalov" ADD CONSTRAINT "id_knjiznice" UNIQUE ("id_knjiznice");
CREATE TABLE "komiki"(
 "id_komika" Serial NOT NULL,
 "potrjen_komik" Boolean,
 "id_uporabnika" Integer,
 "id_slike" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_uporabniki_komiki" ON "komiki" ("id_uporabnika");
CREATE INDEX "IX_slike_komiki" ON "komiki" ("id_slike");
ALTER TABLE "komiki" ADD CONSTRAINT "PK_komiki" PRIMARY KEY ("id_komika");
ALTER TABLE "komiki" ADD CONSTRAINT "id_komika" UNIQUE ("id_komika");
CREATE TABLE "specijali"(
 "id_specijala" Serial NOT NULL,
 "ime_specijala" Character varying(150),
 "trajanje_specijala" Integer,
 "brezplačno" Boolean,
 "cena" Numeric(8,2),
 "id_kategorije" Integer,
 "id_komika" Integer,
 "datum_objave" Date,
 "opis" Text,
 "id_slike" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_kategorije_specijali" ON "specijali" ("id_kategorije");
CREATE INDEX "IX_komiki_specijali" ON "specijali" ("id_komika");
CREATE INDEX "IX_slike_specijali" ON "specijali" ("id_slike");
ALTER TABLE "specijali" ADD CONSTRAINT "PK_specijali" PRIMARY KEY ("id_specijala");
ALTER TABLE "specijali" ADD CONSTRAINT "id_specijala" UNIQUE ("id_specijala");
CREATE TABLE "racuni"(
 "id_racuna" Serial NOT NULL,
 "stevilka" Integer,
 "datumcas" Timestamp,
 "id_osebe" Integer,
 "id_vrste_placila" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_osebe_racuni" ON "racuni" ("id_osebe");
CREATE INDEX "IX_vrste_placil_racuni" ON "racuni" ("id_vrste_placila");
ALTER TABLE "racuni" ADD CONSTRAINT "PK_racuni" PRIMARY KEY ("id_racuna");
ALTER TABLE "racuni" ADD CONSTRAINT "id_racuna" UNIQUE ("id_racuna");
CREATE TABLE "popusti"(
 "id_popusta" Serial NOT NULL,
 "popust" Character varying(80),
 "procent" Numeric(5,2),
 "datum_od" Timestamp,
 "datum_do" Timestamp
)
WITH (
 autovacuum_enabled=true);
ALTER TABLE "popusti" ADD CONSTRAINT "PK_popusti" PRIMARY KEY ("id_popusta");
ALTER TABLE "popusti" ADD CONSTRAINT "id_popusta" UNIQUE ("id_popusta");
CREATE TABLE "kategorije"(
 "id_kategorije" Serial NOT NULL,
 "ime_kategorije" Character varying(80)
)
WITH (
 autovacuum_enabled=true);
ALTER TABLE "kategorije" ADD CONSTRAINT "PK_kategorije" PRIMARY KEY ("id_kategorije");
ALTER TABLE "kategorije" ADD CONSTRAINT "id_kategorije" UNIQUE ("id_kategorije");
CREATE TABLE "vrste_placil"(
 "id_vrste_placila" Serial NOT NULL,
 "vrsta_placila" Character(80)
)
WITH (
 autovacuum_enabled=true);
ALTER TABLE "vrste_placil" ADD CONSTRAINT "PK_vrste_placil" PRIMARY KEY ("id_vrste_placila");
ALTER TABLE "vrste_placil" ADD CONSTRAINT "id_vrste_placila" UNIQUE ("id_vrste_placila");
CREATE TABLE "zasluzki"(
 "id_zasluzka" Serial NOT NULL,
 "neizplačeno" Numeric(5,2),
 "izplačeno" Numeric(5,2),
 "id_komika" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_komiki_zasluzki" ON "zasluzki" ("id_komika");
ALTER TABLE "zasluzki" ADD CONSTRAINT "PK_zasluzki" PRIMARY KEY ("id_zasluzka");
ALTER TABLE "zasluzki" ADD CONSTRAINT "id_zasluzka" UNIQUE ("id_zasluzka");
CREATE TABLE "ogledi"(
 "id_ogleda" Serial NOT NULL,
 "trajanje_ogleda" Integer,
 "datumcas_ogleda" Timestamp,
 "id_specijala" Integer,
 "id_uporabnika" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_specijali_ogledi" ON "ogledi" ("id_specijala");
CREATE INDEX "IX_uporabniki_ogledi" ON "ogledi" ("id_uporabnika");
ALTER TABLE "ogledi" ADD CONSTRAINT "PK_ogledi" PRIMARY KEY ("id_ogleda");
ALTER TABLE "ogledi" ADD CONSTRAINT "id_ogleda" UNIQUE ("id_ogleda");
CREATE TABLE "najljubsi"(
 "id_najljubsega" Serial NOT NULL,
 "id_uporabnika" Integer,
 "id_specijala" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_uporabniki_najljubsi" ON "najljubsi" ("id_uporabnika");
CREATE INDEX "IX_specijali_najljubsi" ON "najljubsi" ("id_specijala");
ALTER TABLE "najljubsi" ADD CONSTRAINT "PK_najljubsi" PRIMARY KEY ("id_najljubsega");
ALTER TABLE "najljubsi" ADD CONSTRAINT "id_najljubsega" UNIQUE ("id_najljubsega");
CREATE TABLE "traileri"(
 "id_trailerja" Serial NOT NULL,
 "trajanje_trailerja" Integer,
 "link_trailerja" Character varying(150),
 "id_specijala" Integer
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_specijali_traileri" ON "traileri" ("id_specijala");
ALTER TABLE "traileri" ADD CONSTRAINT "PK_traileri" PRIMARY KEY ("id_trailerja");
ALTER TABLE "traileri" ADD CONSTRAINT "id_trailerja" UNIQUE ("id_trailerja");
CREATE TABLE "slike"(
 "id_slike" Serial NOT NULL,
 "velkost_slike" Integer,
 "ime_slike" Character varying(50),
 "opis" Text
)
WITH (
 autovacuum_enabled=true);
ALTER TABLE "slike" ADD CONSTRAINT "PK_slike" PRIMARY KEY ("id_slike");
ALTER TABLE "slike" ADD CONSTRAINT "id_slike" UNIQUE ("id_slike");
CREATE TABLE "racuni_izdelki"(
 "id_racuni_izdelki" Serial NOT NULL,
 "id_racuna" Integer,
 "kolicina" Numeric(6,2) DEFAULT 1,
 "id_specijala" Integer,
 "popust" Numeric(5,2),
 "prodajna_cena" Numeric(8,2)
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_racuni_racuni_izdelki" ON "racuni_izdelki" ("id_racuna");
CREATE INDEX "IX_specijali_racuni_izdelki" ON "racuni_izdelki" ("id_specijala");
ALTER TABLE "racuni_izdelki" ADD CONSTRAINT "PK_racuni_izdelki" PRIMARY KEY ("id_racuni_izdelki");
ALTER TABLE "racuni_izdelki" ADD CONSTRAINT "id_racuna" UNIQUE ("id_racuni_izdelki");
CREATE TABLE "popusti_specijali"(
 "id_popusti_specijali" Serial NOT NULL,
 "id_popusta" Integer,
 "id_specijala" Integer,
 "popust" Numeric(5,2)
)
WITH (
 autovacuum_enabled=true);
CREATE INDEX "IX_popusti_popusti_specijali" ON "popusti_specijali" ("id_popusta");
CREATE INDEX "IX_specijali_popusti_specijali" ON "popusti_specijali" ("id_specijala");
ALTER TABLE "popusti_specijali" ADD CONSTRAINT "PK_popusti_specijali" PRIMARY KEY ("id_popusti_specijali");
ALTER TABLE "public"."postne_stevilke" ADD CONSTRAINT "drzave_postne_stevilke" FOREIGN KEY ("id_drzave") REFERENCES "public"."drzave" ("id_drzave") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "uporabniki" ADD CONSTRAINT "osebe_uporabniki" FOREIGN KEY ("id_osebe") REFERENCES "public"."osebe" ("id_osebe") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."osebe" ADD CONSTRAINT "drzave_osebe" FOREIGN KEY ("id_drzave") REFERENCES "public"."drzave" ("id_drzave") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."osebe" ADD CONSTRAINT "postne_stevilke_osebe" FOREIGN KEY ("id_postne_stevilke") REFERENCES "public"."postne_stevilke" ("id_postne_stevilke") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "knjiznica_specijalov" ADD CONSTRAINT "specijali_knjiznica_specijalov" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "specijali" ADD CONSTRAINT "kategorije_specijali" FOREIGN KEY ("id_kategorije") REFERENCES "kategorije" ("id_kategorije") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "zasluzki" ADD CONSTRAINT "komiki_zasluzki" FOREIGN KEY ("id_komika") REFERENCES "komiki" ("id_komika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "specijali" ADD CONSTRAINT "komiki_specijali" FOREIGN KEY ("id_komika") REFERENCES "komiki" ("id_komika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "komiki" ADD CONSTRAINT "uporabniki_komiki" FOREIGN KEY ("id_uporabnika") REFERENCES "uporabniki" ("id_uporabnika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "knjiznica_specijalov" ADD CONSTRAINT "uporabniki_knjiznica_specijalov" FOREIGN KEY ("id_uporabnika") REFERENCES "uporabniki" ("id_uporabnika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "racuni" ADD CONSTRAINT "osebe_racuni" FOREIGN KEY ("id_osebe") REFERENCES "public"."osebe" ("id_osebe") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "racuni" ADD CONSTRAINT "vrste_placil_racuni" FOREIGN KEY ("id_vrste_placila") REFERENCES "vrste_placil" ("id_vrste_placila") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "ogledi" ADD CONSTRAINT "specijali_ogledi" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "ogledi" ADD CONSTRAINT "uporabniki_ogledi" FOREIGN KEY ("id_uporabnika") REFERENCES "uporabniki" ("id_uporabnika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "najljubsi" ADD CONSTRAINT "uporabniki_najljubsi" FOREIGN KEY ("id_uporabnika") REFERENCES "uporabniki" ("id_uporabnika") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "najljubsi" ADD CONSTRAINT "specijali_najljubsi" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "specijali" ADD CONSTRAINT "slike_specijali" FOREIGN KEY ("id_slike") REFERENCES "slike" ("id_slike") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "komiki" ADD CONSTRAINT "slike_komiki" FOREIGN KEY ("id_slike") REFERENCES "slike" ("id_slike") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "traileri" ADD CONSTRAINT "specijali_traileri" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "racuni_izdelki" ADD CONSTRAINT "racuni_racuni_izdelki" FOREIGN KEY ("id_racuna") REFERENCES "racuni" ("id_racuna") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "racuni_izdelki" ADD CONSTRAINT "specijali_racuni_izdelki" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "popusti_specijali" ADD CONSTRAINT "popusti_popusti_specijali" FOREIGN KEY ("id_popusta") REFERENCES "popusti" ("id_popusta") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "popusti_specijali" ADD CONSTRAINT "specijali_popusti_specijali" FOREIGN KEY ("id_specijala") REFERENCES "specijali" ("id_specijala") ON DELETE NO ACTION ON UPDATE NO ACTION;