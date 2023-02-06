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