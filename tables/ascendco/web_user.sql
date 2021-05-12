------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.web_user;
CREATE TABLE ascendco.web_user  (
	id uuid NOT NULL,
	marked_for_deletion bool NOT NULL DEFAULT false,
    is_sonar_ascendco_support bool NOT NULL DEFAULT false,
    data_file_id uuid NOT NULL,
	username extensions.citext COLLATE pg_catalog.default NOT NULL,
	role_ extensions.citext COLLATE pg_catalog.default NOT NULL,
	name_first extensions.citext COLLATE pg_catalog.default NOT NULL,
	name_last extensions.citext COLLATE pg_catalog.default NOT NULL,
	hsys_id uuid NOT NULL,
	name_full extensions.citext COLLATE pg_catalog.default NOT NULL
);

ALTER TABLE ascendco.web_user
	ADD CONSTRAINT web_user_id_pkey
	PRIMARY KEY (id);

ALTER TABLE ascendco.web_user
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------


------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_web_user_after_delete
	AFTER DELETE
	ON ascendco.web_user
	REFERENCING OLD TABLE AS deleted_rows
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();

CREATE TRIGGER trigger_web_user_before_truncate
	BEFORE TRUNCATE
	ON ascendco.web_user
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();