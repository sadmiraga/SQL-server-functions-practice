CREATE OR REPLACE FUNCTION traileri_d(i_id_trailera integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM traileri
    WHERE id_trailerja = i_id_trailera;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;