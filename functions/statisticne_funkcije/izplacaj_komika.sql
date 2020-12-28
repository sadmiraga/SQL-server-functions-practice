
CREATE OR REPLACE FUNCTION izplacaj_komika(i_id_komika integer, vrednost_izplacila numeric(5,2))
RETURNS numeric(5,2) AS
$$
DECLARE
    trenutno_stanje numeric(5,2);
BEGIN

    SELECT neizplačeno INTO trenutno_stanje
    FROM zasluzki
    WHERE id_komika = i_id_komika;

    --preveriti ce komik ima toliko neizplacenih sredstv
    IF(vrednost_izplacila>trenutno_stanje) then
        begin
            return 0;
        end;
    else
        begin
            UPDATE zasluzki
            SET neizplačeno = neizplačeno - vrednost_izplacila,
                izplačeno = izplačeno + vrednost_izplacila
            WHERE id_komika = i_id_komika;


            return vrednost_izplacila;
        end;
    end if;

END;
$$ LANGUAGE plpgsql;

SELECT * FROM izplacaj_komika(5,10);




