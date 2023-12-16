-- dataflow.api_query_schedule definition

-- Drop table

-- DROP TABLE dataflow.api_query_schedule;

CREATE TABLE dataflow.api_query_schedule (
	api_schedule_id int4 NOT NULL,
	time_stamp timestamptz NOT NULL DEFAULT now(),
	query text NULL,
	CONSTRAINT api_query_schedule_pkey PRIMARY KEY (api_schedule_id)
);