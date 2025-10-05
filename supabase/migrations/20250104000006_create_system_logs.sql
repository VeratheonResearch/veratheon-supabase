-- Create system_logs table for centralized error tracking and logging
CREATE TABLE IF NOT EXISTS public.system_logs (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  log_level TEXT NOT NULL,
  component TEXT NOT NULL,
  message TEXT NOT NULL,
  job_id TEXT NULL,
  symbol TEXT NULL,
  stack_trace TEXT NULL,
  metadata JSONB NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.system_logs ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Only service role can access logs (security-sensitive data)
CREATE POLICY "Service role can read system logs"
  ON public.system_logs
  FOR SELECT
  TO service_role
  USING (true);

CREATE POLICY "Service role can insert system logs"
  ON public.system_logs
  FOR INSERT
  TO service_role
  WITH CHECK (true);

-- Optional: Allow authenticated admins to read logs (add user role checking)
-- CREATE POLICY "Admins can read system logs"
--   ON public.system_logs
--   FOR SELECT
--   TO authenticated
--   USING (
--     EXISTS (
--       SELECT 1 FROM auth.users
--       WHERE auth.uid() = id
--       AND raw_user_meta_data->>'role' = 'admin'
--     )
--   );

-- Indexes for faster queries
CREATE INDEX idx_system_logs_log_level ON public.system_logs(log_level);
CREATE INDEX idx_system_logs_component ON public.system_logs(component);
CREATE INDEX idx_system_logs_job_id ON public.system_logs(job_id);
CREATE INDEX idx_system_logs_symbol ON public.system_logs(symbol);
CREATE INDEX idx_system_logs_created_at ON public.system_logs(created_at DESC);

-- Composite index for common queries (log_level + component + created_at)
CREATE INDEX idx_system_logs_level_component_time ON public.system_logs(log_level, component, created_at DESC);

-- GIN index for JSONB metadata queries
CREATE INDEX idx_system_logs_metadata ON public.system_logs USING GIN(metadata);

-- Comments for documentation
COMMENT ON TABLE public.system_logs IS 'Centralized system logs for error tracking and debugging';
COMMENT ON COLUMN public.system_logs.log_level IS 'Log severity level (debug, info, warning, error, critical)';
COMMENT ON COLUMN public.system_logs.component IS 'System component that generated the log';
COMMENT ON COLUMN public.system_logs.message IS 'Log message';
COMMENT ON COLUMN public.system_logs.job_id IS 'Associated job ID if applicable';
COMMENT ON COLUMN public.system_logs.symbol IS 'Associated stock symbol if applicable';
COMMENT ON COLUMN public.system_logs.stack_trace IS 'Stack trace for errors';
COMMENT ON COLUMN public.system_logs.metadata IS 'Additional structured log data';

-- Optional: Create a function to clean up old logs (retention policy)
CREATE OR REPLACE FUNCTION cleanup_old_system_logs(retention_days INTEGER DEFAULT 90)
RETURNS INTEGER AS $$
DECLARE
  deleted_count INTEGER;
BEGIN
  DELETE FROM public.system_logs
  WHERE created_at < NOW() - (retention_days || ' days')::INTERVAL;

  GET DIAGNOSTICS deleted_count = ROW_COUNT;
  RETURN deleted_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

COMMENT ON FUNCTION cleanup_old_system_logs IS 'Deletes system logs older than specified retention period (default 90 days)';

-- Optional: Schedule automatic cleanup using pg_cron extension
-- First enable pg_cron: CREATE EXTENSION IF NOT EXISTS pg_cron;
-- Then schedule cleanup (runs daily at 2 AM):
-- SELECT cron.schedule('cleanup-old-logs', '0 2 * * *', 'SELECT cleanup_old_system_logs(90)');
