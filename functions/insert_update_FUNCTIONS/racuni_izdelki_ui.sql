create or replace function racuni_izdelki (i_id_racuni_izdelki integer,i_id_racuna integer,i_id_specijala integer,
i_kolicina integer)
RETURNS integer as
$$

DECLARE kljuc integer;
        cenaSpecijala numeric(8,2);
        id_popusta_help integer;
        vrednost_popusta numeric(5,2);
        prodajnaCenaRacuna numeric(8,2);
        preveriPopust integer;

    --postoji mogucnost da cena vrijednost null

BEGIN

    --get data about special
    SELECT cena
    INTO cenaSpecijala
    FROM specijali
    WHERE id_specijala = i_id_specijala;

    --check if INSERT or UPDATE
    IF (i_id_racuni_izdelki IS NULL) THEN
        --INSERT
        BEGIN
                --check if sepcial is free
                IF (cenaSpecijala IS NULL) THEN
                    BEGIN
                        prodajnaCenaRacuna = 0;
                    end;
                ELSE
                    begin

                        --preveri ce obstaja popust za ta specijal
                        SELECT COUNT (id_popusti_specijali)
                        INTO preveriPopust
                        FROM popusti_specijali
                        WHERE id_specijala = i_id_specijala;


                        IF(preveriPopust > 0) THEN
                            begin
                                --get popust value with id_popusta
                                SELECT procent
                                INTO vrednost_popusta
                                FROM popusti
                                WHERE id_popusta = id_popusta_help;

                                prodajnaCenaRacuna = cenaSpecijala * i_kolicina;
                                prodajnaCenaRacuna = prodajnaCenaRacuna - (prodajnaCenaRacuna * vrednost_popusta);
                            end;
                        else
                            begin
                                vrednost_popusta = 0;
                                prodajnaCenaRacuna = cenaSpecijala * i_kolicina;
                            end;
                        end if;


                    end;
                end if;

            kljuc = nextval('racuni_izdelki_id_racuni_izdelki_seq');

            INSERT INTO racuni_izdelki(id_racuni_izdelki,id_racuna, id_specijala, popust, prodajna_cena, kolicina)
            VALUES (kljuc,i_id_racuna,i_id_specijala,vrednost_popusta,prodajnaCenaRacuna,i_kolicina);
            return kljuc;

                        --catach exceptions
            EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';



        end;
    ELSE
        BEGIN
            kljuc = i_id_racuni_izdelki;
            --execute UPDATE
            --edina vrednost ki je logicna da se lahko spreminja je id_racuna
            UPDATE racuni_izdelki
            SET id_racuna = i_id_racuna
            WHERE id_racuni_izdelki = i_id_racuni_izdelki;

            --catach exceptions
            EXCEPTION
            WHEN integrity_constraint_violation THEN
                RAISE EXCEPTION 'Napaka ... referenčna integriteta.';
            WHEN not_null_violation THEN
                RAISE EXCEPTION 'Napaka ... ni zahtevane vrednosti polja.';
            WHEN foreign_key_violation THEN
                RAISE EXCEPTION 'Napaka ... neustrezna vrednost tujega ključa.';
            WHEN unique_violation THEN
                RAISE EXCEPTION 'Napaka ... ni enolične vrednosti polja.';
            WHEN check_violation THEN
                RAISE EXCEPTION 'Napaka ... validacijsko pravilo.';
            WHEN others THEN
                RAISE EXCEPTION 'Napaka ...';

        end;
    END IF;


return kljuc;
END
$$ LANGUAGE plpgsql;


--insert
SELECT * FROM racuni_izdelki(null,1,10,2);


--update
SELECT * FROM racuni_izdelki (2,1,5,2);