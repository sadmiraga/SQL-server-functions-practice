CREATE OR REPLACE FUNCTION uporabniki_d(i_id_uporabnika integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM uporabniki
    WHERE id_uporabnika = i_id_uporabnika;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;
