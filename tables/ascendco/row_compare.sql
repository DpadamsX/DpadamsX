------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.row_compare;
CREATE TABLE ascendco.row_compare (
  id uuid NOT NULL,
  hash_1 int8,
  hash_2 int8,
  hashes_match bool,
  table_name text COLLATE pg_catalog.default NOT NULL
);

ALTER TABLE ascendco.row_compare
	ADD CONSTRAINT row_compare_pkey
	PRIMARY KEY (id, table_name);

ALTER TABLE ascendco.row_compare
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
CREATE INDEX row_compare_fail
	ON ascendco.row_compare
	USING btree ((hashes_match = false) pg_catalog.bool_ops ASC NULLS LAST);

------------------------------------
-- Trigger function
------------------------------------
-- Function defined here as the function isn't used elsewhere:
CREATE OR REPLACE FUNCTION ascendco.trigger_function_row_compare_upsert()
  RETURNS trigger AS
$BODY$
BEGIN
	IF  NEW.hash_1 = NULL OR
	    NEW.hash_2 = NULL THEN
	    RETURN NEW; -- Don't do the comparison, hash_1 hasn't been populated yet.

	ELSE-- Do the comparison. The point of this is to avoid constantly thrashing the expression index.
	   NEW.hashes_match := NEW.hash_1 = NEW.hash_2;
      RETURN NEW;     -- important!
   END IF;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

ALTER FUNCTION ascendco.trigger_function_row_compare_upsert
	OWNER TO user_bender;

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_row_compare_before_upsert
	BEFORE INSERT OR UPDATE
	ON ascendco.row_compare
	FOR EACH ROW
	EXECUTE PROCEDURE ascendco.trigger_function_row_compare_upsert();