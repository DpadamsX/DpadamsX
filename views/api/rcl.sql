CREATE OR REPLACE VIEW api.rcl ASSELECT	record_changes_log.id,	record_changes_log.table_number,	record_changes_log.record_id,	record_changes_log.updated_dts,	record_changes_log.updated_by,	record_changes_log.app_type,	record_changes_log.machine_nameFROM record_changes_log;ALTER VIEW api.rcl    OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','rcl','The record_change_log (parent) event, which  may have any number of related details.');