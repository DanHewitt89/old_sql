SELECT
	campaign_options.value
FROM campaign_options
WHERE campaign_id IN (SELECT id FROM campaigns WHERE project_id = '2')
AND campaign_options.name = 'from_name'

DELETE FROM campaign_options
WHERE campaign_id IN (SELECT id FROM campaigns WHERE project_id = '2')
AND campaign_options.name = 'from_name'


SELECT
	campaigns.id,
	campaigns.name,
	value
FROM campaign_options
	LEFT JOIN campaigns 
		ON campaigns.id = campaign_options.campaign_id
WHERE campaign_options.campaign_id IN (
	SELECT id FROM campaigns WHERE project_id = '2')
AND campaign_options.name = 'from_address'

COPY (
SELECT
	campaigns.id,
	campaigns.name,
	value
FROM campaign_options
	LEFT JOIN campaigns 
		ON campaigns.id = campaign_options.campaign_id
WHERE campaign_options.campaign_id IN (
	SELECT id FROM campaigns WHERE project_id = '2')
AND campaign_options.name = 'from_address') TO STDOUT WITH CSV HEADER > task_one_output.csv