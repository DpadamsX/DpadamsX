---------------------------- bigint_non_negative--------------------------DROP DOMAIN IF EXISTS domains.bigint_non_negative;CREATE DOMAIN domains.bigint_non_negative AS	bigint	NOT NULL	CHECK (value >= 0);COMMENT ON DOMAIN domains.bigint_non_negative IS	'The number must be 0 or greater';