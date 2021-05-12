CREATE OR REPLACE FUNCTION ascendco.calendar_add (     id_in               uuid, -- Pre-build UUIDs to share around the system. That's why this is passed, not generated.     calendar_name_in    citext,     week_starts_on_in   day_name,     description_in      citext DEFAULT ''     )RETURNS uuid AS$BODY$DELETE from calendar WHERE id = id_in; -- CASCADE delete flows through to related child tables.INSERT INTO calendar  (id, calendar_name, week_starts_on, description)            VALUES    (id_in, calendar_name_in, week_starts_on_in, description_in)            RETURNING id; -- The RETURNING clauses is a very cool Postgres extension to SQL. It should be in the standards.$BODY$  LANGUAGE sql;ALTER function ascendco.calendar_add (uuid, citext,day_name, citext)	OWNER TO user_bender;