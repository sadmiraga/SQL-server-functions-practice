create type t_drzave as(
    ime_drzave character varying,
    procent_oseb numeric (5,2)
);

create or replace function procent_oseb_po_drzav()
RETURNS SETOF t_drzave AS
$$
DECLARE
    t_row t_drzave;
    drzave_table drzave%ROWTYPE;
    vse_osebe numeric(5,2);
    drzava_osebe numeric(5,2);
BEGIN

    SELECT COUNT(*) INTO vse_osebe
    FROM osebe;
    FOR drzave_table IN SELECT * FROM drzave
    LOOP
        t_row.ime_drzave = drzave_table.drzava;
        SELECT COUNT(*) INTO drzava_osebe
        FROM osebe
        WHERE id_drzave = drzave_table.id_drzave;
        t_row.procent_oseb = drzava_osebe / vse_osebe *100;
        RETURN NEXT t_row;
    end loop;
end;
$$ LANGUAGE plpgsql;

SELECT * FROM procent_oseb_po_drzav();

