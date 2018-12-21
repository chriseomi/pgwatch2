REVOKE ALL ON SCHEMA public FROM public;

GRANT ALL ON SCHEMA public TO pgwatch2;

CREATE EXTENSION IF NOT EXISTS btree_gin;

SET role TO pgwatch2;

-- drop table if exists metrics;

create table metrics (
  time timestamptz not null default now(),
  dbname text not null,
  metric text not null,
  data jsonb not null,
  tag_data jsonb
);

-- create index on metrics using gin (dbname, metric, time);
create index on metrics (dbname, metric, time); -- seems to work better
create index on metrics using gin (tag_data, time);

-- TODO partition by time (1w) or dbname+time?