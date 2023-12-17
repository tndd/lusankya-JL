CREATE VIEW dataflow.latest_api_snapshots AS
WITH max_timestamps_snapshot AS (
  SELECT api_schedule_id, MAX(time_stamp) AS max_timestamp
  FROM dataflow.api_snapshot
  GROUP BY api_schedule_id
),
latest_snapshots AS (
  SELECT s.*
  FROM dataflow.api_snapshot s
  JOIN max_timestamps_snapshot mts
    ON s.api_schedule_id = mts.api_schedule_id
   AND s.time_stamp = mts.max_timestamp
)
SELECT *
FROM latest_snapshots;