CREATE OR REPLACE FUNCTION najljubsi_d(i_id_najljubsega integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM najljubsi
    WHERE id_najljubsega = i_id_najljubsega;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;