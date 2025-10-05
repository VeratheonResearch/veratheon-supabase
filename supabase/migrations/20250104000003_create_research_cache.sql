-- Create research_cache table for caching analysis results with TTL
CREATE TABLE IF NOT EXISTS public.research_cache (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  cache_key TEXT NOT NULL UNIQUE,
  symbol TEXT NOT NULL,
  report_type TEXT NOT NULL,
  cache_type TEXT NOT NULL,
  data JSONB NOT NULL,
  metadata JSONB NULL,
  cache_date DATE NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  expires_at TIMESTAMPTZ NULL
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.research_cache ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Allow public read access to cache (or restrict to authenticated users)
-- Option 1: Public read (uncomment if you want public access)
-- CREATE POLICY "Anyone can read cache"
--   ON public.research_cache
--   FOR SELECT
--   TO public
--   USING (true);

-- Option 2: Authenticated users only (recommended)
CREATE POLICY "Authenticated users can read cache"
  ON public.research_cache
  FOR SELECT
  TO authenticated
  USING (true);

-- Only service role can insert/update/delete cache entries
CREATE POLICY "Service role can manage cache"
  ON public.research_cache
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);

-- Indexes for faster queries
CREATE INDEX idx_research_cache_symbol ON public.research_cache(symbol);
CREATE INDEX idx_research_cache_cache_key ON public.research_cache(cache_key);
CREATE INDEX idx_research_cache_report_type ON public.research_cache(report_type);
CREATE INDEX idx_research_cache_expires_at ON public.research_cache(expires_at);
CREATE INDEX idx_research_cache_created_at ON public.research_cache(created_at DESC);

-- Index for cache cleanup queries (find expired entries)
-- Note: Can't use NOW() in partial index, so we index all non-null expires_at values
CREATE INDEX idx_research_cache_expired ON public.research_cache(expires_at)
  WHERE expires_at IS NOT NULL;

-- Comments for documentation
COMMENT ON TABLE public.research_cache IS 'Caches analysis results with TTL via expires_at';
COMMENT ON COLUMN public.research_cache.cache_key IS 'Unique cache key for lookups';
COMMENT ON COLUMN public.research_cache.symbol IS 'Stock symbol';
COMMENT ON COLUMN public.research_cache.report_type IS 'Type of report (earnings, financial_statements, etc.)';
COMMENT ON COLUMN public.research_cache.cache_type IS 'Cache category/type';
COMMENT ON COLUMN public.research_cache.data IS 'Cached analysis data';
COMMENT ON COLUMN public.research_cache.expires_at IS 'Cache expiration timestamp (NULL = never expires)';
