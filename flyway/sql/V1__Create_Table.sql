CREATE TABLE http_checks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  uri VARCHAR(255) NOT NULL,
  is_paused BOOLEAN NOT NULL,
  num_retries INTEGER NOT NULL CHECK (num_retries >= 0 AND num_retries <= 5),
  uptime_sla INTEGER NOT NULL CHECK (uptime_sla >= 0 AND uptime_sla <= 100),
  response_time_sla INTEGER NOT NULL CHECK (response_time_sla >= 0 AND response_time_sla <= 100),
  use_ssl BOOLEAN NOT NULL,
  response_status_code INTEGER NOT NULL DEFAULT 200,
  check_interval_in_seconds INTEGER NOT NULL CHECK (check_interval_in_seconds >= 0 AND check_interval_in_seconds <= 86400),
  check_created TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp,
  check_updated TIMESTAMP WITH TIME ZONE DEFAULT current_timestamp
);