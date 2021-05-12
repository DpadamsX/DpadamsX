﻿-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS ascendco.assembly_prods CASCADE;CREATE TABLE IF NOT EXISTS ascendco.assembly_prods (    id                       uuid          NOT NULL DEFAULT NULL,    assembly_id              uuid          NOT NULL DEFAULT NULL,    item_prod_id             uuid          NOT NULL DEFAULT NULL,    created_dts              timestamp     NOT NULL DEFAULT 'epoch',    updated_dts              timestamp     NOT NULL DEFAULT 'epoch',    target                   integer       NOT NULL DEFAULT 0,    found_                   integer       NOT NULL DEFAULT 0,    repair                   integer       NOT NULL DEFAULT 0,    backup                   integer       NOT NULL DEFAULT 0,    actual                   integer       NOT NULL DEFAULT 0,    assembly_pos             integer       NOT NULL DEFAULT 0,    prev_actual_for_audit    integer       NOT NULL DEFAULT 0,    broken                   integer       NOT NULL DEFAULT 0,    marked_for_deletion      boolean       NOT NULL DEFAULT false,    created_by               citext        NOT NULL DEFAULT NULL,    updated_by               citext        NOT NULL DEFAULT NULL,    prod_alert_text_ack      citext        NOT NULL DEFAULT NULL,    audit_events             jsonb         NOT NULL DEFAULT '{}'::jsonb,    PRIMARY KEY (id, updated_dts)) PARTITION BY RANGE (updated_dts);ALTER TABLE ascendco.assembly_prods	OWNER TO user_change_structure;-------------------------------------- Build statistics------------------------------------/*The Postgres ANALYZE system function collects statistics about each table and column. These valuesare used by the query planner to help generate probabilistic cost estimates for various query plans.When the plans are based on misleading stats, you can have poor performance. Stats can be reconfiguredon a row-by-row basis, and some special extended statistics are supported too.Custom and extended statistics are typically added after we've been accumulating data for some time.See PgBuildStatistics_Extended in IB to declare new statistics objects. For more background, seehttps://ascendco.atlassian.net/wiki/spaces/SON/pages/1723695105/*/-------------------------------------- ANALYZE options-------------------------------------- Placholder and reminder for now. ANALYZE and AUTOVACUUM tunings are *core* Postgres DBA-- skills. But, for the minute, we're not running into trouble. I'm chipping away af figuring-- out when to tune, and how, and when not to tune. ‚Äî DPA-------------------------------------- Build indexes-------------------------------------- Note: Postgres automatically creates a UNIQUE B-tree for the PRIMARY KEY, simple or compound.-- Each partition (table) will include its own B-tree on assembly_id.-- The INCLUDE clause adds the marked_for_deletion field to the index,-- enabling a search to succeed with an index-only scan...'cause we're-- always discarding those soft-deleted rows.CREATE INDEX assembly_prods_assembly_id_covering_idx	ON assembly_prods (assembly_id)	INCLUDE (marked_for_deletion);/* Indexing trade-offs are different in 4D and Postgres.It pays to be a bit conservative about adding indexes in Postgres, wait and see what you need.CREATE INDEX assembly_prods_assembly_id_ix_btree          ON ascendco.assembly_prods       USING btree (assembly_id);CREATE INDEX assembly_prods_marked_for_deletion_ix_gin          ON ascendco.assembly_prods       USING GIN (marked_for_deletion extensions.bool_ops)       WHERE marked_for_deletion = true;*/-------------------------------------- Build partitions------------------------------------/*Using a function in the insert handler function to generate the partition_key,an int4 extract of yyyy-mm. From there, using a value list partitioning setup.Could use range partitions, but, in this case, list is a bit easier to follow.And, woah. First off, check this thread:https://stackoverflow.com/questions/66847389/partitioning-on-a-uuid-in-postgres-12-or-13Erwin Brandstetter is s total legend. If he says it, it's about 99.999999% likely to be true. Not an exaggeration.Okay, but a lot of rules:* You can't partition on a generated column.* You can't partition on an expression, and still have a PRIMARY KEY.* It sure seems like you need the partition key in the primary key. The definition above is as minimal as I could make it.So, to get this all to work, I'm populating updated_date in types_plus.insert_assembly_prods_v1(insert_assembly_prods_v1[]);Bit of a drag as that makes bulk import and manual entry pretty much impossible.Note on ranges:Ranges in Postgres partitions are [from, to), where [] indicates *inclusive* and () includes *exclusive*.Eh? As in "is the start/end value included in the range?" The behavior of [from, to) would liie this in anormal query >= From and < To. Notice < To, not <= To. For setting up patitions on dates, this is super convenient,as you don't have to get the ragged month end dates right, just specify the first day of the month after.This makes it easy to create gapless, non-overlapping ranges.Note that Postgres checks the partitions, and alerts you to overlaps. It does not mention gaps in lists...maybe not ranges either. That's what DEFAULT is for, and I've got a task to check that defaults are empty. If you want to visually inspect your definitions, start from here:select relkind,relname,pg_get_expr(c.relpartbound, c.oid, true)  from pg_class cwhere relname like 'assembly_prods%'  and relkind = 'r' -- 'r' = "ordinary tables". In this case, that's the partitions. The parent table is relkind of 'p'. order by relname*/-- 2015CREATE TABLE ascendco.assembly_prods_y2015 PARTITION OF assembly_prods    FOR VALUES FROM ('2015-01-01 00:00:00') TO ('2016-01-01 00:00:00'); -- Acts as "include dates from Jan 1, 2015 through December 31, 2015'.-- 2016CREATE TABLE ascendco.assembly_prods_y2016_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2016-01-01 00:00:00') TO ('2016-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2016_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2016-04-01 00:00:00') TO ('2016-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2016_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2016-07-01 00:00:00') TO ('2016-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2016_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2016-10-01 00:00:00') TO ('2017-01-01 00:00:00');-- 2017CREATE TABLE ascendco.assembly_prods_y2017_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2017-01-01 00:00:00') TO ('2017-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2017_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2017-04-01 00:00:00') TO ('2017-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2017_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2017-07-01 00:00:00') TO ('2017-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2017_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2017-10-01 00:00:00') TO ('2018-01-01 00:00:00');-- 2018CREATE TABLE ascendco.assembly_prods_y2018_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2018-01-01 00:00:00') TO ('2018-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2018_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2018-04-01 00:00:00') TO ('2018-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2018_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2018-07-01 00:00:00') TO ('2018-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2018_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2018-10-01 00:00:00') TO ('2019-01-01 00:00:00');-- 2019CREATE TABLE ascendco.assembly_prods_y2019_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2019-01-01 00:00:00') TO ('2019-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2019_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2019-04-01 00:00:00') TO ('2019-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2019_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2019-07-01 00:00:00') TO ('2019-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2019_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2019-10-01 00:00:00') TO ('2020-01-01 00:00:00');-- 2020CREATE TABLE ascendco.assembly_prods_y2020_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2020-01-01 00:00:00') TO ('2020-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2020_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2020-04-01 00:00:00') TO ('2020-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2020_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2020-07-01 00:00:00') TO ('2020-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2020_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2020-10-01 00:00:00') TO ('2021-01-01 00:00:00');-- 2021CREATE TABLE ascendco.assembly_prods_y2021_m010203 PARTITION OF assembly_prods    FOR VALUES FROM ('2021-01-01 00:00:00') TO ('2021-04-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2021_m040506 PARTITION OF assembly_prods    FOR VALUES FROM ('2021-04-01 00:00:00') TO ('2021-07-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2021_m070809 PARTITION OF assembly_prods    FOR VALUES FROM ('2021-07-01 00:00:00') TO ('2021-10-01 00:00:00');CREATE TABLE ascendco.assembly_prods_y2021_m101112 PARTITION OF assembly_prods    FOR VALUES FROM ('2021-10-01 00:00:00') TO ('2022-01-01 00:00:00');-- Default-- Need to add more partitions before the next year, or the'll spill into the default partition.-- See pgPartition_CheckDefaults for code we can use to automatically check for default-- partitions with unexpected records.CREATE TABLE ascendco.assembly_prods_default partition of assembly_prods DEFAULT;-------------------------------------- CLUSTER------------------------------------/*Code stub/reminder about CLUSTERing. Not a hard topic, but too big to write up here. Notes and links:https://ascendco.atlassian.net/wiki/spaces/SON/pages/356679683/ALTER TABLE ascendco.assembly_prods    CLUSTER ON ***index name to cluster by here.***;*/-------------------------------------- Add triggers------------------------------------   CREATE TRIGGER trigger_assembly_prods_after_delete            AFTER DELETE               ON ascendco.assembly_prods      REFERENCING OLD TABLE AS deleted_rows         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();  CREATE TRIGGER trigger_assembly_prods_before_truncate            BEFORE TRUNCATE               ON ascendco.assembly_prods         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();-------------------------------------- Manual Permissions for now-------------------------------------- Standard permissions for utility/admin users:GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.assembly_prods TO rds_super;GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.assembly_prods TO user_cleanup;GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.assembly_prods TO user_change_structure;GRANT SELECT ON ascendco.assembly_prods TO user_reporting;-- Adjustable user permissions:GRANT SELECT ON ascendco.assembly_prods TO user_iceberg;GRANT SELECT ON ascendco.assembly_prods TO user_iceberg_remote;GRANT SELECT ON ascendco.assembly_prods TO user_saws;GRANT SELECT, INSERT, UPDATE ON ascendco.assembly_prods TO user_sonar;GRANT SELECT ON ascendco.assembly_prods TO user_leviathan;COMMIT;