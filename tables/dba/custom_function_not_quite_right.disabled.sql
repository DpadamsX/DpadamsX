-------------------------------------- Define table------------------------------------BEGIN;DROP TABLE IF EXISTS dba.custom_function CASCADE;CREATE TABLE IF NOT EXISTS dba.custom_function (	id uuid NOT NULL DEFAULT extensions.gen_random_uuid(),	proc_oid oid NOT NULL DEFAULT NULL,	input_signature oidvector,	function_name text NOT NULL DEFAULT NULL,	function_signature text NOT NULL DEFAULT NULL,	specific_name text NOT NULL DEFAULT NULL,	schema_oid oid NOT NULL DEFAULT NULL,	owner_oid oid NOT NULL DEFAULT NULL,	language_oid oid NOT NULL DEFAULT NULL,	return_type_oid oid NOT NULL DEFAULT NULL,	is_security_definer bool NOT NULL DEFAULT NULL,	runs_as text NOT NULL DEFAULT NULL,	fails_on_null_input bool NOT NULL DEFAULT NULL,	returns_table bool NOT NULL DEFAULT NULL,	function_kind_code char NOT NULL DEFAULT NULL,	function_acl aclitem[] NOT NULL DEFAULT NULL,	method_body text NOT NULL DEFAULT NULL,	api_version integer NOT NULL DEFAULT 1,	published bool NOT NULL DEFAULT false,	dirty_created bool NOT NULL DEFAULT true,	dirty_altered bool NOT NULL DEFAULT false,	dirty_dropped bool NOT NULL DEFAULT false,	dirty bool NOT NULL DEFAULT NULL);ALTER TABLE dba.custom_function	ADD CONSTRAINT custom_function_id_pkey    PRIMARY KEY (id);ALTER TABLE dba.custom_function	ADD CONSTRAINT custom_function_signature_unique	UNIQUE (function_signature);ALTER TABLE dba.custom_function	OWNER TO user_change_structure;COMMIT;-------------------------------------- Build indexes-------------------------------------- No extra indexes needed yet, apart from uniques on id and signature above.-------------------------------------- Add triggers-------------------------------------- #1a: Function: Populate calculated columns.CREATE OR REPLACE FUNCTION dba.custom_function_on_insert()RETURNS TRIGGER AS$BODY$BEGIN    NEW.function_signature := NEW.schema_oid::text || '_' || NEW.function_name::text || '_' || NEW.input_signature::text;    NEW.specific_name := NEW.function_name::text || '_'  || NEW.proc_oid::text;    IF (NEW.is_security_definer = true) THEN    	NEW.runs_as :=  NEW.owner_oid::regrole::text;    ELSE    	NEW.runs_as := 'INVOKER';    END IF;    NEW.dirty := NOT(NEW.dirty_created AND NEW.dirty_altered AND NEW.dirty_dropped); -- dirty = true if any of the three individual dirty flags are true. Confusing syntax....for me, at least.    RETURN NEW;     -- important!END;$BODY$LANGUAGE 'plpgsql';-- #1b: Trigger: Apply calculated column formulas.CREATE TRIGGER trigger_custom_function_on_before_insert	BEFORE INSERT	ON dba.custom_function	FOR EACH ROW	EXECUTE PROCEDURE dba.custom_function_on_insert();-- #2a: Function: Populated parameters.CREATE OR REPLACE FUNCTION dba.custom_function_on_insert_populate_parameters()RETURNS TRIGGER AS$BODY$BEGININSERT INTO custom_function_parameter (		function_id,		specific_name,		ordinal_position,		in_out_position,		parameter_mode,		parameter_name,		data_type,		udt_name,		parameter_default)  SELECT NEW.function_id,         NEW.specific_name,         parameter.ordinal_position,         row_number() OVER (partition by parameter.specific_name,parameter_mode order by ordinal_position) as in_out_position,         parameter.parameter_mode,         coalesce(parameter.parameter_name,'') as parameter_name,         parameter.data_type::text,         parameter.udt_name::text,         coalesce(parameter.parameter_default,'') as parameter_defaultFROM functionJOIN information_schema.parameters AS parameter ON (parameter.specific_name = function.specific_name)-- #2b: Apply code to populate parameters.CREATE TRIGGER trigger_custom_function_on_after_insert	AFTER INSERT	ON dba.custom_function	FOR EACH ROW	EXECUTE PROCEDURE dba.custom_function_on_insert_populate_parameters();