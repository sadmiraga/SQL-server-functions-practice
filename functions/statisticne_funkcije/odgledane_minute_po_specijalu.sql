CREATE TYPE t_ogledi as (
    ime_specijala character varying,
    stevilo_odgledanih_minut integer
);


CREATE OR REPLACE FUNCTION odgledane_minute_po_specijalu()
RETURNS SETOF t_ogledi AS
$$
DECLARE
    speijali_table specijali%ROWTYPE;
    ogledi_table ogledi%ROWTYPE;
    t_row t_ogledi;
    stevilo_minut integer;
BEGIN
    FOR speijali_table IN SELECT * FROM specijali
    LOOP
        stevilo_minut = 0;
        t_row.ime_specijala = speijali_table.ime_specijala;

        FOR ogledi_table IN SELECT * FROM ogledi
        LOOP
            IF(ogledi_table.id_specijala = speijali_table.id_specijala) then
                stevilo_minut = stevilo_minut + ogledi_table.trajanje_ogleda;
            end if;
        end loop;

        t_row.stevilo_odgledanih_minut = stevilo_minut;


        RETURN NEXT t_row;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM odgledane_minute_po_specijalu();

