﻿/* This view UNIONs all versions of the passthrough format for this DataSet.Comment out or remove any obsolete versions. Update earlier versions, as needed, to produce the same column names as the latest version. */-- View: passthrough.sonar_backlogDROP VIEW IF EXISTS passthrough.sonar_backlog;CREATE OR REPLACE VIEW passthrough.sonar_backlog ASSELECT * FROM sonar_backlog_v3;ALTER TABLE passthrough.sonar_backlog    OWNER TO user_change_structure;    -----------------------------------------------Register view---------------------------------------------CALL view_register ('passthrough','sonar_backlog','Master (UNION) view for this DataSet.','Sonar_BackLog_PG');