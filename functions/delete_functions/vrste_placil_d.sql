CREATE OR REPLACE FUNCTION vrste_placil_d(i_id_vrste_placila integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM vrste_placil
    WHERE id_vrste_placila = i_id_vrste_placila;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;