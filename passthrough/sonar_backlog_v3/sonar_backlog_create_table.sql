﻿BEGIN; DROP TABLE IF EXISTS ascendco.sonar_backlog CASCADE; CREATE TABLE IF NOT EXISTS ascendco.sonar_backlog (    id uuid NOT NULL DEFAULT gen_random_uuid(),    hsys_id uuid NOT NULL DEFAULT NULL,    facility_id uuid NOT NULL DEFAULT NULL,    backlog_dts timestamp NOT NULL DEFAULT NULL,    overall_backlog int4 NOT NULL DEFAULT NULL,    clean_backlog int4 NOT NULL DEFAULT NULL,    dirty_inst_backlog int4 NOT NULL DEFAULT NULL,    backlog_fiscal_week_no int4 NOT NULL DEFAULT NULL,    backlog_hour_bin int4 NOT NULL DEFAULT NULL,    backlog_day_of_week int4 NOT NULL DEFAULT NULL,    backlog_month_no int4 NOT NULL DEFAULT NULL,    overall_inst_backlog int4 NOT NULL DEFAULT NULL,    backlog_hour_of_day int4 NOT NULL DEFAULT NULL,    dirty_backlog int4 NOT NULL DEFAULT NULL,    backlog_year_no int4 NOT NULL DEFAULT NULL,    clean_inst_backlog int4 NOT NULL DEFAULT NULL,    backlog_date date NOT NULL DEFAULT NULL,    facility_name citext NOT NULL DEFAULT NULL,    backlog_year citext NOT NULL DEFAULT NULL,    date_time citext NOT NULL DEFAULT NULL,    backlog_local citext NOT NULL DEFAULT NULL,    backlog_fiscal_week citext NOT NULL DEFAULT NULL,    date_hour citext NOT NULL DEFAULT NULL,    hsys_name citext NOT NULL DEFAULT NULL,    backlog_day_name citext NOT NULL DEFAULT NULL,    backlog_month citext NOT NULL DEFAULT NULL, CONSTRAINT sonar_backlog_id_pkey    PRIMARY KEY (id)); ALTER TABLE ascendco.sonar_backlog OWNER TO user_change_structure;COMMIT;