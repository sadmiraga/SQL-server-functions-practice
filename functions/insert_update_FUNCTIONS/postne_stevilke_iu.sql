create or replace function postne_stevilke_iu(i_id_postne_stevilke integer, i_postna_stevilka character varying, i_kraj_mesto character varying, i_id_drzave integer)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN
        -- INSERT FUNCTION
        IF(i_id_postne_stevilke IS NULL ) THEN
            BEGIN
                kljuc = nextval('postne_stevilke_id_postne_stevilke_seq');
                INSERT INTO postne_stevilke (id_postne_stevilke, postna_stevilka, kraj_mesto, id_drzave)
                VALUES (kljuc,i_postna_stevilka,i_kraj_mesto,i_id_drzave);
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
            UPDATE postne_stevilke
            SET postna_stevilka = i_postna_stevilka,
                kraj_mesto = i_kraj_mesto,
                id_drzave = i_id_drzave
            WHERE id_postne_stevilke = i_id_postne_stevilke;
            kljuc = i_id_postne_stevilke;
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
SELECT * FROM postne_stevilke_iu(null,'12345','Matuzici',2);
SELECT * FROM postne_stevilke_iu(11,'4321','donji Matuzici',2);