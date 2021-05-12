﻿-- Create a casting function to convert edge rows into the compound type format edge_v1.-- If edge changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.edge_to_v1 (edge_in edge)  RETURNS edge_v1AS $BODY$                   SELECT			edge_in.id,			edge_in.inv_id,			edge_in.from_scan_at_facility_id,			edge_in.from_associated_to_id,			edge_in.to_associated_to_id,			edge_in.from_web_user_id,			edge_in.from_assembly_id,			edge_in.from_scan_id,			edge_in.from_sterilizer_load_id,			edge_in.from_facility_location_id,			edge_in.from_facility_id,			edge_in.from_washer_load_id,			edge_in.from_scase_id,			edge_in.from_clinic_id,			edge_in.from_facility_department_id,			edge_in.hsys_id,			edge_in.to_scan_id,			edge_in.to_scan_at_facility_id,			edge_in.to_web_user_id,			edge_in.to_facility_location_id,			edge_in.to_sterilizer_load_id,			edge_in.to_washer_load_id,			edge_in.to_facility_id,			edge_in.to_scase_id,			edge_in.to_clinic_id,			edge_in.to_facility_department_id,			edge_in.to_assembly_id,			edge_in.num_inst,			edge_in.seconds,			edge_in.from_node_dts,			edge_in.to_node_dts,			edge_in.created_dts,			edge_in.updated_dts,			edge_in.sequence_,			edge_in.from_node,			edge_in.to_node,			edge_in.from_to_node,			edge_in.from_associated_to,			edge_in.to_associated_to,			edge_in.from_user_name,			edge_in.source_,			edge_in.is_fake,			edge_in.to_user_name               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.edge_to_v1 (edge_in edge)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert edge rows into the edge_v1 compound type format using the following syntax:-- select edge::edge_v1 from edgeDROP CAST IF EXISTS (edge as edge_v1);CREATE CAST (edge as edge_v1) WITH FUNCTION types_plus.edge_to_v1(edge);