------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.analytic_sterilizer_loadinv CASCADE;

CREATE TABLE IF NOT EXISTS ascendco.analytic_sterilizer_loadinv (
	id uuid NOT NULL DEFAULT NULL,
	data_file_id uuid NOT NULL DEFAULT NULL,
	marked_for_deletion boolean NOT NULL DEFAULT false,
	facility_id uuid NOT NULL DEFAULT NULL,
	hsys_id uuid NOT NULL DEFAULT NULL,
	inv_id uuid NOT NULL DEFAULT NULL,
	item_id uuid NOT NULL DEFAULT NULL,
	item_type_id uuid NOT NULL DEFAULT NULL,
	speciality_id uuid NOT NULL DEFAULT NULL,
	sterilize_method_id uuid NOT NULL DEFAULT NULL,
	sterilize_params_id uuid NOT NULL DEFAULT NULL,
	sterilizer_id uuid NOT NULL DEFAULT NULL,
	sterilizerload_id uuid NOT NULL DEFAULT NULL,

	web_user_id uuid NOT NULL DEFAULT NULL,
	inv_name_provided citext NOT NULL DEFAULT NULL,
	is_iuss boolean NOT NULL DEFAULT '0',
	num_inst integer NOT NULL DEFAULT 0,
	qty integer NOT NULL DEFAULT 0,
	category citext NOT NULL DEFAULT NULL,
	clinic_dept_name citext NOT NULL DEFAULT NULL,
	processing_seconds integer NOT NULL DEFAULT 0,
	done_dts timestamptz NOT NULL DEFAULT '-infinity',
	done_local_dts timestamptz NOT NULL DEFAULT '-infinity',
	status citext NOT NULL DEFAULT NULL

);

ALTER TABLE ascendco.analytic_sterilizer_loadinv
	ADD CONSTRAINT analytic_sterilizer_loadinv_id_pkey
    PRIMARY KEY (id);

ALTER TABLE ascendco.analytic_sterilizer_loadinv
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
CREATE INDEX analytic_sterilizer_loadinv_facility_id_ix_btree
	ON ascendco.analytic_sterilizer_loadinv
	USING btree(facility_id pg_catalog.uuid_ops ASC NULLS LAST);

CREATE INDEX analytic_sterilizer_loadinv_item_type_id_ix_btree
	ON ascendco.analytic_sterilizer_loadinv
	USING btree(item_type_id pg_catalog.uuid_ops ASC NULLS LAST);

CREATE INDEX analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin
	ON ascendco.analytic_sterilizer_loadinv
	USING gin(marked_for_deletion extensions.bool_ops)
	WHERE marked_for_deletion = true;

CREATE INDEX analytic_sterilizer_loadinv_sterilize_params_id_ix_btree
	ON ascendco.analytic_sterilizer_loadinv
	USING btree(sterilize_params_id pg_catalog.uuid_ops ASC NULLS LAST);

CREATE INDEX analytic_sterilizer_loadinv_sterilizer_id_ix_btree
	ON ascendco.analytic_sterilizer_loadinv
	USING btree(sterilizer_id pg_catalog.uuid_ops ASC NULLS LAST);

CREATE INDEX analytic_sterilizer_loadinv_web_user_id_ix_btree
	ON ascendco.analytic_sterilizer_loadinv
	USING btree(web_user_id pg_catalog.uuid_ops ASC NULLS LAST);

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_analytic_sterilizer_loadinv_after_delete
	AFTER DELETE
	ON ascendco.analytic_sterilizer_loadinv
	REFERENCING OLD TABLE AS deleted_rows
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();

CREATE TRIGGER trigger_analytic_sterilizer_loadinv_before_truncate
	BEFORE TRUNCATE
	ON ascendco.analytic_sterilizer_loadinv
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();