CREATE TYPE s_zasluzki as (
    ime_specijala character varying,
    zasluzek numeric (8,2)
);


CREATE OR REPLACE FUNCTION zasluzki_po_specijalu()
RETURNS SETOF s_zasluzki AS
$$
DECLARE
    speijali_table specijali%ROWTYPE;
    t_row s_zasluzki;
    stevilo_prodanih integer;
BEGIN
    FOR speijali_table IN SELECT * FROM specijali
    LOOP
        t_row.ime_specijala = speijali_table.ime_specijala;

        --get vrednost
        SELECT COUNT(*) INTO stevilo_prodanih
        FROM racuni_izdelki
        WHERE id_specijala = speijali_table.id_specijala;

        t_row.zasluzek = stevilo_prodanih * speijali_table.cena;
        RETURN NEXT t_row;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


--klic funckije 
SELECT * from zasluzki_po_specijalu();