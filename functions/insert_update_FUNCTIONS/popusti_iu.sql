create or replace function popusti_iu(i_id_popusta integer,i_popust character varying, i_procent numeric(5,2),i_datum_od timestamp, i_datum_do timestamp)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN
        -- INSERT FUNCTION
        IF(i_id_popusta IS NULL ) THEN
            BEGIN
                kljuc = nextval('popusti_id_popusta_seq');

                INSERT INTO popusti (id_popusta,popust, procent, datum_od, datum_do)
                VALUES (kljuc,i_popust,i_procent,i_datum_od,i_datum_do);
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
            UPDATE popusti
            SET popust = i_popust,
                procent = i_procent,
                datum_od = i_datum_od,
                datum_do = i_datum_do
            WHERE id_popusta = i_id_popusta;
            kljuc = i_id_popusta;
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
SELECT * FROM popusti_iu(10,'testni',0.5,cast(current_timestamp as timestamp),cast(current_timestamp as timestamp))