﻿-- Create a casting function to convert web_user rows into the compound type format web_user_v1.-- If web_user changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.web_user_to_v1 (web_user_in web_user)  RETURNS web_user_v1AS $BODY$                   SELECT			web_user_in.id,			web_user_in.data_file_id,			web_user_in.marked_for_deletion,			web_user_in.hsys_id,			web_user_in.username,			web_user_in.role_,			web_user_in.name_first,			web_user_in.name_last,			web_user_in.name_full               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.web_user_to_v1 (web_user_in web_user) OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert web_user rows into the web_user_v1 compound type format using the following syntax:-- select web_user::web_user_v1 from web_userDROP CAST IF EXISTS (web_user as web_user_v1);CREATE CAST (web_user as web_user_v1) WITH FUNCTION types_plus.web_user_to_v1(web_user);