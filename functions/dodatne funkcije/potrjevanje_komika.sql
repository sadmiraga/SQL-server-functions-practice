
create or replace function potrjevanje_komika(i_id_komika integer)
RETURNS integer as
    $$
    DECLARE kljuc integer;
    BEGIN

        UPDATE komiki
        SET potrjen_komik = true
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
     RETURN kljuc;
    END;
    $$ LANGUAGE plpgsql;

SELECT FROM potrjevanje_komika(12);