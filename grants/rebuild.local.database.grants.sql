﻿-------------------------------------------------------------------------------- REGRANT CONNECT.-------------------------------------------------------------------------------- REVOKE ALL.REVOKE ALL PRIVILEGES ON DATABASE squid FROM PUBLIC; -- Clear out the magic PUBLIC pseudo-user.REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_admins;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_api_users;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_cleanup;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_developers;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_iceberg;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_leviathan;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_reporting_super;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_saws;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_server_bots;REVOKE ALL PRIVILEGES ON DATABASE squid FROM group_sonar;REVOKE ALL PRIVILEGES ON DATABASE squid FROM rdsadmin;REVOKE ALL PRIVILEGES ON DATABASE squid FROM rds_super;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_admin;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_backup;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_bender;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_change_structure;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_cleanup;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_domo_pull;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_iceberg;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_iceberg_remote;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_saws;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_reporting;REVOKE ALL PRIVILEGES ON DATABASE squid FROM user_sonar;-- GRANT CONNECT and CREATE, as appropriate.GRANT CONNECT, CREATE ON DATABASE squid TO rdsadmin;GRANT CONNECT, CREATE ON DATABASE squid TO rds_super;GRANT CONNECT, CREATE ON DATABASE squid TO user_admin;GRANT CONNECT ON DATABASE squid TO user_backup;GRANT CONNECT, CREATE ON DATABASE squid TO user_bender;GRANT CONNECT, CREATE ON DATABASE squid TO user_change_structure;GRANT CONNECT ON DATABASE squid TO user_cleanup;GRANT CONNECT ON DATABASE squid TO user_domo_pull;GRANT CONNECT ON DATABASE squid TO user_iceberg_remote;GRANT CONNECT ON DATABASE squid TO user_iceberg;GRANT CONNECT ON DATABASE squid TO user_leviathan;GRANT CONNECT ON DATABASE squid TO user_reporting;GRANT CONNECT ON DATABASE squid TO user_saws;GRANT CONNECT ON DATABASE squid TO user_sonar;