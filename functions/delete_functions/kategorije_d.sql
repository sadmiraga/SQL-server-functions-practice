CREATE OR REPLACE FUNCTION kategorije_d(i_id_kategorije integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM kategorije
    WHERE id_kategorije = i_id_kategorije;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;