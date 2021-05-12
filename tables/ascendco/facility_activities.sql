﻿-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS ascendco.facility_activities CASCADE;CREATE TABLE IF NOT EXISTS ascendco.facility_activities (    id                              uuid          NOT NULL DEFAULT NULL PRIMARY KEY,    facility_id                     uuid          NOT NULL DEFAULT NULL,    last_updated_by_data_file_id    uuid          NOT NULL DEFAULT NULL,    created_dts                     timestamp     NOT NULL DEFAULT 'epoch',    updated_dts                     timestamp     NOT NULL DEFAULT 'epoch',    marked_for_deletion             boolean       NOT NULL DEFAULT false,    name_                           citext        NOT NULL DEFAULT NULL,    created_by                      citext        NOT NULL DEFAULT NULL,    updated_by                      citext        NOT NULL DEFAULT NULL);ALTER TABLE ascendco.facility_activities	OWNER TO user_change_structure;-------------------------------------- Build statistics------------------------------------/*The Postgres ANALYZE system function collects statistics about each table and column. These valuesare used by the query planner to help generate probabilistic cost estimates for various query plans.When the plans are based on misleading stats, you can have poor performance. Stats can be reconfiguredon a row-by-row basis, and some special extended statistics are supported too.Custom and extended statistics are typically added after we've been accumulating data for some time.See PgBuildStatistics_Extended in IB to declare new statistics objects. For more background, seehttps://ascendco.atlassian.net/wiki/spaces/SON/pages/1723695105/*/-------------------------------------- ANALYZE options-------------------------------------- Placholder and reminder for now. ANALYZE and AUTOVACUUM tunings are *core* Postgres DBA-- skills. But, for the minute, we're not running into trouble. I'm chipping away af figuring-- out when to tune, and how, and when not to tune. ‚Äî DPA-------------------------------------- Build indexes-------------------------------------- Note: Postgres automatically creates a UNIQUE B-tree for the PRIMARY KEY, simple or compound./* Indexing trade-offs are different in 4D and Postgres.It pays to be a bit conservative about adding indexes in Postgres, wait and see what you need.CREATE INDEX facility_activities_facility_id_ix_btree          ON ascendco.facility_activities       USING btree (facility_id);CREATE INDEX facility_activities_last_updated_by_data_file_id_ix_gin          ON ascendco.facility_activities       USING GIN (last_updated_by_data_file_id);CREATE INDEX facility_activities_marked_for_deletion_ix_gin          ON ascendco.facility_activities       USING GIN (marked_for_deletion extensions.bool_ops)       WHERE marked_for_deletion = true;*/-------------------------------------- CLUSTER------------------------------------/*Code stub/reminder about CLUSTERing. Not a hard topic, but too big to write up here. Notes and links:https://ascendco.atlassian.net/wiki/spaces/SON/pages/356679683/ALTER TABLE ascendco.facility_activities    CLUSTER ON ***index name to cluster by here.***;*/-------------------------------------- Add triggers------------------------------------   CREATE TRIGGER trigger_facility_activities_after_delete            AFTER DELETE               ON ascendco.facility_activities      REFERENCING OLD TABLE AS deleted_rows         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();  CREATE TRIGGER trigger_facility_activities_before_truncate            BEFORE TRUNCATE               ON ascendco.facility_activities         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();-------------------------------------- Manual Permissions for now-------------------------------------- Standard permissions for utility/admin users:GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.facility_activities TO rds_super;GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.facility_activities TO user_cleanup;GRANT SELECT ON ascendco.facility_activities TO user_reporting;GRANT SELECT ON ascendco.facility_activities TO user_change_structure;-- Adjustable user permissions:GRANT SELECT ON ascendco.facility_activities TO user_iceberg;GRANT SELECT ON ascendco.facility_activities TO user_iceberg_remote;GRANT SELECT ON ascendco.facility_activities TO user_saws;GRANT SELECT, INSERT, UPDATE ON ascendco.facility_activities TO user_sonar;GRANT SELECT ON ascendco.facility_activities TO user_leviathan;COMMIT;