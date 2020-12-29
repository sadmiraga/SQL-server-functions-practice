
CREATE OR REPLACE FUNCTION speciali_d(i_id_specijala integer) RETURNS INTEGER AS
$$
DECLARE
    izbrisane_vrstice integer;
BEGIN
    DELETE FROM specijali
    WHERE id_specijala = i_id_specijala;
    GET DIAGNOSTICS izbrisane_vrstice = ROW_COUNT;
    RETURN izbrisane_vrstice;
END;
$$ LANGUAGE plpgsql;


