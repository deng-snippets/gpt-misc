CREATE TEMPORARY TABLE core.test_data (
  id serial primary key,
  name text
);

INSERT INTO core.test_data (name)
VALUES 
  (1, 'John Jr MD Phd '),
  (2, 'JohN! Jr  @md%phd '),
  (3, 'Jane'),
  (4, 'Mr. JaNe Sr. '),
  (5, 'John.jr.md.phd'),
  (6, 'John jr md'),
  (7, 'John md phd jr '),
  (8, 'John jr sr md phd'),
  (9, 'Srinivastan'),
  (10, 'Sri Nivas Tan');


CREATE OR REPLACE FUNCTION preprocess_column(text)
RETURNS text AS $$
DECLARE
  bad_suffixes text[] := array['jr', 'sr', 'md', 'phd'];
  suffix text;
BEGIN
  suffix := null;
  FOREACH suffix IN ARRAY bad_suffixes
  LOOP
    IF $1 ~ ('(\s+' || suffix || ')$') THEN
      $1 := regexp_replace($1, '(\s+' || suffix || ')$', '', 'g');
    END IF;
  END LOOP;
  RETURN regexp_replace(
    regexp_replace(
      regexp_replace(
        trim(both ' ' from lower(regexp_replace($1, '[^a-zA-Z\s]+', '', 'g')))
      ), 
      '\s+', ' ', 'g'
    ), 
    '(\s+(jr|sr|md|phd))$', '', 'g'
  );
END;
$$ LANGUAGE plpgsql;

SELECT name, preprocess_column(name) AS preprocessed_name
FROM test_data;
