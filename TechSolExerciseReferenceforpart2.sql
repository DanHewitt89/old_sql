SELECT
  name,
  value,
  CASE 
    WHEN level = 1 THEN 'Account'
    WHEN level = 2 THEN 'Workspace'
    WHEN level = 3 THEN 'Project'
  END AS level,
  CASE 
    WHEN level > 1 THEN (
      SELECT name FROM workspaces WHERE id = CASE level 
                                              WHEN 2 THEN object_id
                                              WHEN 3 THEN (
                                                SELECT workspace_id
                                                FROM projects
                                                WHERE id = object_id
                                              )
                                            END
  ) END AS workspace,
  CASE 
    WHEN level = 3 THEN (
      SELECT name FROM projects
      WHERE id = object_id)
    END AS project
FROM prefs
WHERE prefs.name = 'launch_copy'
ORDER BY id ASC