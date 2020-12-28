-- statisticna funkcija ki posodobi podatke o zasluzku od posamenega komika

CREATE OR REPLACE FUNCTION tg_prodaj_specijal()
RETURNS TRIGGER AS $$
    DECLARE
        b_id_specijala integer;
        b_id_komika integer;
        b_cena numeric(8,2);
        b_izplacaj numeric(8,2);
    BEGIN

    SELECT cena INTO b_cena
        FROM specijali
        WHERE id_specijala = new.id_specijala;

    b_cena = b_cena - (b_cena * new.popust);

    b_izplacaj = b_cena - (b_cena * 0.1);

    SELECT id_komika INTO b_id_komika
        FROM specijali
        WHERE specijali.id_specijala = new.id_specijala;

    UPDATE zasluzki
        SET neizplačeno = neizplačeno + b_izplacaj
        WHERE id_komika = b_id_komika;


    end;
    $$ LANGUAGE plpgsql;

CREATE TRIGGER prodaj_specijal_tg
    AFTER INSERT
    ON racuni_izdelki FOR EACH ROW
    EXECUTE PROCEDURE tg_prodaj_specijal();

