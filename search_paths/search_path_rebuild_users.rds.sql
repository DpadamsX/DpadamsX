﻿-- Log in as rds_super to run this script.-- Cleanup any modifications made on the USER level specifically on nautilusALTER USER postgres IN DATABASE nautilus RESET search_path;ALTER USER rds_super IN DATABASE nautilus RESET search_path;ALTER USER user_admin IN DATABASE nautilus RESET search_path;ALTER USER user_bender IN DATABASE nautilus RESET search_path;ALTER USER user_change_structure IN DATABASE nautilus RESET search_path;ALTER USER user_cleanup IN DATABASE nautilus RESET search_path;ALTER USER user_domo_pull IN DATABASE nautilus RESET search_path;ALTER USER user_iceberg IN DATABASE nautilus RESET search_path;ALTER USER user_iceberg_remote IN DATABASE nautilus RESET search_path;ALTER USER user_leviathan IN DATABASE nautilus RESET search_path;ALTER USER user_reporting IN DATABASE nautilus RESET search_path;ALTER USER user_saws IN DATABASE nautilus RESET search_path;ALTER USER user_sonar IN DATABASE nautilus RESET search_path;-- Cleanup any modifications made on the USER level specifically on squidALTER USER postgres IN DATABASE squid RESET search_path;ALTER USER rds_super IN DATABASE squid RESET search_path;ALTER USER user_admin IN DATABASE squid RESET search_path;ALTER USER user_bender IN DATABASE squid RESET search_path;ALTER USER user_change_structure IN DATABASE squid RESET search_path;ALTER USER user_cleanup IN DATABASE squid RESET search_path;ALTER USER user_domo_pull IN DATABASE squid RESET search_path;ALTER USER user_iceberg IN DATABASE squid RESET search_path;ALTER USER user_iceberg_remote IN DATABASE squid RESET search_path;ALTER USER user_leviathan IN DATABASE squid RESET search_path;ALTER USER user_reporting IN DATABASE squid RESET search_path;ALTER USER user_saws IN DATABASE squid RESET search_path;ALTER USER user_sonar IN DATABASE squid RESET search_path;-- Set globally for the cluster (all databases) as we've got the same schemas everywhere.ALTER USER postgres SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough, analytics, event_triggers, dba;ALTER USER rds_super SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough, analytics, event_triggers, dba;ALTER USER user_admin SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough, analytics, event_triggers, dba;ALTER USER user_bender SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_change_structure SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_cleanup SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_domo_pull SET search_path TO api, api_queries, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_iceberg SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_iceberg_remote SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_leviathan SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_reporting SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_saws SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;ALTER USER user_sonar SET search_path TO api, api_queries, ascendco, domains, extensions, tools, types, types_plus, passthrough;