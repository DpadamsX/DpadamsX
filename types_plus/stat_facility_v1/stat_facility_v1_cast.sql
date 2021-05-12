﻿-- Create a casting function to convert stat_facility rows into the compound type format stat_facility_v1.-- If stat_facility changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.stat_facility_to_v1 (stat_facility_in stat_facility)  RETURNS stat_facility_v1AS $BODY$        SELECT			stat_facility_in.id,			stat_facility_in.facility_id,			stat_facility_in.hsys_id,			stat_facility_in.date_,			stat_facility_in.category,			stat_facility_in.item_type,			stat_facility_in.stat_type,			stat_facility_in.is_most_recent,			stat_facility_in.in_data_cleanse_scope,			stat_facility_in.items_inactive,			stat_facility_in.items_count,			stat_facility_in.items_qty,			stat_facility_in.items_inventoried,			stat_facility_in.items_to_inventory,			stat_facility_in.items_named,			stat_facility_in.items_to_name,			stat_facility_in.inst_qty,			stat_facility_in.items_has_loc,			stat_facility_in.items_missing_locs,			stat_facility_in.item_prods_count,			stat_facility_in.item_prods_missing_part_nos_thier,			stat_facility_in.item_prods_missing_vendors_thier,			stat_facility_in.item_prods_dr_pref,			stat_facility_in.item_prods_critical,			stat_facility_in.item_prods_not_linked,			stat_facility_in.item_prods_missing_part_nos,			stat_facility_in.item_prods_missing_vendors,			stat_facility_in.item_prods_cant_determine,			stat_facility_in.item_prods_linked,			stat_facility_in.sup_prods_count,			stat_facility_in.sups_count,			stat_facility_in.prods_count,			stat_facility_in.prods_with_pic,			stat_facility_in.prods_without_pic,			stat_facility_in.item_prods_verified,			stat_facility_in.item_prods_expert_linked,			stat_facility_in.item_prods_dup_names_their,			stat_facility_in.item_prods_dup_names,			stat_facility_in.prods_named,			stat_facility_in.part_nos_fixed,			stat_facility_in.invs_inactive,			stat_facility_in.invs_count,			stat_facility_in.invs_found,			stat_facility_in.emr_items_count,			stat_facility_in.emr_items_linked,			stat_facility_in.emr_items_matches_their_name,			stat_facility_in.emr_items_matches_our_name,			stat_facility_in.emr_items_no_match_their_name,			stat_facility_in.emr_items_no_match_our_name,			stat_facility_in.emr_items_dups$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.stat_facility_to_v1 (stat_facility_in stat_facility) OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert stat_facility rows into the stat_facility_v1 compound type format using the following syntax:-- select stat_facility::stat_facility_v1 from stat_facilityDROP CAST IF EXISTS (stat_facility as stat_facility_v1);CREATE CAST (stat_facility as stat_facility_v1) WITH FUNCTION types_plus.stat_facility_to_v1(stat_facility);