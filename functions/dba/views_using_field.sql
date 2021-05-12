CREATE OR REPLACE FUNCTION dba.views_using_field (    table_name  text,    column_name text)RETURNS table (	  schema_name citext,	  view_name   citext	)AS $BODY$SELECT pg_namespace.nspname::citext   AS schema_name,       pg_class.oid::regclass::citext AS view_name FROM pg_attribute   -- columns for the table JOIN pg_depend   -- objects that depend on the column   ON pg_depend.refobjsubid = pg_attribute.attnum  AND pg_depend.refobjid = pg_attribute.attrelid JOIN pg_rewrite  -- rules depending on the column   ON pg_rewrite.oid = pg_depend.objid JOIN pg_class    -- views for the rules   ON pg_class.oid = pg_rewrite.ev_class JOIN pg_namespace -- I added this is to include the schema_name in the output. -- DPA   ON pg_class.relnamespace  = pg_namespace.oidWHERE pg_class.relkind = 'v'    -- only interested in views  -- dependency must be a rule depending on a relation  AND pg_depend.classid     = 'pg_rewrite'::regclass  AND pg_depend.refclassid  = 'pg_class'::regclass  AND pg_depend.deptype     = 'n'    -- normal dependency  AND pg_attribute.attrelid = table_name::regclass  AND pg_attribute.attname  = column_name;$BODY$	LANGUAGE sql;COMMENT ON FUNCTION dba.views_using_field (text, text) IS '/*Adapted from this excellent blob post:https://www.cybertec-postgresql.com/en/tracking-view-dependencies-in-postgresql/*/';ALTER FUNCTION dba.views_using_field (text, text)	OWNER TO user_bender;