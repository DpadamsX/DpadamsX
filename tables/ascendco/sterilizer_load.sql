------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.sterilizer_load;
CREATE TABLE ascendco.sterilizer_load  (
	id uuid NOT NULL,
	data_file_id uuid NOT NULL,
	sterilize_method_id uuid NOT NULL,
	sterilize_params_id uuid NOT NULL,
	sterilizer_id uuid NOT NULL,
	created_dts timestamptz(6) NOT NULL DEFAULT '-infinity'::timestamp with time zone,
	status_building_dts timestamptz(6) NOT NULL DEFAULT '-infinity'::timestamp with time zone,
	status_sterilizing_dts timestamptz(6) NOT NULL DEFAULT '-infinity'::timestamp with time zone,
	status_cooling_dts timestamptz(6) NOT NULL DEFAULT '-infinity'::timestamp with time zone,
	status_done_dts timestamptz(6) NOT NULL DEFAULT '-infinity'::timestamp with time zone,
	utcoffset_seconds int4 NOT NULL DEFAULT 0,
	marked_for_deletion bool NOT NULL DEFAULT false,
	load_no extensions.citext COLLATE pg_catalog.default NOT NULL,
	notes extensions.citext COLLATE pg_catalog.default NOT NULL,
	failed_notes extensions.citext COLLATE pg_catalog.default NOT NULL
);

ALTER TABLE ascendco.sterilizer_load
	ADD CONSTRAINT sterilizer_load_id_pkey
	PRIMARY KEY (id);

ALTER TABLE ascendco.sterilizer_load
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_sterilizer_load_after_delete
	AFTER DELETE
	ON ascendco.sterilizer_load
	REFERENCING OLD TABLE AS deleted_rows
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();

CREATE TRIGGER trigger_sterilizer_load_before_truncate
	BEFORE TRUNCATE
	ON ascendco.sterilizer_load
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();