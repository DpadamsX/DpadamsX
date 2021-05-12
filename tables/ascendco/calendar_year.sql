-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE if exists ascendco.calendar_year CASCADE;CREATE TABLE ascendco.calendar_year(  id                       uuid      NOT NULL DEFAULT extensions.gen_random_uuid() PRIMARY KEY,  calendar_id              uuid      NOT NULL DEFAULT NULL,  fiscal_year_name         citext    NOT NULL DEFAULT NULL, -- Text? Academic and financial years commony split calendar years.  fiscal_year_abbr         citext    NOT NULL DEFAULT NULL, -- Useful in week names and other labels, like "2020" of "FY19-20".  first_date_in_year       date      NOT NULL DEFAULT NULL,  last_date_in_year        date      NOT NULL DEFAULT NULL,  days_in_year             int2      NOT NULL DEFAULT NULL,  weeks_in_year            int2      NOT NULL DEFAULT NULL,  first_day_of_week_usa    int2      NOT NULL DEFAULT NULL, -- 1-7 day numbers, Sunday-Saturday, like 4D  first_day_of_week_iso    int2      NOT NULL DEFAULT NULL, -- 1-7 day numbers, Monday-Sunday  first_day_of_week_name   citext    NOT NULL DEFAULT NULL,  week_start_offset        integer DEFAULT 1 -- 1 for a Sunday start, 0 for a Monday week start.  );ALTER TABLE ascendco.calendar_year	ADD CONSTRAINT calendar_year_calendar_fk	FOREIGN KEY (calendar_id) REFERENCES calendar(id)	ON DELETE CASCADE;ALTER TABLE ascendco.calendar_year	ADD CONSTRAINT calendar_year_unique_name    UNIQUE (calendar_id, fiscal_year_name);ALTER TABLE ascendco.calendar_year	ADD CONSTRAINT calendar_year_unique_abbr    UNIQUE (calendar_id, fiscal_year_abbr);ALTER TABLE ascendco.calendar_year	OWNER TO user_change_structure;COMMIT;-------------------------------------- Build indexes-------------------------------------- None needed right now, not enough data.-------------------------------------- Define trigger functions-------------------------------------- In PG 12 we can use generated columns instead.CREATE OR REPLACE FUNCTION ascendco.trigger_function_calendar_year_before_upsert()  RETURNS triggerAS $BODY$BEGIN	NEW.first_day_of_week_usa := extract (dow from NEW.first_date_in_year) +1; -- 1-7, Sunday-Saturday, USA style.	NEW.first_day_of_week_iso := extract (isodow from NEW.first_date_in_year); -- 1-7, Monday-Sunday, ISO style. RETURN NEW;END$BODY$  LANGUAGE plpgsql VOLATILE  COST 100;ALTER FUNCTION ascendco.trigger_function_calendar_year_before_upsert	OWNER TO user_bender;-------------------------------------- Add triggers------------------------------------CREATE TRIGGER calendar_year_before_upsert	BEFORE INSERT OR UPDATE	ON ascendco.calendar_year	FOR EACH ROW	EXECUTE PROCEDURE trigger_function_calendar_year_before_upsert();-------------------------------------- Manual Permissions for now------------------------------------GRANT SELECT, INSERT, UPDATE, DELETE ON ascendco.calendar_year TO rds_super;GRANT SELECT ON ascendco.calendar_year TO user_reporting;GRANT SELECT ON ascendco.calendar_year TO user_iceberg;GRANT SELECT ON ascendco.calendar_year TO user_iceberg_remote;GRANT SELECT ON ascendco.calendar_year TO user_saws;GRANT SELECT ON ascendco.calendar_year TO user_sonar;GRANT SELECT ON ascendco.calendar_year TO user_leviathan;GRANT SELECT ON ascendco.calendar_year TO user_change_structure;