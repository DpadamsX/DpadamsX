insert into custom_function_parameter (
		function_id,
		specific_name,
		ordinal_position,
		in_out_position,
		parameter_mode,
		parameter_name,
		data_type,
		udt_name,
		parameter_default)


WITH function AS (
   SELECT id as function_id,
          specific_name

     FROM custom_function)

  SELECT function.function_id,
         function.specific_name,
         parameter.ordinal_position,
         row_number() OVER (partition by parameter.specific_name,parameter_mode order by ordinal_position) as in_out_position,
         parameter.parameter_mode,
         coalesce(parameter.parameter_name,'') as parameter_name,
         parameter.data_type::text,
         parameter.udt_name::text,
         coalesce(parameter.parameter_default,'') as parameter_default

FROM function
JOIN information_schema.parameters AS parameter ON (parameter.specific_name = function.specific_name)
