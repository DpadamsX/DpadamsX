﻿-- Create a view onto facility_activities formatted as facility_activities_v1.-- If facility_activities changes, you can update the view to handle the modification smoothly.-- Note: This view is automatically a custom type, with an array type to match. See types_plus.insert_facility_activities_v1.DROP VIEW IF EXISTS types_plus.facility_activities_v1 CASCADE;-- Careful!CREATE OR REPLACE VIEW types_plus.facility_activities_v1 AS select id,        facility_id,        last_updated_by_data_file_id,        created_dts,        updated_dts,        marked_for_deletion,        name_,        created_by,        updated_by   from facility_activities;ALTER TABLE types_plus.facility_activities_v1    OWNER TO user_change_structure;