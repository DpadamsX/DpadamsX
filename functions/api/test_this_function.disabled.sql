CREATE OR REPLACE FUNCTION api.test_this_function(in_text text) RETURNS timestamp LANGUAGE plpgsqlAS $function$BEGINIF in_text = '' THEN	RAISE EXCEPTION USING		message = 'Input text must be supplied',		detail = 'Deets',		hint = 'Supply a search string',		errcode = 'KC101'; -- Custom codeEND IF;    RETURN now();END;$function$