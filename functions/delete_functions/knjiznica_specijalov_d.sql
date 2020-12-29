CREATE OR REPLACE FUNCTION knjiznica_specijalov_d(i_id_knjiznice integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM knjiznica_specijalov
    WHERE id_knjiznice = i_id_knjiznice;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;