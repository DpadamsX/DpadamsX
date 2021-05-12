﻿-- Create a view onto edge formatted as edge_v1.-- If edge changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_edge_v1.DROP VIEW IF EXISTS types_plus.edge_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.edge_v1 AS select id,        inv_id,        from_scan_at_facility_id,        from_associated_to_id,        to_associated_to_id,        from_web_user_id,        from_assembly_id,        from_scan_id,        from_sterilizer_load_id,        from_facility_location_id,        from_facility_id,        from_washer_load_id,        from_scase_id,        from_clinic_id,        from_facility_department_id,        hsys_id,        to_scan_id,        to_scan_at_facility_id,        to_web_user_id,        to_facility_location_id,        to_sterilizer_load_id,        to_washer_load_id,        to_facility_id,        to_scase_id,        to_clinic_id,        to_facility_department_id,        to_assembly_id,        num_inst,        seconds,        from_node_dts,        to_node_dts,        created_dts,        updated_dts,        sequence_,        from_node,        to_node,        from_to_node,        from_associated_to,        to_associated_to,        from_user_name,        source_,        is_fake,        to_user_name   from edge;ALTER TABLE types_plus.edge_v1    OWNER TO user_change_structure;-- Create a casting function to convert edge rows into the compound type format edge_v1.-- If edge changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.edge_to_v1 (edge_in edge)  RETURNS edge_v1AS $BODY$                   SELECT			edge_in.id,			edge_in.inv_id,			edge_in.from_scan_at_facility_id,			edge_in.from_associated_to_id,			edge_in.to_associated_to_id,			edge_in.from_web_user_id,			edge_in.from_assembly_id,			edge_in.from_scan_id,			edge_in.from_sterilizer_load_id,			edge_in.from_facility_location_id,			edge_in.from_facility_id,			edge_in.from_washer_load_id,			edge_in.from_scase_id,			edge_in.from_clinic_id,			edge_in.from_facility_department_id,			edge_in.hsys_id,			edge_in.to_scan_id,			edge_in.to_scan_at_facility_id,			edge_in.to_web_user_id,			edge_in.to_facility_location_id,			edge_in.to_sterilizer_load_id,			edge_in.to_washer_load_id,			edge_in.to_facility_id,			edge_in.to_scase_id,			edge_in.to_clinic_id,			edge_in.to_facility_department_id,			edge_in.to_assembly_id,			edge_in.num_inst,			edge_in.seconds,			edge_in.from_node_dts,			edge_in.to_node_dts,			edge_in.created_dts,			edge_in.updated_dts,			edge_in.sequence_,			edge_in.from_node,			edge_in.to_node,			edge_in.from_to_node,			edge_in.from_associated_to,			edge_in.to_associated_to,			edge_in.from_user_name,			edge_in.source_,			edge_in.is_fake,			edge_in.to_user_name               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.edge_to_v1 (edge_in edge)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert edge rows into the edge_v1 compound type format using the following syntax:-- select edge::edge_v1 from edgeDROP CAST IF EXISTS (edge as edge_v1);CREATE CAST (edge as edge_v1) WITH FUNCTION types_plus.edge_to_v1(edge);-- Create a function to accept an array of rows formatted as edge_v1 for UPSERT into edge.DROP FUNCTION IF EXISTS types_plus.insert_edge_v1 (types_plus.edge_v1[]);  CREATE OR REPLACE FUNCTION types_plus.insert_edge_v1 (data_in types_plus.edge_v1[])  RETURNS intAS $BODY$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO edge (			id,			inv_id,			from_scan_at_facility_id,			from_associated_to_id,			to_associated_to_id,			from_web_user_id,			from_assembly_id,			from_scan_id,			from_sterilizer_load_id,			from_facility_location_id,			from_facility_id,			from_washer_load_id,			from_scase_id,			from_clinic_id,			from_facility_department_id,			hsys_id,			to_scan_id,			to_scan_at_facility_id,			to_web_user_id,			to_facility_location_id,			to_sterilizer_load_id,			to_washer_load_id,			to_facility_id,			to_scase_id,			to_clinic_id,			to_facility_department_id,			to_assembly_id,			num_inst,			seconds,			from_node_dts,			to_node_dts,			created_dts,			updated_dts,			sequence_,			from_node,			to_node,			from_to_node,			from_associated_to,			to_associated_to,			from_user_name,			source_,			is_fake,			to_user_name)                  SELECT			rows_in.id,			rows_in.inv_id,			rows_in.from_scan_at_facility_id,			rows_in.from_associated_to_id,			rows_in.to_associated_to_id,			rows_in.from_web_user_id,			rows_in.from_assembly_id,			rows_in.from_scan_id,			rows_in.from_sterilizer_load_id,			rows_in.from_facility_location_id,			rows_in.from_facility_id,			rows_in.from_washer_load_id,			rows_in.from_scase_id,			rows_in.from_clinic_id,			rows_in.from_facility_department_id,			rows_in.hsys_id,			rows_in.to_scan_id,			rows_in.to_scan_at_facility_id,			rows_in.to_web_user_id,			rows_in.to_facility_location_id,			rows_in.to_sterilizer_load_id,			rows_in.to_washer_load_id,			rows_in.to_facility_id,			rows_in.to_scase_id,			rows_in.to_clinic_id,			rows_in.to_facility_department_id,			rows_in.to_assembly_id,			rows_in.num_inst,			rows_in.seconds,			rows_in.from_node_dts,			rows_in.to_node_dts,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.sequence_,			rows_in.from_node,			rows_in.to_node,			rows_in.from_to_node,			rows_in.from_associated_to,			rows_in.to_associated_to,			rows_in.from_user_name,			rows_in.source_,			rows_in.is_fake,			rows_in.to_user_name                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			inv_id = EXCLUDED.inv_id,			from_scan_at_facility_id = EXCLUDED.from_scan_at_facility_id,			from_associated_to_id = EXCLUDED.from_associated_to_id,			to_associated_to_id = EXCLUDED.to_associated_to_id,			from_web_user_id = EXCLUDED.from_web_user_id,			from_assembly_id = EXCLUDED.from_assembly_id,			from_scan_id = EXCLUDED.from_scan_id,			from_sterilizer_load_id = EXCLUDED.from_sterilizer_load_id,			from_facility_location_id = EXCLUDED.from_facility_location_id,			from_facility_id = EXCLUDED.from_facility_id,			from_washer_load_id = EXCLUDED.from_washer_load_id,			from_scase_id = EXCLUDED.from_scase_id,			from_clinic_id = EXCLUDED.from_clinic_id,			from_facility_department_id = EXCLUDED.from_facility_department_id,			hsys_id = EXCLUDED.hsys_id,			to_scan_id = EXCLUDED.to_scan_id,			to_scan_at_facility_id = EXCLUDED.to_scan_at_facility_id,			to_web_user_id = EXCLUDED.to_web_user_id,			to_facility_location_id = EXCLUDED.to_facility_location_id,			to_sterilizer_load_id = EXCLUDED.to_sterilizer_load_id,			to_washer_load_id = EXCLUDED.to_washer_load_id,			to_facility_id = EXCLUDED.to_facility_id,			to_scase_id = EXCLUDED.to_scase_id,			to_clinic_id = EXCLUDED.to_clinic_id,			to_facility_department_id = EXCLUDED.to_facility_department_id,			to_assembly_id = EXCLUDED.to_assembly_id,			num_inst = EXCLUDED.num_inst,			seconds = EXCLUDED.seconds,			from_node_dts = EXCLUDED.from_node_dts,			to_node_dts = EXCLUDED.to_node_dts,			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			sequence_ = EXCLUDED.sequence_,			from_node = EXCLUDED.from_node,			to_node = EXCLUDED.to_node,			from_to_node = EXCLUDED.from_to_node,			from_associated_to = EXCLUDED.from_associated_to,			to_associated_to = EXCLUDED.to_associated_to,			from_user_name = EXCLUDED.from_user_name,			source_ = EXCLUDED.source_,			is_fake = EXCLUDED.is_fake,			to_user_name = EXCLUDED.to_user_name          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.insert_edge_v1(types_plus.edge_v1[])	OWNER TO user_bender;