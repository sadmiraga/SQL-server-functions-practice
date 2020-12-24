CREATE FUNCTION traileri_iu(i_id_trailerja integer,i_trajanje_trailerja integer,i_link_trailerja character varying,i_id_specijala integer)
RETURNS integer as
$$
DECLARE
    kljuc integer;
BEGIN
   IF (i_id_trailerja IS NULL ) THEN
       BEGIN
          kljuc=nextval('traileri_id_trailerja_seq');
          INSERT INTO traileri (id_trailerja, trajanje_trailerja, link_trailerja, id_specijala)
          VALUES (kljuc,i_trajanje_trailerja,i_link_trailerja,i_id_specijala);
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
       END;
   ELSE
       BEGIN
           UPDATE traileri
           SET trajanje_trailerja = i_trajanje_trailerja,
               link_trailerja = i_link_trailerja,
               id_specijala = i_id_specijala
           WHERE id_trailerja= i_id_trailerja;
           kljuc=i_id_trailerja;
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
       END;
   END IF;
   RETURN kljuc;
END;
$$ LANGUAGE plpgsql;

SELECT FROM traileri_iu(null,2,'https://www.youtube.com/watch?v=ZqTVSpJEicg',12);




SELECT FROM traileri_iu(12,2,'https://www.youtube.com/watch?v=GSGzW4MYcXU',12);
