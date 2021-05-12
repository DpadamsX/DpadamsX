------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.focus CASCADE;

CREATE TABLE IF NOT EXISTS ascendco.focus (
	scase_id uuid NOT NULL DEFAULT NULL,
	hsys_id uuid NOT NULL DEFAULT NULL,
	facility_id uuid NOT NULL DEFAULT NULL,
	sched_dts timestamp NOT NULL DEFAULT TIMESTAMP 'epoch',
	facility_name citext NOT NULL DEFAULT NULL,
	or_name citext NOT NULL DEFAULT NULL,
	case_seq citext NOT NULL DEFAULT NULL,
	desc_ citext NOT NULL DEFAULT NULL,
	status citext NOT NULL DEFAULT NULL,
	transport_from citext NOT NULL DEFAULT NULL,
	surgeon_name citext NOT NULL DEFAULT NULL,
	proc_name citext NOT NULL DEFAULT NULL,
	when_ citext NOT NULL DEFAULT NULL,

CONSTRAINT focus_id_pkey
    PRIMARY KEY (scase_id)
);


ALTER TABLE ascendco.focus
	OWNER TO user_change_structure;

COMMIT;


------------------------------------
-- Build indexes
------------------------------------
CREATE INDEX focus_hsys_id_ix_btree
	ON ascendco.focus
	USING btree (hsys_id pg_catalog.uuid_ops ASC NULLS LAST);
	
CREATE INDEX focus_facility_id_ix_btree
	ON ascendco.focus
	USING btree (facility_id pg_catalog.uuid_ops ASC NULLS LAST);

------------------------------------
-- Add triggers
------------------------------------
-- None at the moment.