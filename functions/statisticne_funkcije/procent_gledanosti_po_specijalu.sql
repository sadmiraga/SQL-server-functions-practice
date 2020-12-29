CREATE type v_procent as (
    ime_specijala character varying,
    procent_gledanosti numeric (8,2)
);



CREATE OR REPLACE FUNCTION procent_gledanosti_po_specijalu()
RETURNS SETOF v_procent AS
$$
DECLARE
    speijali_table specijali%ROWTYPE;
    ogledi_table ogledi%ROWTYPE;
    t_row v_procent;
    stevilo_ogledov integer;
    stevilo_odgledanih_minut numeric(8,2);
    procent_gledanosti numeric(8,2);
BEGIN
    FOR speijali_table IN SELECT * FROM specijali
    LOOP
        --get number of views
        SELECT COUNT(*) INTO stevilo_ogledov
        FROM ogledi
        WHERE id_specijala = speijali_table.id_specijala;
        --get all minutes watched
        SELECT SUM(trajanje_ogleda) INTO stevilo_odgledanih_minut
        FROM ogledi
        WHERE id_specijala = speijali_table.id_specijala;
        t_row.ime_specijala = speijali_table.ime_specijala;
        procent_gledanosti = stevilo_odgledanih_minut / (stevilo_ogledov * speijali_table.trajanje_specijala) *100;
        t_row.procent_gledanosti =  procent_gledanosti;
        RETURN NEXT t_row;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM procent_gledanosti_po_specijalu();


