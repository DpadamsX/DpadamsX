-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS dba.ddl_event_log CASCADE;CREATE TABLE IF NOT EXISTS dba.ddl_event_log (	id uuid NOT NULL DEFAULT extensions.gen_random_uuid(),	event_timestamp timestamptz NOT NULL DEFAULT clock_timestamp(), -- The timestamp at the time the command runs.	classid oid, --            CREATE, ALTER, DELETE	objid oid, --              CREATE, ALTER, DELETE	objsubid integer, --       CREATE, ALTER, DELETE	command_tag text, --       CREATE, ALTER           <- Same value as TG_TAG event_trigger variable.	is_temporary bool, --                     DELETE	normal bool, --                           DELETE	original bool, --                         DELETE	in_extension bool, --      CREATE, ALTER	object_identity text, --   CREATE, ALTER, DELETE	object_name text, --       CREATE, ALTER, DELETE	object_type text, --       CREATE, ALTER, DELETE	schema_name text, --       CREATE, ALTER, DELETE	address_args text[], --                   DELETE	address_names text[], --                  DELETE	trigger_event text); --    CREATE, ALTER, DELETE	-- object_source text);    --        CREATE, ALTER via JOIN on pg_proc. So, not views, tables, etc. Not working. Badly not working.ALTER TABLE dba.ddl_event_log	ADD CONSTRAINT ddl_event_log_id_pkey    PRIMARY KEY (id);ALTER TABLE dba.ddl_event_log	OWNER TO user_change_structure;COMMIT;-------------------------------------- Build indexes-------------------------------------- None needed at the moment.-------------------------------------- Add triggers-------------------------------------- None needed at the moment, but this might change to auto-populate and dirty custom_function.