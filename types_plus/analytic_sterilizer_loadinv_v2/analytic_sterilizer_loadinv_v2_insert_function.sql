﻿-- Create a function to accept an array of rows formatted as analytic_sterilizer_loadinv_v2 for UPSERT into analytic_sterilizer_loadinv.DROP FUNCTION IF EXISTS types_plus.insert_analytic_sterilizer_loadinv_v2 (types_plus.analytic_sterilizer_loadinv_v2[]);CREATE OR REPLACE FUNCTION types_plus.insert_analytic_sterilizer_loadinv_v2 (data_in types_plus.analytic_sterilizer_loadinv_v2[])  RETURNS intAS $BODY$-- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO analytic_sterilizer_loadinv (			id,			data_file_id,			marked_for_deletion,			facility_id,			hsys_id,			inv_id,			item_id,			item_type_id,			speciality_id,			sterilize_method_id,			sterilize_params_id,			sterilizer_id,			sterilizerload_id,			web_user_id,			inv_name_provided,			is_iuss,			num_inst,			qty,			category,			clinic_dept_name,			processing_seconds,			done_dts,			done_local_dts,			status)        SELECT			rows_in.id,			rows_in.data_file_id,			rows_in.marked_for_deletion,			rows_in.facility_id,			rows_in.hsys_id,			rows_in.inv_id,			rows_in.item_id,			rows_in.item_type_id,			rows_in.speciality_id,			rows_in.sterilize_method_id,			rows_in.sterilize_params_id,			rows_in.sterilizer_id,			rows_in.sterilizerload_id,			rows_in.web_user_id,			rows_in.inv_name_provided,			rows_in.is_iuss,			rows_in.num_inst,			rows_in.qty,			rows_in.category,			rows_in.clinic_dept_name,			rows_in.processing_seconds,			rows_in.done_dts,			rows_in.done_local_dts,			rows_in.status        FROM unnest(data_in) as rows_in        ON CONFLICT(id) DO UPDATE SET			data_file_id = EXCLUDED.data_file_id,			marked_for_deletion = EXCLUDED.marked_for_deletion,			facility_id = EXCLUDED.facility_id,			hsys_id = EXCLUDED.hsys_id,			inv_id = EXCLUDED.inv_id,			item_id = EXCLUDED.item_id,			item_type_id = EXCLUDED.item_type_id,			speciality_id = EXCLUDED.speciality_id,			sterilize_method_id = EXCLUDED.sterilize_method_id,			sterilize_params_id = EXCLUDED.sterilize_params_id,			sterilizer_id = EXCLUDED.sterilizer_id,			sterilizerload_id = EXCLUDED.sterilizerload_id,			web_user_id = EXCLUDED.web_user_id,			inv_name_provided = EXCLUDED.inv_name_provided,			is_iuss = EXCLUDED.is_iuss,			num_inst = EXCLUDED.num_inst,			qty = EXCLUDED.qty,			category = EXCLUDED.category,			clinic_dept_name = EXCLUDED.clinic_dept_name,			processing_seconds = EXCLUDED.processing_seconds,			done_dts = EXCLUDED.done_dts,			done_local_dts = EXCLUDED.done_local_dts,			status = EXCLUDED.status        returning 1 as row_counter)    select sum(row_counter)::integer from inserted_rows;$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.insert_analytic_sterilizer_loadinv_v2(types_plus.analytic_sterilizer_loadinv_v2[]) OWNER TO user_bender;