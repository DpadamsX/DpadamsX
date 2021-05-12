prin------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.error_code CASCADE;

CREATE TABLE ascendco.error_code
(
    errcode     citext  NOT NULL DEFAULT NULL,
    description citext  NOT NULL DEFAULT NULL
);

ALTER TABLE ascendco.error_code
    ADD CONSTRAINT error_code_pkey
    PRIMARY KEY (errcode);

ALTER TABLE ascendco.error_code
	OWNER TO user_change_structure;

COMMENT ON TABLE ascendco.error_code IS
	'Custom errcode definitions.';

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Not so much, don't have enough data for indexes to be useful. (The planner will ignore them anyway.)

------------------------------------
-- Add triggers
------------------------------------
-- Don't care about tracking deletes, etc.

------------------------------------
-- Manual Permissions for now
------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON error_code TO rds_super;
GRANT SELECT ON error_code TO user_reporting;
GRANT SELECT ON error_code TO user_iceberg;
GRANT SELECT ON error_code TO user_iceberg_remote;
GRANT SELECT ON error_code TO user_saws;
GRANT SELECT ON error_code TO user_sonar;
GRANT SELECT ON error_code TO user_leviathan;
GRANT SELECT ON error_code TO user_change_structure;

------------------------------------
-- Seed
------------------------------------
INSERT INTO ascendco.error_code (errcode, description)
     VALUES

     	 ('KC001','Patch has been run before.'),

     	 ('KC100','Bad string selector parameter value.'),
     	 ('KC101','Empty string parameter value.'),

     	 ('KC200', 'Numeric parameter value is too low.'),
     	 ('KC201', 'Numeric parameter value is too high.'),
     	 ('KC202', 'Numeric parameter value is out of range.'),

     	 ('KC300', 'Lookkup ID not found.'),

     	 ('KC400', 'From is later than to.'),
     	 ('KC401', 'Date range looks wrong.')


   ON CONFLICT(errcode) DO UPDATE
      SET description = EXCLUDED.description;
