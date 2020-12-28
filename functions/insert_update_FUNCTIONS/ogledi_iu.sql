CREATE FUNCTION ogledi_iu(i_id_ogleda integer, i_trajanje_ogleda integer, i_datumcas_ogleda timestamp,
i_id_specijala integer, i_id_uporabnika integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_ogleda IS NULL ) THEN
       BEGIN
          kljuc=nextval('ogledi_id_ogleda_seq');
          INSERT INTO ogledi (id_ogleda, trajanje_ogleda, datumcas_ogleda, id_specijala, id_uporabnika)
          VALUES (kljuc,i_trajanje_ogleda,i_datumcas_ogleda,i_id_specijala,i_id_uporabnika);
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
           UPDATE ogledi
           SET trajanje_ogleda = i_trajanje_ogleda,
               datumcas_ogleda = i_datumcas_ogleda,
               id_specijala = i_id_specijala,
               id_uporabnika = i_id_uporabnika
           WHERE id_ogleda = i_id_ogleda;

           kljuc=i_id_ogleda;
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
SELECT FROM ogledi_iu(null,2,cast(current_timestamp as timestamp),12,15);
SELECT FROM ogledi_iu(1,20,cast(current_timestamp as timestamp),12,15);