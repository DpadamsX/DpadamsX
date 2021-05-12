﻿-- Create a casting function to convert clinic rows into the compound type format clinic_v1.-- If clinic changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.clinic_to_v1 (clinic_in clinic)  RETURNS clinic_v1AS $BODY$                   SELECT			clinic_in.id,			clinic_in.hsys_id,			clinic_in.created_dts,			clinic_in.updated_dts,			clinic_in.marked_for_deletion,			clinic_in.receive_at_clinic,			clinic_in.name_,			clinic_in.created_by,			clinic_in.updated_by               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.clinic_to_v1 (clinic_in clinic)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert clinic rows into the clinic_v1 compound type format using the following syntax:-- select clinic::clinic_v1 from clinicDROP CAST IF EXISTS (clinic as clinic_v1);CREATE CAST (clinic as clinic_v1) WITH FUNCTION types_plus.clinic_to_v1(clinic);