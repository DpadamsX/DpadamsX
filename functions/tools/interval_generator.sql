CREATE OR REPLACE FUNCTION tools.interval_generator(        start_ts timestamp,        end_ts timestamp,        round_interval interval)    RETURNS TABLE(            start_time timestamp,            end_time timestamp) as $$BEGINRETURN QUERY        select            (n)       start_time,            (n + round_interval) end_time        from generate_series(date_trunc('minute', start_ts), end_ts, round_interval) n;END$$LANGUAGE 'plpgsql';COMMENT ON FUNCTION tools.interval_generator (timestamp, timestamp, interval) IS '/*https://stackoverflow.com/questions/12045600/postgresql-sql-group-by-time-interval-with-arbitrary-accuracy-down-to-milli-sec*/';ALTER FUNCTION tools.interval_generator (timestamp, timestamp, interval)	OWNER TO user_bender;