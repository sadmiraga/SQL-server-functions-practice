    create or replace function komiki_iu(i_id_komika integer,i_potrjen_komik boolean,i_id_uporabnika integer,i_id_slike integer)
    RETURNS integer as
    $$
    DECLARE
        kljuc integer;
    BEGIN

            --INSERT funckija
            IF(i_id_komika IS NULL) THEN
                BEGIN
                    kljuc = nextval('komiki_id_komika_seq');

                    INSERT INTO komiki (id_komika, potrjen_komik, id_uporabnika, id_slike)
                    VALUES (kljuc,i_potrjen_komik,i_id_uporabnika,i_id_slike);

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
            --UPDATE funckija
            ELSE
                BEGIN
                    UPDATE komiki
                    SET potrjen_komik = i_potrjen_komik,
                        id_uporabnika = i_id_uporabnika,
                        id_slike = i_id_slike
                    WHERE id_komika = i_id_komika;
                    kljuc = i_id_komika;

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
            end if;

    RETURN kljuc;

    END;
    $$ LANGUAGE plpgsql;

SELECT FROM komiki_iu(null,false,16,1);


SELECT FROM komiki_iu(11,true,1,1);