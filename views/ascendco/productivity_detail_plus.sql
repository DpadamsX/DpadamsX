DROP VIEW IF EXISTS ascendco.productivity_detail_plus;CREATE OR REPLACE VIEW ascendco.productivity_detail_plus AS   SELECT		    data_file_info.server_name_ AS "server_name",		    hsys.name_ AS hsys_name,		    facility.name_ AS facility_name,		    iceberg_table.table_name as source_table_name,			productivity_detail.user_label, -- We have user_id and can join over to web_user, if that's better.			productivity_detail.start_time_dts,			productivity_detail.start_date,			productivity_detail.time_label,			productivity_detail.duration,			productivity_detail.year_and_month, -- This is the partition key			productivity_detail.assembly_inst,			productivity_detail.assembly_pack,			productivity_detail.assembly_tray,			productivity_detail.assembly_points,			productivity_detail.assembly_seconds_trays,			productivity_detail.assembly_seconds_overall,			productivity_detail.pause_seconds,			productivity_detail.pause_time,			productivity_detail.duration_seconds,			productivity_detail.description,			productivity_detail.activity,			-- Source IDs			productivity_detail.facility_id,			productivity_detail.user_id,			productivity_detail.data_file_id,			productivity_detail.source_table_number,			productivity_detail.id AS source_record_id,			productivity_detail.source_record_row_counter    FROM  productivity_detailLEFT JOIN ascendco.iceberg_table  ON (productivity_detail.source_table_number = iceberg_table.table_number)LEFT JOIN ascendco.facility       ON (productivity_detail.facility_id         = facility.id)LEFT JOIN ascendco.hsys           ON (hsys.id                                 = facility.hsys_id)LEFT JOIN ascendco.data_file_info ON (productivity_detail.data_file_id        = data_file_info.id);ALTER VIEW ascendco.productivity_detail_plus    OWNER TO user_change_structure;----------------------------------------------- Register view---------------------------------------------CALL view_register ('ascendco','productivity_detail_plus','productivity_detail data, with lookup values.');