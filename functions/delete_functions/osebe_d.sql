CREATE OR REPLACE FUNCTION osebe_d(i_id_osebe integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM osebe
    WHERE id_osebe = i_id_osebe;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;