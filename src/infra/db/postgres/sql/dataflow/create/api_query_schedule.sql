CREATE TABLE dataflow.api_query_schedule (
	api_schedule_id int4 NOT NULL,
	time_stamp timestamptz NOT NULL DEFAULT now(),
	query text NOT NULL,
	CONSTRAINT api_query_schedule_pkey PRIMARY KEY (api_schedule_id),
	CONSTRAINT api_query_schedule_fk FOREIGN KEY (api_schedule_id) REFERENCES dataflow.api_schedule(id) ON DELETE CASCADE ON UPDATE CASCADE
);