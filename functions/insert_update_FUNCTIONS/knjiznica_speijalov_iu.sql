CREATE FUNCTION knjiznica_specijalov_iu(i_id_knjiznice_specijalov integer,i_id_specijala integer,i_id_uporabnika integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_knjiznice_specijalov IS NULL ) THEN
       BEGIN
          kljuc=nextval('knjiznica_specijalov_id_knjiznice_seq');
          INSERT INTO knjiznica_specijalov (id_knjiznice, id_specijala, id_uporabnika)
          VALUES (kljuc,i_id_specijala,i_id_uporabnika);
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
           UPDATE knjiznica_specijalov
           SET id_specijala = i_id_specijala,
               id_uporabnika = i_id_uporabnika
           WHERE id_knjiznice = i_id_knjiznice_specijalov;
           kljuc=i_id_knjiznice_specijalov;
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
SELECT FROM knjiznica_specijalov_iu(null,12,15);
SELECT FROM knjiznica_specijalov_iu(1,1,15);