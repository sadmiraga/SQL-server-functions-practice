CREATE OR REPLACE FUNCTION zaskuzki_d(i_id_zasluzka integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM zasluzki
    WHERE id_zasluzka = i_id_zasluzka;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;


