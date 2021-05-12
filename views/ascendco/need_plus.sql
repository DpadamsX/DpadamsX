﻿CREATE OR REPLACE VIEW ascendco.need_plus AS   SELECT need.id,          need.hsys_id,          need.facility_id,          need.item_id,          item.name_ AS item_name,          facility.name_ AS facility_name,          hsys.name_ AS hsys_name,          need.percent_down,          need.created_dts,          need.next_case_dts,          need.flow,          need.qty_circulation,          need.qty_ready_everywhere,          need.qty_ready_here,          need.qty_sched_everywhere,          need.qty_sched_here,          need.qty_sterile_everywhere,          need.qty_sterile_here,          need.qty_suggest_sterilize,          need.qty_total,          need.qty_here,          need.ready_vs_need_defecit,          need.sched_sort,          need.sort_rank,          need.suggest_transport,          need.next_needed,          need.or_name,          need.status,          need.status_sort,          need.when_     FROM needLEFT JOIN item     ON (item.id     = need.item_id)LEFT JOIN facility ON (facility.id = need.facility_id)LEFT JOIN hsys     ON (hsys.id     = need.hsys_id);ALTER VIEW ascendco.need_plus    OWNER TO user_change_structure;----------------------------------------------- Register view---------------------------------------------CALL view_register ('ascendco','need_plus','need data, with lookup values.');