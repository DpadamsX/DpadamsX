﻿-- Create a view onto loaner_item formatted as loaner_item_v1.-- If loaner_item changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_loaner_item_v1.DROP VIEW IF EXISTS types_plus.loaner_item_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.loaner_item_v1 AS select id,        loaner_id,        item_id,        last_updated_by_data_file_id,        updated_dts,        created_dts,        left_behind_qty,        qty,        pickup_qty,        marked_for_deletion,        updated_by,        created_by   from loaner_item;ALTER TABLE types_plus.loaner_item_v1    OWNER TO user_change_structure;