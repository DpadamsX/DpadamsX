﻿-- Create a view onto push_audit formatted as push_audit_plus.-- If push_audit changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_push_audit_plus.DROP VIEW IF EXISTS api.push_audit_plus CASCADE;-- Careful!CREATE OR REPLACE VIEW api.push_audit_plus AS select target.schema_name,        target.target_name,        target.unique_path,        target.target_type,        server.server_name_,        audit.start_local_dts,        audit.end_local_dts,        audit.end_utc_dts,        audit.inserted_utc_dts,        now() - audit.inserted_utc_dts AS age,        minutes_old (audit.inserted_utc_dts) as minutes_old,        audit.client_user_name,        audit.inserted_by,        audit.duration_seconds,        audit.records_count,        audit.version_number,        audit.error_occurred,        audit.push_method_name,        audit.error_text     from push_audit       auditleft join dba.push_target  target on target.id = audit.target_idleft join data_file_info   server on server.id = audit.data_file_id;ALTER TABLE api.push_audit_plus    OWNER TO user_change_structure;