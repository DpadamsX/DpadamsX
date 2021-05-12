﻿-- Create a function to accept an array of rows formatted as q_type_v1 for UPSERT into q_type.DROP FUNCTION IF EXISTS types_plus.insert_q_type_v1 (types_plus.q_type_v1[]);  CREATE OR REPLACE FUNCTION types_plus.insert_q_type_v1 (data_in types_plus.q_type_v1[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO q_type (			id,			hsys_id,			last_updated_by_data_file_id,			created_dts,			updated_dts,			marked_for_deletion,			is_active,			updated_by,			created_by,			ascendco_name,			name_,			type_)                  SELECT			rows_in.id,			rows_in.hsys_id,			rows_in.last_updated_by_data_file_id,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.marked_for_deletion,			rows_in.is_active,			rows_in.updated_by,			rows_in.created_by,			rows_in.ascendco_name,			rows_in.name_,			rows_in.type_                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			hsys_id = EXCLUDED.hsys_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			marked_for_deletion = EXCLUDED.marked_for_deletion,			is_active = EXCLUDED.is_active,			updated_by = EXCLUDED.updated_by,			created_by = EXCLUDED.created_by,			ascendco_name = EXCLUDED.ascendco_name,			name_ = EXCLUDED.name_,			type_ = EXCLUDED.type_          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_q_type_v1(types_plus.q_type_v1[])	OWNER TO user_bender;