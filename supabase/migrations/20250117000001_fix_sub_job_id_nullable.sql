-- Make sub_job_id nullable so main jobs don't auto-generate a sub_job_id
-- This fixes the bug where main_flow jobs were getting sub_job_id values

ALTER TABLE public.research_jobs
  ALTER COLUMN sub_job_id DROP NOT NULL,
  ALTER COLUMN sub_job_id DROP DEFAULT;

COMMENT ON COLUMN public.research_jobs.sub_job_id IS 'Sub-job UUID for individual tasks (NULL for main jobs)';
