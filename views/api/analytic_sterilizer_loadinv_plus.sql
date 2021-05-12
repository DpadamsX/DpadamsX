DROP VIEW IF EXISTS api.analytic_sterilizer_loadinv_plus;CREATE OR REPLACE VIEW api.analytic_sterilizer_loadinv_plus ASSELECT 	analytic_sterilizer_loadinv.id, 	analytic_sterilizer_loadinv.item_id,    analytic_sterilizer_loadinv.data_file_id,    analytic_sterilizer_loadinv.marked_for_deletion,    analytic_sterilizer_loadinv.facility_id,    analytic_sterilizer_loadinv.hsys_id,    analytic_sterilizer_loadinv.item_type_id,    analytic_sterilizer_loadinv.speciality_id,    analytic_sterilizer_loadinv.sterilize_method_id,    analytic_sterilizer_loadinv.sterilize_params_id,    analytic_sterilizer_loadinv.sterilizer_id,    analytic_sterilizer_loadinv.web_user_id,    analytic_sterilizer_loadinv.inv_name_provided,    analytic_sterilizer_loadinv.is_iuss,    greatest(1,analytic_sterilizer_loadinv.num_inst) AS num_inst, -- Get rid of 0, just like in Domo view.    (greatest(1,analytic_sterilizer_loadinv.num_inst) * analytic_sterilizer_loadinv.qty) AS num_inst_extended, -- Calculate extended count.    analytic_sterilizer_loadinv.qty,    analytic_sterilizer_loadinv.category,    analytic_sterilizer_loadinv.clinic_dept_name,    analytic_sterilizer_loadinv.status, -- Dec 24, 2020    analytic_sterilizer_loadinv.done_dts,    analytic_sterilizer_loadinv.done_local_dts,    analytic_sterilizer_loadinv.processing_seconds,    /* Lookup fields */    sterilize_method.name_ AS method_name,    sterilize_params.name_ AS params_name,    sterilizer.name_ AS sterilizer_name,    facility.name_ AS facility_name,    facility.tz_name,    data_file_info.server_name_,    web_user.name_full,    hsys.name_ AS hsys_name,    inv.their_name AS "inv_their_name",    item.name_ AS "item_name",    specialty.name_ AS specialty_name,    COALESCE(item_type.name_,'') AS item_type_name /* We dont' always have a related item_type.*/   	FROM analytic_sterilizer_loadinv	LEFT JOIN sterilize_method ON (analytic_sterilizer_loadinv.sterilize_method_id = sterilize_method.id)	LEFT JOIN sterilize_params ON (analytic_sterilizer_loadinv.sterilize_params_id = sterilize_params.id)	LEFT JOIN sterilizer 	   ON (analytic_sterilizer_loadinv.sterilizer_id  	  = sterilizer.id)	LEFT JOIN facility 		   ON (analytic_sterilizer_loadinv.facility_id		  = facility.id)	LEFT JOIN data_file_info   ON (analytic_sterilizer_loadinv.data_file_id	 	  = data_file_info.id)	LEFT JOIN web_user 	   	   ON (analytic_sterilizer_loadinv.web_user_id		  = web_user.id)	LEFT JOIN hsys			   ON (analytic_sterilizer_loadinv.hsys_id 			  = hsys.id)	LEFT JOIN inv	 	   	   ON (analytic_sterilizer_loadinv.inv_id			  = inv.id)	LEFT JOIN item	 	   	   ON (analytic_sterilizer_loadinv.item_id			  = item.id)	LEFT JOIN specialty 	   ON (analytic_sterilizer_loadinv.speciality_id	  = specialty.id)	LEFT JOIN item_type 	   ON (analytic_sterilizer_loadinv.item_type_id		  = item_type.id) /* We dont' always have a related item_type.*/	;ALTER VIEW api.analytic_sterilizer_loadinv_plus    OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','analytic_sterilizer_loadinv_plus','Analytic data derived largely from [SterilizerLoad_Inv].');