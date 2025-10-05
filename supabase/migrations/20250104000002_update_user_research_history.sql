-- Update user_research_history table to use UUID for user_id and add proper constraints
-- Note: This migration assumes the table exists. If it doesn't, it will be created.

-- Drop the existing table if it has the old schema (optional - comment out if you want to preserve data)
-- DROP TABLE IF EXISTS public.user_research_history CASCADE;

-- Create user_research_history table with proper user_id UUID
CREATE TABLE IF NOT EXISTS public.user_research_history (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  symbol TEXT NOT NULL,
  job_id BIGINT NULL,
  metadata JSONB NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.user_research_history ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Users can only access their own research history
CREATE POLICY "Users can view own research history"
  ON public.user_research_history
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own research history"
  ON public.user_research_history
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own research history"
  ON public.user_research_history
  FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete own research history"
  ON public.user_research_history
  FOR DELETE
  USING (auth.uid() = user_id);

-- Trigger to automatically update updated_at on row updates
-- (Reuses the function created in the previous migration)
CREATE TRIGGER update_user_research_history_updated_at
  BEFORE UPDATE ON public.user_research_history
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_user_research_history_user_id ON public.user_research_history(user_id);
CREATE INDEX IF NOT EXISTS idx_user_research_history_symbol ON public.user_research_history(symbol);
CREATE INDEX IF NOT EXISTS idx_user_research_history_job_id ON public.user_research_history(job_id);
CREATE INDEX IF NOT EXISTS idx_user_research_history_created_at ON public.user_research_history(created_at DESC);

-- Comments for documentation
COMMENT ON TABLE public.user_research_history IS 'Tracks user research activity and history';
COMMENT ON COLUMN public.user_research_history.user_id IS 'Reference to authenticated user';
COMMENT ON COLUMN public.user_research_history.symbol IS 'Stock symbol researched';
COMMENT ON COLUMN public.user_research_history.job_id IS 'Reference to research job';
COMMENT ON COLUMN public.user_research_history.metadata IS 'Additional metadata about the research request';
