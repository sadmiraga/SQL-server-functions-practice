create or replace function popusti_specijali_ui(i_id_popusta integer, i_id_specijala integer)
RETURNS boolean as
$$
BEGIN
    --insert into popusti_specijali
    INSERT INTO popusti_specijali (id_popusta, id_specijala, popust)
    VALUES (i_id_popusta,i_id_specijala,(SELECT procent FROM popusti WHERE popusti.id_popusta=i_id_popusta));
    return true;
END
$$ LANGUAGE plpgsql;

--klic funkcije
SELECT * FROM popusti_specijali_ui(5,5);