﻿-- Create a view onto need formatted as need_v5.-- If need changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_need_v5.DROP VIEW IF EXISTS types_plus.need_v5 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.need_v5 AS select id,        hsys_id,        facility_id,        item_id,        percent_down,        next_case_dts,        flow,        qty_circulation,        qty_ready_everywhere,        qty_ready_here,        qty_sched_everywhere,        qty_sched_here,        qty_sterile_everywhere,        qty_sterile_here,        qty_suggest_sterilize,        qty_total,        ready_vs_need_defecit,        sched_sort,        sort_rank,        suggest_transport,        next_needed,        or_name,        status,        status_sort,        when_,        qty_here   from need;ALTER TABLE types_plus.need_v5    OWNER TO user_change_structure;-- Create a casting function to convert need rows into the compound type format need_v5.-- If need changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.need_to_v5 (need_in need)  RETURNS need_v5AS $BODY$                   SELECT			need_in.id,			need_in.hsys_id,			need_in.facility_id,			need_in.item_id,			need_in.percent_down,			need_in.next_case_dts,			need_in.flow,			need_in.qty_circulation,			need_in.qty_ready_everywhere,			need_in.qty_ready_here,			need_in.qty_sched_everywhere,			need_in.qty_sched_here,			need_in.qty_sterile_everywhere,			need_in.qty_sterile_here,			need_in.qty_suggest_sterilize,			need_in.qty_total,			need_in.ready_vs_need_defecit,			need_in.sched_sort,			need_in.sort_rank,			need_in.suggest_transport,			need_in.next_needed,			need_in.or_name,			need_in.status,			need_in.status_sort,			need_in.when_,			need_in.qty_here               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.need_to_v5 (need_in need)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert need rows into the need_v5 compound type format using the following syntax:-- select need::need_v5 from needDROP CAST IF EXISTS (need as need_v5);CREATE CAST (need as need_v5) WITH FUNCTION types_plus.need_to_v5(need);-- Create a function to accept an array of rows formatted as need_v5 for UPSERT into need.DROP FUNCTION IF EXISTS types_plus.insert_need_v5 (types_plus.need_v5[]);  CREATE OR REPLACE FUNCTION types_plus.insert_need_v5 (data_in types_plus.need_v5[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO need (			id,			hsys_id,			facility_id,			item_id,			percent_down,			next_case_dts,			flow,			qty_circulation,			qty_ready_everywhere,			qty_ready_here,			qty_sched_everywhere,			qty_sched_here,			qty_sterile_everywhere,			qty_sterile_here,			qty_suggest_sterilize,			qty_total,			ready_vs_need_defecit,			sched_sort,			sort_rank,			suggest_transport,			next_needed,			or_name,			status,			status_sort,			when_,			qty_here)                  SELECT			rows_in.id,			rows_in.hsys_id,			rows_in.facility_id,			rows_in.item_id,			rows_in.percent_down,			rows_in.next_case_dts,			rows_in.flow,			rows_in.qty_circulation,			rows_in.qty_ready_everywhere,			rows_in.qty_ready_here,			rows_in.qty_sched_everywhere,			rows_in.qty_sched_here,			rows_in.qty_sterile_everywhere,			rows_in.qty_sterile_here,			rows_in.qty_suggest_sterilize,			rows_in.qty_total,			rows_in.ready_vs_need_defecit,			rows_in.sched_sort,			rows_in.sort_rank,			rows_in.suggest_transport,			rows_in.next_needed,			rows_in.or_name,			rows_in.status,			rows_in.status_sort,			rows_in.when_,			rows_in.qty_here                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			hsys_id = EXCLUDED.hsys_id,			facility_id = EXCLUDED.facility_id,			item_id = EXCLUDED.item_id,			percent_down = EXCLUDED.percent_down,			next_case_dts = EXCLUDED.next_case_dts,			flow = EXCLUDED.flow,			qty_circulation = EXCLUDED.qty_circulation,			qty_ready_everywhere = EXCLUDED.qty_ready_everywhere,			qty_ready_here = EXCLUDED.qty_ready_here,			qty_sched_everywhere = EXCLUDED.qty_sched_everywhere,			qty_sched_here = EXCLUDED.qty_sched_here,			qty_sterile_everywhere = EXCLUDED.qty_sterile_everywhere,			qty_sterile_here = EXCLUDED.qty_sterile_here,			qty_suggest_sterilize = EXCLUDED.qty_suggest_sterilize,			qty_total = EXCLUDED.qty_total,			ready_vs_need_defecit = EXCLUDED.ready_vs_need_defecit,			sched_sort = EXCLUDED.sched_sort,			sort_rank = EXCLUDED.sort_rank,			suggest_transport = EXCLUDED.suggest_transport,			next_needed = EXCLUDED.next_needed,			or_name = EXCLUDED.or_name,			status = EXCLUDED.status,			status_sort = EXCLUDED.status_sort,			when_ = EXCLUDED.when_,			qty_here = EXCLUDED.qty_here          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_need_v5(types_plus.need_v5[])	OWNER TO user_bender;