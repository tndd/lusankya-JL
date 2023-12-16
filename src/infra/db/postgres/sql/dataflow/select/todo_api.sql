WITH max_timestamps_snapshot AS (
  SELECT api_schedule_id, MAX(time_stamp) AS max_timestamp
  FROM api_snapshot
  GROUP BY api_schedule_id
),
latest_snapshots AS (
  SELECT s.*
  FROM api_snapshot s
  JOIN max_timestamps_snapshot mts
    ON s.api_schedule_id = mts.api_schedule_id
   AND s.time_stamp = mts.max_timestamp
)
SELECT *
FROM api_schedule sch
LEFT JOIN latest_snapshots lt_s
  ON sch.id = lt_s.api_schedule_id
WHERE lt_s.status IS NULL OR lt_s.status <> 200;