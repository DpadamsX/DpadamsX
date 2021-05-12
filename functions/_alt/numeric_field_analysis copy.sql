-- This is going to be a bit slow as it has to grind through the data...not all of which is indexed.CREATE OR REPLACE FUNCTION dba.numeric_field_analysis (table_name_in text, field_name text)  RETURNS TABLE (	table_name text, 	column_name text, 	min int4, 	max int4, 	avg float4, 	variance float4, 	stddev float4, 	stddev3 float4, 	q1 float4, 	q2 float4, 	q3 float4, 	p95 float4, 	iqr float4,		stddev3_count int4,	stddev3_min float4,	stddev3_max float4,	q3_count int4,	q3_min float4,	q3_max float4,		p95_count int4,	p95_min float4,	p95_max float4,		p99_count int4,	p99_min float4,	p99_max	float4)	AS $BODY$  BEGIN    RETURN QUERY EXECUTE        'with 	overall_stats as 	(select *	   from numeric_field_stats(' || quote_literal(table_name_in) || ',' || quote_literal(field_name) || ')	 ), 	q3_stats as 	(select count(*)::int4 as q3_count,			  coalesce(min(' || quote_ident(field_name) || '),0)::float4 as q3_min,			  coalesce(max(' || quote_ident(field_name) || '),0)::float4 as q3_max		  	   from '|| quote_ident(table_name_in) || '	  where ' || quote_ident(field_name) || ' >= (select q3 from overall_stats)),  	stddev3_stats as 	(select count(*)::int4 as stddev3_count,			  coalesce(min(' || quote_ident(field_name) || '),0)::float4 as stddev3_min,			  coalesce(max(' || quote_ident(field_name) || '),0)::float4 as stddev3_max		  	   from '|| quote_ident(table_name_in) || '	  where ' || quote_ident(field_name) || ' >= (select stddev3 from overall_stats)),	p95_stats as 	(select count(*)::int4 as p95_count,			  coalesce(min(' || quote_ident(field_name) || '),0)::float4 as p95_min,			  coalesce(max(' || quote_ident(field_name) || '),0)::float4 as p95_max		  	   from '|| quote_ident(table_name_in) || '	  where ' || quote_ident(field_name) || ' >= (select p95 from overall_stats)),	p99_stats as 	(select count(*)::int4 as p99_count,			  coalesce(min(' || quote_ident(field_name) || '),0)::float4 as p99_min,			  coalesce(max(' || quote_ident(field_name) || '),0)::float4 as p99_max		  	   from '|| quote_ident(table_name_in) || '	  where ' || quote_ident(field_name) || ' >= (select p99 from overall_stats))   	select overall_stats.table_name,           overall_stats.column_name,           overall_stats.min,           overall_stats.max,           overall_stats.avg,           overall_stats.variance,           overall_stats.stddev,           overall_stats.stddev3,           overall_stats.q1,           overall_stats.q2,           overall_stats.q3,           overall_stats.p95,           overall_stats.iqr,           stddev3_stats.stddev3_count,           stddev3_stats.stddev3_min,           stddev3_stats.stddev3_max,                      q3_stats.q3_count,           q3_stats.q3_min,           q3_stats.q3_max,                      p95_stats.p95_count,           p95_stats.p95_min,           p95_stats.p95_max,                      p99_stats.p99_count,           p99_stats.p99_min,           p99_stats.p99_max      from overall_stats,           stddev3_stats,           q3_stats,           p95_stats,           p99_stats'      						    USING table_name_in, field_name;	END;$BODY$  LANGUAGE plpgsql;ALTER FUNCTION dba.numeric_field_analysis (text, text) OWNER TO user_bender;