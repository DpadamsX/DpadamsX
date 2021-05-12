﻿-- Create a view onto sterilize_params formatted as sterilize_params_v1.-- If sterilize_params changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_sterilize_params_v1.DROP VIEW IF EXISTS types_plus.sterilize_params_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.sterilize_params_v1 AS select id,        data_file_id,        marked_for_deletion,        hsys_id,        sterilize_method_id,        name_   from sterilize_params;ALTER TABLE types_plus.sterilize_params_v1    OWNER TO user_change_structure;