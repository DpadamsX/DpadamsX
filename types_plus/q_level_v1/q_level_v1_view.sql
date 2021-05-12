﻿-- Create a view onto q_level formatted as q_level_v1.-- If q_level changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_q_level_v1.DROP VIEW IF EXISTS types_plus.q_level_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.q_level_v1 AS select id,        hsys_id,        last_updated_by_data_file_id,        created_dts,        updated_dts,        level_,        marked_for_deletion,        created_by,        updated_by,        name_,        ascendco_name   from q_level;ALTER TABLE types_plus.q_level_v1    OWNER TO user_change_structure;