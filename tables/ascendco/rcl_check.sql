-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS ascendco.rcl_check;CREATE TABLE ascendco.rcl_check (	id uuid NOT NULL,	production int8,	leviathan int8);ALTER TABLE ascendco.rcl_check 	ADD CONSTRAINT rcl_check_pkey 	PRIMARY KEY (id);ALTER TABLE ascendco.rcl_check	OWNER TO user_change_structure;COMMIT;-------------------------------------- Build indexes-------------------------------------- Not at this time.-------------------------------------- Add triggers-------------------------------------- No triggers for this table.