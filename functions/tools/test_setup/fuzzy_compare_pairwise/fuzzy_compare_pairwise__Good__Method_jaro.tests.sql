﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_compare_pairwise', '(jsonb, jsonb, real, citext)', 'fuzzy_compare_pairwise: Good: Method jaro', 'select *  from fuzzy_compare_pairwise(''[	{"text":"Fuzzy Green Bunny","id":"1"},	{"text":"Small Red Squirrel","id":"2"} ]'',''[	{"text":"Red Large Special","id":"3"},	{"text":"Blue Small","id":"4"},	{"text":"Green Medium Special","id":"5"} ]'', 0.3,''jaro'');', 'Fuzzy Green Bunny	Red Large Special	1	3	0.479197	monge_elkan_quadratic	0.239151	0.489031	0	0	0.457516	0.457516	0.058824	0.22963	0.479197	0.22963	0.479197	0	0Small Red Squirrel	Blue Small	2	4	0.726483	monge_elkan_quadratic	0.451847	0.672195	0.26087	0	0.623148	0.623148	0.277778	0.527778	0.726483	0.452778	0.651483	0.375	0.26087', '', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');