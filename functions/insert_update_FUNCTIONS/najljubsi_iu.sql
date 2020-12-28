CREATE FUNCTION najljubsi_iu(i_id_najljubsega integer, i_id_uporabnika integer,i_id_specijala integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_najljubsega IS NULL ) THEN
       BEGIN
          kljuc=nextval('najljubsi_id_najljubsega_seq');
          INSERT INTO najljubsi (id_najljubsega, id_uporabnika, id_specijala)
          VALUES (kljuc,i_id_uporabnika,i_id_specijala);
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
           UPDATE najljubsi
           SET id_uporabnika = i_id_uporabnika,
               id_specijala = i_id_specijala
           WHERE id_najljubsega = i_id_najljubsega;
           kljuc=i_id_najljubsega;
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
SELECT FROM najljubsi_iu(null,15,12);
SELECT FROM najljubsi_iu(13,15,10);