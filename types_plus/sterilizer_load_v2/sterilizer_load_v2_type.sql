﻿types_plus.sterilizer_load_v2 is both an updatable view, and a type.	id uuid,	data_file_id uuid,	marked_for_deletion boolean,	sterilize_method_id uuid,	sterilizer_id uuid,	sterilize_params_id uuid,	created_dts timestamp with time zone,	load_no citext,	status_building_dts timestamp with time zone,	status_sterilizing_dts timestamp with time zone,	status_cooling_dts timestamp with time zone,	status_done_dts timestamp with time zone,	notes citext,	failed_notes citext,	utcoffset_seconds integer