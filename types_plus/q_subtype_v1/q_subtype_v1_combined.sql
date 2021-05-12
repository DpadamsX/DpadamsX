﻿-- Create a view onto q_subtype formatted as q_subtype_v1.-- If q_subtype changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_q_subtype_v1.DROP VIEW IF EXISTS types_plus.q_subtype_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.q_subtype_v1 AS select id,        qtype_id,        qlevel_id,        facility_group_id,        facility_id,        hsys_id,        last_updated_by_data_file_id,        created_dts,        updated_dts,        is_available_in_assembly,        is_available_in_decon,        marked_for_deletion,        is_for_inv,        is_active,        ascendco_name,        updated_by,        type_,        available_for,        created_by,        name_,        item_type_ids   from q_subtype;ALTER TABLE types_plus.q_subtype_v1    OWNER TO user_change_structure;-- Create a casting function to convert q_subtype rows into the compound type format q_subtype_v1.-- If q_subtype changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.q_subtype_to_v1 (q_subtype_in q_subtype)  RETURNS q_subtype_v1AS $BODY$        SELECT			q_subtype_in.id,			q_subtype_in.qtype_id,			q_subtype_in.qlevel_id,			q_subtype_in.facility_group_id,			q_subtype_in.facility_id,			q_subtype_in.hsys_id,			q_subtype_in.last_updated_by_data_file_id,			q_subtype_in.created_dts,			q_subtype_in.updated_dts,			q_subtype_in.is_available_in_assembly,			q_subtype_in.is_available_in_decon,			q_subtype_in.marked_for_deletion,			q_subtype_in.is_for_inv,			q_subtype_in.is_active,			q_subtype_in.ascendco_name,			q_subtype_in.updated_by,			q_subtype_in.type_,			q_subtype_in.available_for,			q_subtype_in.created_by,			q_subtype_in.name_,			q_subtype_in.item_type_ids$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.q_subtype_to_v1 (q_subtype_in q_subtype)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert q_subtype rows into the q_subtype_v1 compound type format using the following syntax:-- select q_subtype::q_subtype_v1 from q_subtypeDROP CAST IF EXISTS (q_subtype as q_subtype_v1);CREATE CAST (q_subtype as q_subtype_v1) WITH FUNCTION types_plus.q_subtype_to_v1(q_subtype);-- Create a function to accept an array of rows formatted as q_subtype_v1 for UPSERT into q_subtype.DROP FUNCTION IF EXISTS types_plus.insert_q_subtype_v1 (types_plus.q_subtype_v1[]);CREATE OR REPLACE FUNCTION types_plus.insert_q_subtype_v1 (data_in types_plus.q_subtype_v1[])  RETURNS intAS $BODY$-- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO q_subtype (			id,			qtype_id,			qlevel_id,			facility_group_id,			facility_id,			hsys_id,			last_updated_by_data_file_id,			created_dts,			updated_dts,			is_available_in_assembly,			is_available_in_decon,			marked_for_deletion,			is_for_inv,			is_active,			ascendco_name,			updated_by,			type_,			available_for,			created_by,			name_,			item_type_ids)        SELECT			rows_in.id,			rows_in.qtype_id,			rows_in.qlevel_id,			rows_in.facility_group_id,			rows_in.facility_id,			rows_in.hsys_id,			rows_in.last_updated_by_data_file_id,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.is_available_in_assembly,			rows_in.is_available_in_decon,			rows_in.marked_for_deletion,			rows_in.is_for_inv,			rows_in.is_active,			rows_in.ascendco_name,			rows_in.updated_by,			rows_in.type_,			rows_in.available_for,			rows_in.created_by,			rows_in.name_,			rows_in.item_type_ids        FROM unnest(data_in) as rows_in        ON CONFLICT(id) DO UPDATE SET			qtype_id = EXCLUDED.qtype_id,			qlevel_id = EXCLUDED.qlevel_id,			facility_group_id = EXCLUDED.facility_group_id,			facility_id = EXCLUDED.facility_id,			hsys_id = EXCLUDED.hsys_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			is_available_in_assembly = EXCLUDED.is_available_in_assembly,			is_available_in_decon = EXCLUDED.is_available_in_decon,			marked_for_deletion = EXCLUDED.marked_for_deletion,			is_for_inv = EXCLUDED.is_for_inv,			is_active = EXCLUDED.is_active,			ascendco_name = EXCLUDED.ascendco_name,			updated_by = EXCLUDED.updated_by,			type_ = EXCLUDED.type_,			available_for = EXCLUDED.available_for,			created_by = EXCLUDED.created_by,			name_ = EXCLUDED.name_,			item_type_ids = EXCLUDED.item_type_ids        returning 1 as row_counter)    select sum(row_counter)::integer from inserted_rows;$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.insert_q_subtype_v1(types_plus.q_subtype_v1[])	OWNER TO user_bender;