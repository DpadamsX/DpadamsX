﻿-- Create a casting function to convert q_event_person rows into the compound type format q_event_person_v1.-- If q_event_person changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.q_event_person_to_v1 (q_event_person_in q_event_person)  RETURNS q_event_person_v1AS $BODY$                   SELECT			q_event_person_in.id,			q_event_person_in.web_user_id,			q_event_person_in.last_updated_by_data_file_id,			q_event_person_in.qevent_id,			q_event_person_in.created_dts,			q_event_person_in.updated_dts,			q_event_person_in.marked_for_deletion,			q_event_person_in.is_accountable,			q_event_person_in.send_email,			q_event_person_in.updated_by,			q_event_person_in.role_,			q_event_person_in.created_by               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.q_event_person_to_v1 (q_event_person_in q_event_person)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert q_event_person rows into the q_event_person_v1 compound type format using the following syntax:-- select q_event_person::q_event_person_v1 from q_event_personDROP CAST IF EXISTS (q_event_person as q_event_person_v1);CREATE CAST (q_event_person as q_event_person_v1) WITH FUNCTION types_plus.q_event_person_to_v1(q_event_person);