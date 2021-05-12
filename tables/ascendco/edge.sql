﻿CREATE EXTENSION IF NOT EXISTS ltree SCHEMA extensions;-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS ascendco.edge CASCADE;CREATE TABLE IF NOT EXISTS ascendco.edge (    id                             uuid          NOT NULL DEFAULT NULL PRIMARY KEY,    sequence_                      uuid          NOT NULL DEFAULT NULL,    from_scan_at_facility_id       uuid          NOT NULL DEFAULT NULL,    from_associated_to_id          uuid          NOT NULL DEFAULT NULL,    to_associated_to_id            uuid          NOT NULL DEFAULT NULL,    from_web_user_id               uuid          NOT NULL DEFAULT NULL,    from_assembly_id               uuid          NOT NULL DEFAULT NULL,    from_scan_id                   uuid          NOT NULL DEFAULT NULL,    from_sterilizer_load_id        uuid          NOT NULL DEFAULT NULL,    from_facility_location_id      uuid          NOT NULL DEFAULT NULL,    from_facility_id               uuid          NOT NULL DEFAULT NULL,    from_washer_load_id            uuid          NOT NULL DEFAULT NULL,    from_scase_id                  uuid          NOT NULL DEFAULT NULL,    from_clinic_id                 uuid          NOT NULL DEFAULT NULL,    from_facility_department_id    uuid          NOT NULL DEFAULT NULL,    hsys_id                        uuid          NOT NULL DEFAULT NULL,    to_scan_id                     uuid          NOT NULL DEFAULT NULL,    to_scan_at_facility_id         uuid          NOT NULL DEFAULT NULL,    to_web_user_id                 uuid          NOT NULL DEFAULT NULL,    to_user_name                   uuid          NOT NULL DEFAULT NULL,    to_facility_location_id        uuid          NOT NULL DEFAULT NULL,    to_sterilizer_load_id          uuid          NOT NULL DEFAULT NULL,    to_washer_load_id              uuid          NOT NULL DEFAULT NULL,    to_facility_id                 uuid          NOT NULL DEFAULT NULL,    to_scase_id                    uuid          NOT NULL DEFAULT NULL,    to_clinic_id                   uuid          NOT NULL DEFAULT NULL,    to_facility_department_id      uuid          NOT NULL DEFAULT NULL,    to_assembly_id                 uuid          NOT NULL DEFAULT NULL,    from_node_dts                  timestamp     NOT NULL DEFAULT 'epoch',    to_node_dts                    timestamp     NOT NULL DEFAULT 'epoch',    created_dts                    timestamp     NOT NULL DEFAULT 'epoch',    updated_dts                    timestamp     NOT NULL DEFAULT 'epoch',    from_to_range                  tsrange       GENERATED ALWAYS AS (tsrange(from_node_dts, to_node_dts)) STORED,    seconds                        integer       NOT NULL DEFAULT 0,    num_inst                       integer       NOT NULL DEFAULT 0,    inv_id                         citext        NOT NULL DEFAULT NULL,    from_node                      citext        NOT NULL DEFAULT NULL,    to_node                        citext        NOT NULL DEFAULT NULL,    from_to_node                   citext        NOT NULL DEFAULT NULL,    from_associated_to             citext        NOT NULL DEFAULT NULL,    to_associated_to               citext        NOT NULL DEFAULT NULL,    from_user_name                 citext        NOT NULL DEFAULT NULL,    source_                        citext        NOT NULL DEFAULT NULL,    is_fake                        citext        NOT NULL DEFAULT NULL,    path_                          ltree         NOT NULL DEFAULT NULL);ALTER TABLE ascendco.edge	OWNER TO user_change_structure;-------------------------------------- Build statistics------------------------------------/*The Postgres ANALYZE system function collects statistics about each table and column. These valuesare used by the query planner to help generate probabilistic cost estimates for various query plans.When the plans are based on misleading stats, you can have poor performance. Stats can be reconfiguredon a row-by-row basis, and some special extended statistics are supported too.Custom and extended statistics are typically added after we've been accumulating data for some time.See PgBuildStatistics_Extended in IB to declare new statistics objects. For more background, seehttps://ascendco.atlassian.net/wiki/spaces/SON/pages/1723695105/*/-------------------------------------- ANALYZE options-------------------------------------- Placholder and reminder for now. ANALYZE and AUTOVACUUM tunings are *core* Postgres DBA-- skills. But, for the minute, we're not running into trouble. I'm chipping away af figuring-- out when to tune, and how, and when not to tune. ‚Äî DPA-------------------------------------- Build indexes-------------------------------------- Note: Postgres automatically creates a UNIQUE B-tree for the PRIMARY KEY, simple or compound.CREATE INDEX edge_from_to_range_ix_gist    ON ascendco.edge USING GIST (from_to_range); -- GiST is an index category that's useful with multi-value data types, like tsrange, point, or tsvector.CREATE INDEX edge_path_ix_ltree          ON ascendco.edge       USING gist (path_);/* Indexing trade-offs are different in 4D and Postgres.It pays to be a bit conservative about adding indexes in Postgres, wait and see what you need.CREATE INDEX edge_sequence_ix_btree          ON ascendco.edge       USING btree (sequence_);CREATE INDEX edge_to_scan_id_ix_btree          ON ascendco.edge       USING btree (to_scan_id);CREATE INDEX edge_to_scan_at_facility_id_ix_gin          ON ascendco.edge       USING GIN (to_scan_at_facility_id);CREATE INDEX edge_to_node_dts_ix_btree          ON ascendco.edge       USING btree (to_node_dts);CREATE INDEX edge_inv_id_ix_btree          ON ascendco.edge       USING btree (inv_id);*/-------------------------------------- CLUSTER------------------------------------/*Code stub/reminder about CLUSTERing. Not a hard topic, but too big to write up here. Notes and links:https://ascendco.atlassian.net/wiki/spaces/SON/pages/356679683/ALTER TABLE ascendco.edge    CLUSTER ON ***index name to cluster by here.***;*/-------------------------------------- Add triggers------------------------------------   CREATE TRIGGER trigger_edge_after_delete            AFTER DELETE               ON ascendco.edge      REFERENCING OLD TABLE AS deleted_rows         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_deletion_count();  CREATE TRIGGER trigger_edge_before_truncate            BEFORE TRUNCATE               ON ascendco.edge         FOR EACH STATEMENTEXECUTE PROCEDURE ascendco.trigger_function_log_truncation_count();-------------------------------------- Manual Permissions for now-------------------------------------- Standard permissions for utility/admin users:GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.edge TO rds_super;GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.edge TO user_cleanup;GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.edge TO user_change_structure;GRANT SELECT ON ascendco.edge TO user_reporting;-- Adjustable user permissions:GRANT SELECT ON ascendco.edge TO user_iceberg;GRANT SELECT ON ascendco.edge TO user_iceberg_remote;GRANT SELECT ON ascendco.edge TO user_saws;GRANT SELECT, INSERT, UPDATE ON ascendco.edge TO user_sonar;GRANT SELECT ON ascendco.edge TO user_leviathan;COMMIT;