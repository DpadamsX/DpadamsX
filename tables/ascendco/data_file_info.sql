------------------------------------
-- Define table
------------------------------------
BEGIN;
 
DROP TABLE IF EXISTS ascendco.data_file_info CASCADE;
 
CREATE TABLE ascendco.data_file_info
(
    id uuid NOT NULL,
    last_updated_dts timestamptz NOT NULL DEFAULT now(),
    server_name_ citext NOT NULL DEFAULT NULL,
    app_name citext NOT NULL DEFAULT NULL,
    app_version citext NOT NULL DEFAULT NULL,
    shell_version citext NOT NULL DEFAULT NULL,
    sync_version citext NOT NULL DEFAULT NULL,
    iam_type citext NOT NULL DEFAULT NULL,
    compiled boolean NOT NULL DEFAULT false,
    merged boolean NOT NULL DEFAULT false,
    type_of_4d citext NOT NULL DEFAULT NULL,
    version_of_4d citext NOT NULL DEFAULT NULL,
    machine_name citext NOT NULL DEFAULT NULL,
    platform_description citext NOT NULL DEFAULT NULL,
    os_tz_name citext NOT NULL DEFAULT NULL,
    iam jsonb NOT NULL DEFAULT '{}'::jsonb,
    table_stats jsonb NOT NULL DEFAULT '{}'::jsonb     
);

ALTER TABLE ascendco.data_file_info
    ADD CONSTRAINT data_file_info_pkey
    PRIMARY KEY (id);

ALTER TABLE ascendco.data_file_info
	OWNER TO user_change_structure;
 
COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Not so much, don't have enough data for indexes to be useful. (The planner will ignore them anyway.)

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_data_file_info_after_delete
	AFTER DELETE
	ON ascendco.data_file_info
	REFERENCING OLD TABLE AS deleted_rows 
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();

CREATE TRIGGER trigger_data_file_info_before_truncate 
	BEFORE TRUNCATE
	ON ascendco.data_file_info
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();

CREATE TRIGGER trigger_data_file_info_before_update 
	BEFORE UPDATE
	ON ascendco.data_file_info
	FOR EACH ROW
	EXECUTE PROCEDURE ascendco.trigger_function_update_last_updated_dts();