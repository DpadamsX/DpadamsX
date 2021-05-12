------------------------------------
-- Define table
------------------------------------
-- What's with the crazy field order? Saving space. We rarely need this data, and there's a lot of it.
-- I'll set up a view with a more natural column order.
-- https://ascendco.atlassian.net/wiki/spaces/SON/pages/666501123/Arranging+Fields+to+Optimize+Disk+Space

BEGIN;

DROP TABLE IF EXISTS ascendco.assembly CASCADE;

CREATE TABLE IF NOT EXISTS ascendco.assembly (
	id uuid NOT NULL DEFAULT NULL,
	data_file_id uuid NOT NULL DEFAULT NULL,
	created_by_user_id uuid NOT NULL DEFAULT NULL,
	done_by_user_id uuid NOT NULL DEFAULT NULL,
	facility_location_id uuid NOT NULL DEFAULT NULL,
	inv_id uuid NOT NULL DEFAULT NULL,
	last_updated_by_data_file_id uuid NOT NULL DEFAULT NULL,
	updated_by_user_id uuid NOT NULL DEFAULT NULL,
	marked_for_deletion boolean NOT NULL DEFAULT false,
	is_complete boolean NOT NULL DEFAULT '0',
	is_quick_turn boolean NOT NULL DEFAULT '0',
	con_id integer NOT NULL DEFAULT 0,
	created_by citext NOT NULL DEFAULT NULL,
	difficulty integer NOT NULL DEFAULT 0,
	quantity integer NOT NULL DEFAULT 0,
	sequence_no integer NOT NULL DEFAULT 0,
	num_inst integer NOT NULL DEFAULT 0,
	points integer NOT NULL DEFAULT 0,
	done_dts timestamptz NOT NULL DEFAULT '-infinity',
	created_dts timestamptz NOT NULL DEFAULT '-infinity',
	updated_dts timestamptz NOT NULL DEFAULT '-infinity',
	missing_list citext NOT NULL DEFAULT NULL,
	priority citext NOT NULL DEFAULT NULL,
	production_ref citext NOT NULL DEFAULT '',
	status citext NOT NULL DEFAULT NULL,
	updated_by citext NOT NULL DEFAULT NULL
);

ALTER TABLE ascendco.assembly
	ADD CONSTRAINT assembly_id_pkey
    PRIMARY KEY (id);
    
ALTER TABLE ascendco.assembly
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Not adding many indexes. The id field gets a unique B-tree index by default since it's set as PRIMARY KEY.
-- We can define more indexes, when needed for queries.

------------------------------------
-- Add triggers
------------------------------------
CREATE TRIGGER trigger_assembly_after_delete 
	AFTER DELETE 
	ON ascendco.assembly
	REFERENCING OLD TABLE AS deleted_rows 
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();
	
CREATE TRIGGER trigger_assembly_before_truncate
	BEFORE TRUNCATE ON ascendco.assembly
	FOR EACH STATEMENT
	EXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();