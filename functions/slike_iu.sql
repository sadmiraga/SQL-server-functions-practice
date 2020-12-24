create or replace function slike_iu(i_id_slike integer, i_velikost_slike integer,i_ime_slike character varying,i_opis character varying)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_slike IS NULL ) THEN
            BEGIN
                kljuc = nextval('slike_id_slike_seq');

                INSERT INTO slike (id_slike, velkost_slike, ime_slike, opis)
                VALUES (kljuc,i_velikost_slike,i_ime_slike,i_opis);
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
            UPDATE slike
            SET velkost_slike = i_velikost_slike,
                ime_slike = i_ime_slike,
                opis = i_opis
            WHERE id_slike = i_id_slike;

            kljuc = i_id_slike;

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


SELECT * FROM slike_iu(null,1024,'unforgiven.jpg','Unforgiven stand up special cover from Dave  Chappelle');

SELECT * FROM slike_iu(17,1024,'Unforgiven.jpg','2020 - Unforgiven stand up special cover from Dave  Chappelle');
