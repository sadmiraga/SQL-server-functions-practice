create or replace function osebe_iu(i_id_osebe integer,i_ime character varying,i_priimek character varying, i_emso character varying (20),
                                    i_spol character varying(1),i_datum_rojstva date, i_naslov character varying (120),
                                    i_enaslov character varying,i_telefon character varying(20),
                                    i_davcna_stevilka character varying (15), i_id_drzave integer,
                                    i_id_postne_stevilke integer)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_osebe IS NULL ) THEN
            BEGIN
                kljuc = nextval('osebe_id_osebe_seq');

                INSERT INTO osebe (id_osebe, ime, priimek, emso, spol, datum_rojstva, naslov, enaslov, telefon, davcna_stevilka, id_drzave, id_postne_stevilke)
                VALUES (kljuc,i_ime,i_priimek,i_emso,i_spol,i_datum_rojstva,i_naslov,i_enaslov,i_telefon,i_davcna_stevilka,i_id_drzave,i_id_drzave);
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
            UPDATE osebe
            SET ime = i_ime,
                priimek = i_priimek,
                emso = i_emso,
                spol = i_spol,
                datum_rojstva = i_datum_rojstva,
                naslov = i_naslov,
                enaslov = i_enaslov,
                telefon = i_telefon,
                davcna_stevilka = i_davcna_stevilka,
                id_drzave = i_id_drzave,
                id_postne_stevilke = i_id_postne_stevilke
            WHERE id_osebe = i_id_osebe;

            kljuc = i_id_osebe;

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

SELECT * FROM osebe_iu (null,'Andrej','Skraba',
'12345677','M','20.02.200','Jenkova cesta 25',
'andrej@gmail.com','12345','1234567',2,2);

SELECT * FROM osebe_iu (26,'Andrej','Skrabar',
'1234567','M','12.12.2000','Jenkova cesta 25',
'andrej@gmail.com','12345','1234567',2,2);