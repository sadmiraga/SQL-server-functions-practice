CREATE OR REPLACE FUNCTION postne_stevilke_d(i_id_postne_stevilke integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM postne_stevilke
    WHERE id_postne_stevilke = i_id_postne_stevilke;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;