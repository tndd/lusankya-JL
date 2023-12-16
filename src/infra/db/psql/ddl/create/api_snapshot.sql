CREATE TABLE api_snapshot (
    id SERIAL PRIMARY KEY,
    api_schedule_id INT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    status INT NOT NULL,
    resp_header JSON NOT NULL,
    body JSON NOT NULL
);