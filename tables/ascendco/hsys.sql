------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.hsys CASCADE;

CREATE TABLE IF NOT EXISTS ascendco.hsys (
	id uuid NOT NULL DEFAULT NULL,
	marked_for_deletion boolean NOT NULL DEFAULT false,
	name_ citext NOT NULL DEFAULT NULL,
	sonar_client_version citext NOT NULL DEFAULT '',
	sonar_server_version citext NOT NULL DEFAULT '',
	sonar_browser_version citext NOT NULL DEFAULT ''
);

ALTER TABLE ascendco.hsys
	ADD CONSTRAINT hsys_id_pkey
    PRIMARY KEY (id);

ALTER TABLE ascendco.hsys
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Nope. Postgres won't even bother with an index for searches on such a tiny table.
-- Note: You always need an index for a unique constraint. PG defines that automatically for the PRIMARY.

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_hsys_after_delete
	AFTER DELETE
	ON ascendco.hsys
	REFERENCING OLD TABLE AS deleted_rows
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();

CREATE TRIGGER trigger_hsys_before_truncate
	BEFORE TRUNCATE
	ON ascendco.hsys
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();

------------------------------------
-- GRANTS
------------------------------------
GRANT SELECT, UPDATE ON ascendco.hsys TO user_leviathan;
