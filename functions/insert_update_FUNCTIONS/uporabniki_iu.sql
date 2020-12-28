create or replace function uporabniki_iu(i_id_uporabnika integer,i_uporabnisko_ime character varying, i_geslo character varying,
                                            i_datum_registracije date, i_id_osebe integer)
RETURNS integer as
$$
    DECLARE
        kljuc integer;
BEGIN

        -- INSERT FUNCTION
        IF(i_id_uporabnika IS NULL ) THEN
            BEGIN
                kljuc = nextval('uporabniki_id_uporabnika_seq');

                INSERT INTO uporabniki (id_uporabnika, uporabnisko_ime, geslo, datum_registracije, id_osebe)
                VALUES (kljuc,i_uporabnisko_ime,i_geslo,i_datum_registracije,i_id_osebe);
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
            UPDATE uporabniki
            SET uporabnisko_ime = i_uporabnisko_ime,
                geslo = i_geslo,
                datum_registracije = i_datum_registracije
            WHERE i_id_uporabnika = i_id_uporabnika;

            kljuc = i_id_uporabnika;

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

SELECT * FROM uporabniki_iu(null,'skrabaKiller2','skraba123','01.01.2020',26);

SELECT * FROM uporabniki_iu(13,'skraba Komik','fultezjegeslo','01.01.2020',26);
