V podatkovni bazi atribut 'kolicina' sem imel narejen kot 'numeric(6,2)'

ALTER TABLE racuni_izdelki
DROP COLUMN kolicina;

ALTER TABLE racuni_izdelki
ADD COLUMN kolicina integer;

ker 
ALTER TABLE racuni_izdelki
ALTER COLUMN kolicina integer;

ni delovalo, jaz sem pa bil nazalost casovno omejen.