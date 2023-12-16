-- dataflow.api_snapshot definition

-- Drop table

-- DROP TABLE dataflow.api_snapshot;

CREATE TABLE dataflow.api_snapshot (
	id serial4 NOT NULL,
	api_schedule_id int4 NOT NULL,
	time_stamp timestamptz NOT NULL DEFAULT now(),
	status int4 NOT NULL,
	resp_header json NOT NULL,
	body json NULL,
	CONSTRAINT api_snapshot_pkey PRIMARY KEY (id),
	CONSTRAINT api_snapshot_fk FOREIGN KEY (api_schedule_id) REFERENCES dataflow.api_schedule(id) ON DELETE CASCADE ON UPDATE CASCADE
);