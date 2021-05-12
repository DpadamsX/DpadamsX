------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.rcl_id;
CREATE TABLE ascendco.rcl_id (
	id uuid NOT NULL,
	source extensions.citext COLLATE pg_catalog.default NOT NULL
);

ALTER TABLE ascendco.rcl_id 
	ADD CONSTRAINT rcl_id_pkey 
	PRIMARY KEY (id, source);

ALTER TABLE ascendco.rcl_id
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Not at this time.

------------------------------------
-- Add triggers
------------------------------------
-- No triggers for this table.