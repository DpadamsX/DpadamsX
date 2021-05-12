﻿-- Create a view onto clinic formatted as clinic_v1.-- If clinic changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_clinic_v1.DROP VIEW IF EXISTS types_plus.clinic_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.clinic_v1 AS select id,        hsys_id,        created_dts,        updated_dts,        marked_for_deletion,        receive_at_clinic,        name_,        created_by,        updated_by   from clinic;ALTER TABLE types_plus.clinic_v1    OWNER TO user_change_structure;