﻿-- Create a view onto push_audit formatted as push_audit_v2.-- If push_audit changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_push_audit_v2.DROP VIEW IF EXISTS types_plus.push_audit_v2 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.push_audit_v2 AS select id,        target_id,        data_file_id,        pg_config_target_version_id,        start_local_dts,        end_utc_dts,        end_local_dts,        inserted_utc_dts,        first_con_id,        last_con_id,        records_count,        duration_seconds,        error_occurred,        client_user_name,        inserted_by,        push_method_name,        error_text,        result_text   from push_audit;ALTER TABLE types_plus.push_audit_v2    OWNER TO user_change_structure;