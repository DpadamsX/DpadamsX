﻿-- Create a casting function to convert hsys rows into the compound type format hsys_v1.-- If hsys changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.hsys_to_v1 (hsys_in hsys)  RETURNS hsys_v1AS $BODY$        SELECT			hsys_in.id,			hsys_in.marked_for_deletion,			hsys_in.name_$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.hsys_to_v1 (hsys_in hsys) OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert hsys rows into the hsys_v1 compound type format using the following syntax:-- select hsys::hsys_v1 from hsysDROP CAST IF EXISTS (hsys as hsys_v1);CREATE CAST (hsys as hsys_v1) WITH FUNCTION types_plus.hsys_to_v1(hsys);