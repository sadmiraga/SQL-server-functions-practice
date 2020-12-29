CREATE OR REPLACE FUNCTION racuni_izdelki_d(i_id_racuna_izdelka integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM racuni_izdelki
    WHERE id_racuni_izdelki = i_id_racuna_izdelka;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;
