CREATE TABLE api_schedule (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    endpoint TEXT NOT NULL,
    query JSON NOT NULL,
    req_header JSON NOT NULL,
    is_completed BOOLEAN NOT NULL DEFAULT FALSE
);