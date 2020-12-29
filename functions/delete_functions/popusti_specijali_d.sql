CREATE OR REPLACE FUNCTION popusti_specijali_d(i_id_ps integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM popusti_specijali
    WHERE id_popusti_specijali = i_id_ps;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;