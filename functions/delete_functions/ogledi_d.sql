CREATE OR REPLACE FUNCTION ogledi_d(i_id_ogleda integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM ogledi
    WHERE id_ogleda = i_id_ogleda;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;