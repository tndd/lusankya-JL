CREATE TABLE dataflow.api_schedule (
	id serial4 NOT NULL,
	time_stamp timestamptz NOT NULL DEFAULT now(),
	endpoint text NOT NULL,
	params json NOT NULL,
	req_header json NOT NULL,
	CONSTRAINT api_schedule_pkey PRIMARY KEY (id)
);