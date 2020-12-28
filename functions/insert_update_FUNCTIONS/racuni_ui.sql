create or replace function racuni_ui (i_id_racuna integer,i_stevilka integer,i_datumcas timestamp,
i_id_osebe integer,i_id_vrste_placila integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
    --check if id_racuna is passed
    IF (i_id_racuna IS NULL) THEN
        BEGIN
            kljuc = nextval('racuni_id_racuna_seq');
            INSERT INTO racuni (id_racuna, stevilka, datumcas, id_osebe, id_vrste_placila)
                        VALUES (kljuc,i_stevilka,i_datumcas,i_id_osebe,i_id_vrste_placila);
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
            UPDATE racuni
            SET stevilka = i_stevilka,
                datumcas = i_datumcas,
                id_osebe = i_id_osebe,
                id_vrste_placila = i_id_vrste_placila
            WHERE id_racuna = i_id_racuna;
                kljuc = i_id_racuna;
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
return kljuc;
END; --end of function
$$ LANGUAGE plpgsql;
--insert
SELECT * FROM racuni_ui(null,12343,cast(current_timestamp as timestamp),25,2);
SELECT * FROM racuni_ui(null,54321,cast(current_timestamp as timestamp),25,10);
--update
SELECT * FROM racuni_ui(1,54321,cast(current_timestamp as timestamp),23,2);