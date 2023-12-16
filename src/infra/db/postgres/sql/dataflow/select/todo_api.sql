SELECT * FROM api_schedule sch
LEFT JOIN (
    SELECT snp1.*
    FROM api_snapshot snp1
    JOIN (
        SELECT api_schedule_id, MAX(timestamp) AS max_timestamp
        FROM api_snapshot
        GROUP BY api_schedule_id
    ) snp2 ON snp1.api_schedule_id = snp2.api_schedule_id AND snp1.timestamp = snp2.max_timestamp
) snp ON sch.id = snp.api_schedule_id
WHERE sch.is_completed = false
AND (snp.status IS NULL OR snp.status != 200);