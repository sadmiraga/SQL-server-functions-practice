create or replace function drzave_iu(i_id_drzave integer, i_drzava character varying, i_oznaka_drzave character varying(3))
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_drzave IS NULL ) THEN
            BEGIN
                kljuc = nextval('drzave_id_drzave_seq');

                INSERT INTO drzave (id_drzave,drzava, oznaka_drzave)
                VALUES (kljuc,i_drzava,i_oznaka_drzave);
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
            UPDATE drzave
            SET drzava = i_drzava,
                oznaka_drzave = i_oznaka_drzave
            WHERE id_drzave = i_id_drzave;

            kljuc = i_id_drzave;

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


SELECT * FROM drzave_iu(null,'Madjarska','MDR');

SELECT * FROM drzave_iu(11,'Madarska','MD');