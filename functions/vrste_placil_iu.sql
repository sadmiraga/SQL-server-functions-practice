create or replace function vrste_placil_iu(i_id_vrste_placila integer,i_vrsta_placila character varying)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_vrste_placila IS NULL ) THEN
            BEGIN
                kljuc = nextval('vrste_placil_id_vrste_placila_seq');

                INSERT INTO vrste_placil (id_vrste_placila, vrsta_placila)
                VALUES (kljuc,i_vrsta_placila);
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
            end;
        ELSE
            BEGIN
            --UPDATE function
            UPDATE vrste_placil
            SET vrsta_placila = i_vrsta_placila
            WHERE id_vrste_placila = i_id_vrste_placila;

            kljuc = i_id_vrste_placila;

            --exceptions
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

SELECT * FROM vrste_placil_iu(null,'mastercard');

SELECT * FROM vrste_placil_iu(16,'visa');
