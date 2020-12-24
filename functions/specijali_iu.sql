CREATE FUNCTION specijali_iu(i_id_specijala integer,i_ime_specijala character varying (150),i_trajanje_specijala integer,
                            i_brezplacno boolean, i_cena numeric(8,2),i_id_kategorije integer,i_id_komika integer,
                            i_datum_objave date,i_opis character varying (150),i_id_slike integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_specijala IS NULL ) THEN
       BEGIN
          kljuc=nextval('specijali_id_specijala_seq');
          INSERT INTO specijali (id_specijala, ime_specijala, trajanje_specijala, brezplačno, cena, id_kategorije, id_komika, datum_objave, opis, id_slike)
          VALUES (kljuc,i_ime_specijala, i_trajanje_specijala, i_brezplacno, i_cena, i_id_kategorije, i_id_komika, i_datum_objave, i_opis, i_id_slike);
          EXCEPTION
                WHEN integrity_constraint_violation THEN
                    RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
                WHEN not_null_violation THEN
                    RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
                WHEN foreign_key_violation THEN
                    RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
                WHEN unique_violation THEN
                    RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
                WHEN check_violation THEN
                    RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
                WHEN others THEN
                    RAISE EXCEPTION 'Napaka ...';
       END;
   ELSE
       BEGIN
           UPDATE specijali
           SET ime_specijala = i_ime_specijala,
               trajanje_specijala = i_trajanje_specijala,
               brezplačno = i_brezplacno,
               cena= i_cena,
               id_kategorije= i_id_kategorije,
               id_komika = i_id_komika,
               datum_objave = i_datum_objave,
               opis = i_opis,
               id_slike = i_id_slike
           WHERE id_specijala=i_id_specijala;
           kljuc=i_id_specijala;
           EXCEPTION
                WHEN integrity_constraint_violation THEN
                    RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
                WHEN not_null_violation THEN
                    RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
                WHEN foreign_key_violation THEN
                    RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
                WHEN unique_violation THEN
                    RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
                WHEN check_violation THEN
                    RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
                WHEN others THEN
                    RAISE EXCEPTION 'Napaka ...';
       END;
   END IF;
   RETURN kljuc;
END;
$$ LANGUAGE plpgsql;



SELECT FROM specijali_iu(null,'Unforgiven',55,false,10,1,1,'24.12.2020','Dugo ocekivani specijal od DaveChappella koji ce vas smijehom sigurno obiriti sa nogu',17);

SELECT FROM specijali_iu(12,'Unforgiven 2',55,false,15,1,1,'24.12.2020','Dugo ocekivani specijal od DaveChappella koji ce vas smijehom sigurno obiriti sa nogu',17);
