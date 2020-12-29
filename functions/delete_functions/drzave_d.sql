CREATE OR REPLACE FUNCTION drzave_d(i_id_drzave integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM drzave
    WHERE id_drzave = i_id_drzave;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM drzave_d(18);