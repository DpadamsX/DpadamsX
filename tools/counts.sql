with counts as (		select 'activity',                            count(*) from activity union all		select 'analytic_productivity',               count(*) from analytic_productivity union all		select 'analytic_scan',                       count(*) from analytic_scan union all		select 'analytic_sterilizer_load',            count(*) from analytic_sterilizer_load union all		select 'analytic_sterilizer_loadinv',         count(*) from analytic_sterilizer_loadinv union all		select 'analytic_work',                       count(*) from analytic_work union all		select 'assembly',                            count(*) from assembly union all		select 'assembly_prods',                      count(*) from assembly_prods union all		select 'calendar',                            count(*) from calendar union all		select 'calendar_day',                        count(*) from calendar_day union all		select 'calendar_year',                       count(*) from calendar_year union all		select 'clinic',                              count(*) from clinic union all		select 'data_file_info',                      count(*) from data_file_info union all		select 'deletion_log',                        count(*) from deletion_log union all		select 'domo_dataset',                        count(*) from domo_dataset union all		select 'domo_passthrough',                    count(*) from domo_passthrough union all		select 'error_code',                          count(*) from error_code union all	--	select 'error_log',                           count(*) from error_log union all		select 'facility',                            count(*) from facility union all		select 'facility_activities',                 count(*) from facility_activities union all		select 'facility_department',                 count(*) from facility_department union all		select 'facility_location',                   count(*) from facility_location union all		select 'focus',                               count(*) from focus union all		select 'form_template',                       count(*) from form_template union all		select 'hsys',                                count(*) from hsys union all		select 'iceberg_table',                       count(*) from iceberg_table union all		select 'inv',                                 count(*) from inv union all		select 'item',                                count(*) from item union all		select 'item_arch',                           count(*) from item_arch union all		select 'item_type',                           count(*) from item_type union all		select 'loaner',                              count(*) from loaner union all		select 'loaner_case',                         count(*) from loaner_case union all		select 'loaner_item',                         count(*) from loaner_item union all		select 'loaner_iteminv',                      count(*) from loaner_iteminv union all		select 'need',                                count(*) from need union all		select 'outlier_change',                      count(*) from outlier_change union all		select 'outlier_rule',                        count(*) from outlier_rule union all		select 'print_job',                           count(*) from print_job union all		select 'productivity_detail',                 count(*) from productivity_detail union all		select 'push_log',                            count(*) from push_log union all		select 'q_audit_step',                        count(*) from q_audit_step union all		select 'q_event',                             count(*) from q_event union all		select 'q_event_audit_step',                  count(*) from q_event_audit_step union all		select 'q_event_person',                      count(*) from q_event_person union all		select 'q_level',                             count(*) from q_level union all		select 'q_subtype',                           count(*) from q_subtype union all		select 'q_type',                              count(*) from q_type union all		select 'rcl_check',                           count(*) from rcl_check union all		select 'rcl_id',                              count(*) from rcl_id union all	--	select 'record_changes_log',                  count(*) from record_changes_log union all	--	select 'record_changes_log_detail',           count(*) from record_changes_log_detail union all		select 'rep',                                 count(*) from rep union all		select 'row_compare',                         count(*) from row_compare union all		select 'specialty',                           count(*) from specialty union all		select 'stat_facility',                       count(*) from stat_facility union all		select 'sterilize_method',                    count(*) from sterilize_method union all		select 'sterilize_params',                    count(*) from sterilize_params union all		select 'sterilizer',                          count(*) from sterilizer union all		select 'sterilizer_load',                     count(*) from sterilizer_load union all		select 'sterilizer_log',                      count(*) from sterilizer_log union all		select 'sup',                                 count(*) from sup union all		select 'sup_parent',                          count(*) from sup_parent union all	--	select 'text_collection',                     count(*) from text_collection union all	--	select 'text_collection_item',                count(*) from text_collection_item union all		select 'web_user',                            count(*) from web_user		order by 1)	select * from counts union all	select 'TOTAL', sum(count) from counts