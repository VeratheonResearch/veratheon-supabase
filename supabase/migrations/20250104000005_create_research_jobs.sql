-- Create research_jobs table for tracking research job status and metadata
CREATE TABLE IF NOT EXISTS public.research_jobs (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  main_job_id UUID NOT NULL DEFAULT gen_random_uuid(),
  sub_job_id UUID NOT NULL DEFAULT gen_random_uuid(),
  job_name TEXT NULL,
  symbol TEXT NOT NULL,
  status TEXT NOT NULL,
  error TEXT NULL,
  metadata JSONB NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  completed_at TIMESTAMPTZ NULL,
  failed_at TIMESTAMPTZ NULL,

  CONSTRAINT research_jobs_id_key UNIQUE (id)
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.research_jobs ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Authenticated users can read all jobs, service role can manage
CREATE POLICY "Authenticated users can read research jobs"
  ON public.research_jobs
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Service role can manage research jobs"
  ON public.research_jobs
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);

-- Trigger to automatically update updated_at on row updates
CREATE TRIGGER update_research_jobs_updated_at
  BEFORE UPDATE ON public.research_jobs
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Indexes for faster queries
CREATE INDEX idx_research_jobs_symbol ON public.research_jobs(symbol);
CREATE INDEX idx_research_jobs_status ON public.research_jobs(status);
CREATE INDEX idx_research_jobs_main_job_id ON public.research_jobs(main_job_id);
CREATE INDEX idx_research_jobs_sub_job_id ON public.research_jobs(sub_job_id);
CREATE INDEX idx_research_jobs_created_at ON public.research_jobs(created_at DESC);
CREATE INDEX idx_research_jobs_updated_at ON public.research_jobs(updated_at DESC);

-- Composite index for common queries (symbol + status)
CREATE INDEX idx_research_jobs_symbol_status ON public.research_jobs(symbol, status);

-- GIN index for JSONB metadata queries
CREATE INDEX idx_research_jobs_metadata ON public.research_jobs USING GIN(metadata);

-- Comments for documentation
COMMENT ON TABLE public.research_jobs IS 'Tracks research job status and metadata';
COMMENT ON COLUMN public.research_jobs.main_job_id IS 'Main job UUID for grouping related sub-jobs';
COMMENT ON COLUMN public.research_jobs.sub_job_id IS 'Sub-job UUID for individual tasks';
COMMENT ON COLUMN public.research_jobs.job_name IS 'Human-readable job name';
COMMENT ON COLUMN public.research_jobs.symbol IS 'Stock symbol being researched';
COMMENT ON COLUMN public.research_jobs.status IS 'Job status (pending, running, completed, failed, etc.)';
COMMENT ON COLUMN public.research_jobs.error IS 'Error message if job failed';
COMMENT ON COLUMN public.research_jobs.metadata IS 'Additional job metadata and progress tracking';
COMMENT ON COLUMN public.research_jobs.completed_at IS 'Timestamp when job completed successfully';
COMMENT ON COLUMN public.research_jobs.failed_at IS 'Timestamp when job failed';
