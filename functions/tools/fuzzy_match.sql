DROP FUNCTION IF EXISTS tools.fuzzy_match (citext, uuid, int4, citext, float4, int4);-- decimal_score is a custom domain (type) for ###.##### numbers.CREATE OR REPLACE FUNCTION tools.fuzzy_match (     base_text_in                        citext,     text_collection_id_in               uuid,     neighbors_to_check_max_in           int4   DEFAULT 25,     monge_elkan_similarity_method_in    citext DEFAULT 'jarowinkler',     neighbor_qgram_threshold_min_in     float4 DEFAULT 0.2,     result_rows_max_in                  int4   DEFAULT 25)RETURNS TABLE (     base_text                           citext,     neighbor_text                       citext,     neighbor_id                         citext, -- Might be a 3rd party ID, not one of our UUIDs.     neighbor_rank                       int4,     neighbors_count                     int4,     highest_score                       decimal_score,     best_method                         citext,     avg_score                           decimal_score,     avg_quadratic_score                 decimal_score,     equality_check                      int4,     jaro_score                          decimal_score,     jaro_winkler_score                  decimal_score,     monge_elkan_score                   decimal_score,     monge_elkan_quadratic_score         decimal_score,     qgram_score                         decimal_score,     trigram_score                       decimal_score)AS $BODY$DECLARE-------------------------------------------------------------- Setup query template, which you can RAISE NOTICE while .-- developing to see what's in it.------------------------------------------------------------sql text := 'WITHnear_neighbors AS (  select distinct on (text <-> $1) text AS neighbor_text,         $1                             AS base_text,         source_id                      AS neighbor_id    from text_collection_item   where collection_id = $2  limit $3),measures AS (  select *,         DENSE_RANK() OVER(ORDER BY qgram(base_text, neighbor_text) DESC) AS neighbor_rank,         (base_text = neighbor_text)::int4                                AS equality_check,         monge_elkan(base_text, neighbor_text, $4)                        AS monge_elkan_score,         sqrt(monge_elkan(base_text, neighbor_text, $4))                  AS monge_elkan_quadratic_score,         jaro (base_text, neighbor_text)                                  AS jaro_score,         jarowinkler (base_text, neighbor_text)                           AS jaro_winkler_score,         qgram(base_text, neighbor_text)                                  AS qgram_score,         similarity(base_text, neighbor_text)                             AS trigram_score  from near_neighbors), handicap AS (    select base_text,           neighbor_text,           neighbor_id,           neighbor_rank::int4,           count(*) OVER() AS neighbors_count, -- Weird-looking way to get a count out of near_neighbors.           equality_check,           CASE             WHEN monge_elkan_score = 1 AND equality_check = 0 THEN 0.95             ELSE monge_elkan_score           END AS monge_elkan_score,           CASE             WHEN monge_elkan_quadratic_score = 1 AND equality_check = 0 THEN 0.95             ELSE monge_elkan_quadratic_score           END AS monge_elkan_quadratic_score,           jaro_score,           jaro_winkler_score,           qgram_score,           trigram_score      from measures     where qgram_score >= $5 ),stats AS (  select *,        (handicap.monge_elkan_score +         handicap.monge_elkan_quadratic_score +         jaro_score +         jaro_winkler_score +         qgram_score +         trigram_score) / 6 AS avg_score    from handicap), calculations AS (  select *,         sqrt(avg_score) AS avg_quadratic_score,         greatest (           monge_elkan_score,           monge_elkan_quadratic_score,           avg_score,           sqrt(avg_score),           jaro_score,           jaro_winkler_score,           qgram_score,           trigram_score) AS highest_score from stats)-- Final query, pull it all together and selsort  select base_text,         neighbor_text,         neighbor_id,         neighbor_rank::int4,         neighbors_count::int4,         highest_score::decimal_score,         (CASE highest_score            WHEN equality_check              THEN ''equality''            WHEN monge_elkan_quadratic_score THEN ''monge_elkan_quadratic''            WHEN monge_elkan_score           THEN ''monge_elkan''            WHEN jaro_score                  THEN ''jaro''            WHEN jaro_winkler_score          THEN ''jaro_winkler''            WHEN qgram_score                 THEN ''qgram''            WHEN trigram_score               THEN ''trigram''            WHEN avg_score                   THEN ''avg''            WHEN avg_quadratic_score         THEN ''avg_quadratic''            ELSE ''Undefined''         END)::citext AS best_method,         avg_score::decimal_score,         avg_quadratic_score::decimal_score,         equality_check::int4,         jaro_score::decimal_score,         jaro_winkler_score::decimal_score,         monge_elkan_score::decimal_score,         monge_elkan_quadratic_score::decimal_score,         qgram_score::decimal_score,         trigram_score::decimal_score    from calculationsorder by highest_score               DESC,         equality_check              DESC,         monge_elkan_quadratic_score DESC,         monge_elkan_score           DESC,         jaro_score                  DESC,         jaro_winkler_score          DESC,         qgram_score                 DESC,         trigram_score               DESC  limit $6';BEGIN-------------------------------------------------------------- Existence check for the text_collection------------------------------------------------------------	IF NOT EXISTS (select 1 from text_collection where id = text_collection_id_in) THEN		RAISE EXCEPTION USING			message = 'text_collection not found with id = ''' || text_collection_id_in || '''',			errcode = 'KC100'; -- Custom code for 'Bad string selector parameter value'.    END IF;-------------------------------------------------------------- Safety checks for parameters stitched into the SQL.------------------------------------------------------------	IF base_text_in = '' THEN		RAISE EXCEPTION USING			message = 'A base string must be supplied.',			errcode = 'KC101'; -- Custom code for 'Empty string parameter'.    END IF;    monge_elkan_similarity_method_in  := lower(monge_elkan_similarity_method_in);	IF monge_elkan_similarity_method_in NOT IN ('jaro','jarowinkler','qgram') THEN		RAISE EXCEPTION USING			message = 'Invalid distance measure name ''' || monge_elkan_similarity_method_in || '''',			hint = 'Valid methods are jaro, jarowinkler, and qgram',			errcode = 'KC300'; -- Custom code for 'Bad lookup ID'.    END IF;-------------------------------------------------------------- Range/sanity checks on thresholds------------------------------------------------------------	IF neighbors_to_check_max_in < 1 THEN		RAISE EXCEPTION USING			message = 'neighbors_to_check_max value is too low.',			hint = 'Value must be 1 or higher.',			errcode = 'KC200'; -- Custom code for 'Numeric parameter value is too low'.    END IF;	IF result_rows_max_in < 1 THEN		RAISE EXCEPTION USING			message = 'result_rows_max value is too low.',			hint = 'Value must be 1 or higher.',			errcode = 'KC200'; -- Custom code for 'Numeric parameter value is too low'.    END IF;	IF neighbor_qgram_threshold_min_in < 0 OR neighbor_qgram_threshold_min_in > 1 THEN		RAISE EXCEPTION USING			message = 'neighbor_qgram_threshold_min value is out of range.',			hint = 'Value must be in the range 0-1.',			errcode = 'KC202'; -- Custom code for 'Numeric parameter value is too low'.    END IF;-------------------------------------------------------------- If you've gotten this far, everything looks good. Run it!------------------------------------------------------------    RETURN QUERY EXECUTE sql    USING base_text_in,          text_collection_id_in,          neighbors_to_check_max_in,          monge_elkan_similarity_method_in,          neighbor_qgram_threshold_min_in,          result_rows_max_in;END$BODY$LANGUAGE plpgsql STABLE;ALTER FUNCTION tools.fuzzy_match (citext, uuid, int4, citext, float4, int4)     OWNER TO user_bender;