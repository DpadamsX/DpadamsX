------------------------------------
-- Define table
------------------------------------
BEGIN;

DROP TABLE IF EXISTS ascendco.iceberg_table CASCADE;

CREATE TABLE ascendco.iceberg_table
(
    table_number int4 NOT NULL DEFAULT NULL,
    table_name citext NOT NULL DEFAULT NULL
);

ALTER TABLE ascendco.iceberg_table
    ADD CONSTRAINT iceberg_table_pkey
    PRIMARY KEY (table_number);

ALTER TABLE ascendco.iceberg_table
	OWNER TO user_change_structure;

COMMIT;

------------------------------------
-- Build indexes
------------------------------------
-- Not so much, don't have enough data for indexes to be useful. (The planner will ignore them anyway.)

------------------------------------
-- Add triggers
------------------------------------
-- Not needed, this is basically a static lookup table.

