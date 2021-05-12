CREATE OR REPLACE FUNCTION tools.typcategory_name (typcategory text, out typcategory_name text)
  RETURNS text

AS $BODY$

SELECT CASE
  WHEN typcategory ='A' THEN 'Array'
  WHEN typcategory ='B' THEN 'Boolean'
  WHEN typcategory ='C' THEN 'Composite'
  WHEN typcategory ='D' THEN 'Date/time'
  WHEN typcategory ='E' THEN 'Enum'
  WHEN typcategory ='G' THEN 'Geometric'
  WHEN typcategory ='I' THEN 'Network address'
  WHEN typcategory ='N' THEN 'Numeric'
  WHEN typcategory ='P' THEN 'Pseudo-'
  WHEN typcategory ='R' THEN 'Range'
  WHEN typcategory ='S' THEN 'String'
  WHEN typcategory ='T' THEN 'Timespan'
  WHEN typcategory ='U' THEN 'User-defined'
  WHEN typcategory ='V' THEN 'Bit-string'
  WHEN typcategory ='X' THEN 'Unknown type'
  ELSE 'Unexpected typcategory ' || typcategory
END;

$BODY$
	LANGUAGE sql;

ALTER FUNCTION tools.typcategory_name (typcategory text, out typcategory_name text) 
	OWNER TO user_bender;
