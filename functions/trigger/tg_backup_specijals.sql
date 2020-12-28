CREATE TABLE backup_specijalov
(
    id_specijala_backup serial not null constraint pk_backup_specijalov primary key,
    ime_specijala character varying,
    cena numeric (8,2),
    opis character varying
);


CREATE OR REPLACE FUNCTION tg_backup_specials ()
RETURNS TRIGGER AS
$$
BEGIN
   -- check operation
    IF (upper(tg_op) = 'INSERT') THEN -- INSERT
        INSERT INTO backup_specijalov (id_specijala_backup,ime_specijala, cena, opis)
            VALUES (new.id_specijala,new.ime_specijala,new.cena,new.opis);
    ELSIF (upper(tg_op) = 'UPDATE') THEN -- UPDATE
        UPDATE backup_specijalov
        SET ime_specijala = new.ime_specijala,
            cena = new.cena,
            opis = new.opis
        WHERE id_specijala_backup = old.id_specijala;
    ELSE -- DELETE
        DELETE FROM backup_specijalov WHERE id_specijala_backup = old.id_specijala;
    END IF;
   RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER tg_specijali
    AFTER INSERT OR UPDATE OR DELETE
    ON specijali FOR EACH ROW
    EXECUTE PROCEDURE tg_backup_specials();

SELECT FROM specijali_iu(null,'Kaligula',20,false,1,3,1,'20.02.200','kaligaugdfs',16);