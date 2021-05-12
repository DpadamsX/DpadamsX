-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS ascendco.push_log CASCADE;CREATE TABLE IF NOT EXISTS ascendco.push_log (	id uuid NOT NULL DEFAULT extensions.gen_random_uuid(),	push_dts timestamptz NOT NULL DEFAULT now(),	pushed_by text DEFAULT get_current_user(),	data_file_id uuid NOT NULL DEFAULT NULL,	ib_table_number integer NOT NULL DEFAULT 0,	ib_table_name citext NOT NULL DEFAULT NULL,	records_count integer NOT NULL DEFAULT 0);ALTER TABLE ascendco.push_log	ADD CONSTRAINT push_log_id_pkey    PRIMARY KEY (id);ALTER TABLE ascendco.push_log	OWNER TO user_change_structure;COMMIT;-------------------------------------- Build indexes------------------------------------CREATE INDEX push_log_data_file_id_ix_btree	ON ascendco.push_log	USING btree (data_file_id pg_catalog.uuid_ops ASC NULLS LAST);CREATE INDEX push_log_ib_table_name_ix_btree	ON ascendco.push_log	USING btree (ib_table_name COLLATE pg_catalog.default extensions.citext_ops ASC NULLS LAST);CREATE INDEX push_log_push_dts_ix_btree	ON ascendco.push_log	USING btree (push_dts pg_catalog.timestamptz_ops ASC NULLS LAST);-------------------------------------- Add triggers------------------------------------CREATE TRIGGER trigger_push_log_after_delete	AFTER DELETE	ON ascendco.push_log	REFERENCING OLD TABLE AS deleted_rows	FOR EACH STATEMENT	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();CREATE TRIGGER trigger_push_log_before_truncate	BEFORE TRUNCATE	ON ascendco.push_log	FOR EACH STATEMENT	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();