﻿types_plus.analytic_productivity_v1 is both an updatable view, and a type.	id uuid,	data_file_id uuid,	marked_for_deletion boolean,	hsys_id uuid,	facility_id uuid,	facility_location_id uuid,	specialty_id uuid,	item_type_id uuid,	user_name citext,	inv_name citext,	item_name citext,	tray_or_pack citext,	num_inst integer,	assembly_minutes integer,	pause_minutes integer,	points integer,	points_per_hour double precision,	assembly_hour double precision,	pause_hour double precision,	start_utc timestamp with time zone,	start_local timestamp with time zone,	end_utc timestamp with time zone,	end_local timestamp with time zone