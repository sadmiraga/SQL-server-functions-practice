create or replace function kategorije_iu(i_id_kategorije integer, i_ime_kategorije character varying)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_kategorije IS NULL ) THEN
            BEGIN
                kljuc = nextval('kategorije_id_kategorije_seq');

                INSERT INTO kategorije (id_kategorije, ime_kategorije)
                VALUES (kljuc,i_ime_kategorije);
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
            UPDATE kategorije
            SET ime_kategorije = i_ime_kategorije
            WHERE id_kategorije = i_id_kategorije;

            kljuc = i_id_kategorije;

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

SELECT * FROM kategorije_iu(null,'puns');

INSERT INTO kategorije (id_kategorije, ime_kategorije)
                VALUES (20,'Pun Comedians');



