insert	into custom_function (
	proc_oid,
	input_signature,
	function_name,
	schema_oid,
	owner_oid,
	language_oid,
	return_type_oid,
	is_security_definer,
	runs_as,
	fails_on_null_input,
	returns_table,
	function_kind_code,
	function_acl,
	method_body)

select	oid,
		proargtypes,
		proname::text,
		pronamespace,
		proowner,
		prolang,
		prorettype,
		prosecdef,
		'',
		proisstrict,
		proretset,
		prokind,
		proacl,
		prosrc

from pg_proc

where pronamespace IN (select oid from pg_namespace where nspname IN ('api','api_queries','dba','tools'))