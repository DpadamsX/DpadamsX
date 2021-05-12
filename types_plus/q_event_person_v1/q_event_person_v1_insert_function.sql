﻿-- Create a function to accept an array of rows formatted as q_event_person_v1 for UPSERT into q_event_person.DROP FUNCTION IF EXISTS types_plus.insert_q_event_person_v1 (types_plus.q_event_person_v1[]);  CREATE OR REPLACE FUNCTION types_plus.insert_q_event_person_v1 (data_in types_plus.q_event_person_v1[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO q_event_person (			id,			web_user_id,			last_updated_by_data_file_id,			qevent_id,			created_dts,			updated_dts,			marked_for_deletion,			is_accountable,			send_email,			updated_by,			role_,			created_by)                  SELECT			rows_in.id,			rows_in.web_user_id,			rows_in.last_updated_by_data_file_id,			rows_in.qevent_id,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.marked_for_deletion,			rows_in.is_accountable,			rows_in.send_email,			rows_in.updated_by,			rows_in.role_,			rows_in.created_by                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			web_user_id = EXCLUDED.web_user_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			qevent_id = EXCLUDED.qevent_id,			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			marked_for_deletion = EXCLUDED.marked_for_deletion,			is_accountable = EXCLUDED.is_accountable,			send_email = EXCLUDED.send_email,			updated_by = EXCLUDED.updated_by,			role_ = EXCLUDED.role_,			created_by = EXCLUDED.created_by          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_q_event_person_v1(types_plus.q_event_person_v1[])	OWNER TO user_bender;