CREATE FUNCTION zasluzki_iu(i_id_zasluzka integer, i_neizplaceno integer, i_izplaceno integer, i_id_komika integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_zasluzka IS NULL ) THEN
       BEGIN
          kljuc=nextval('zasluzki_id_zasluzka_seq');
          INSERT INTO zasluzki (id_zasluzka, neizplačeno, izplačeno, id_komika)
          VALUES (kljuc,i_neizplaceno,i_izplaceno,i_id_komika);
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
           UPDATE zasluzki
           SET neizplačeno = i_neizplaceno,
               izplačeno =i_izplaceno,
               id_komika = i_id_komika
           WHERE id_zasluzka=i_id_zasluzka;
           kljuc=i_id_zasluzka;
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



SELECT FROM zasluzki_iu(null,0,0,1);

SELECT FROM zasluzki_iu(6,10,100,1);
