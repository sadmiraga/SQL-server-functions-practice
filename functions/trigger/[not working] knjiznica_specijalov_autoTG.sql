CREATE OR REPLACE FUNCTION knjiznica_specijalov_autoTG()
RETURNS TRIGGER AS $$
    DECLARE
        b_id_uporabnika integer;
        b_id_racuna integer;
        b_id_specijala integer;
        b_id_osebe integer;

    BEGIN

    b_id_specijala = new.id_specijala;

    b_id_racuna = new.id_racuna;

    --ID_OSEBE
    SELECT id_osebe INTO b_id_osebe
        FROM racuni
        WHERE id_racuna = b_id_racuna;

    --ID_UPORABNIKA
    SELECT id_uporabnika INTO b_id_uporabnika
        FROM uporabniki
        WHERE id_osebe = b_id_osebe;


        SELECT FROM knjiznica_specijalov_iu(null,b_id_specijala,b_id_uporabnika);

    end;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER knjiznica_racuni_TG
    AFTER INSERT
    ON racuni_izdelki FOR EACH ROW
    EXECUTE PROCEDURE knjiznica_specijalov_autoTG();