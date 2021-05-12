﻿-- Create a view onto q_type formatted as q_type_v1.-- If q_type changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_q_type_v1.DROP VIEW IF EXISTS types_plus.q_type_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.q_type_v1 AS select id,        hsys_id,        last_updated_by_data_file_id,        created_dts,        updated_dts,        marked_for_deletion,        is_active,        updated_by,        created_by,        ascendco_name,        name_,        type_   from q_type;ALTER TABLE types_plus.q_type_v1    OWNER TO user_change_structure;