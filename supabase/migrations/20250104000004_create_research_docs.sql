-- Create research_docs table for RAG (Retrieval Augmented Generation)
-- Stores research reports with vector embeddings for semantic search

-- Ensure vector extension is enabled
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS public.research_docs (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title TEXT NULL,
  content TEXT NULL,
  embedding vector NULL,  -- Using pgvector extension
  metadata JSONB NULL,
  token_count BIGINT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.research_docs ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Authenticated users can read, service role can manage
CREATE POLICY "Authenticated users can read research docs"
  ON public.research_docs
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Service role can manage research docs"
  ON public.research_docs
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);

-- Trigger to automatically update updated_at on row updates
CREATE TRIGGER update_research_docs_updated_at
  BEFORE UPDATE ON public.research_docs
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Indexes for faster queries
CREATE INDEX idx_research_docs_title ON public.research_docs(title);
CREATE INDEX idx_research_docs_created_at ON public.research_docs(created_at DESC);

-- Vector similarity search index (using HNSW for fast approximate nearest neighbor search)
-- Adjust dimensions based on your embedding model (e.g., 1536 for OpenAI ada-002, 768 for others)
-- CREATE INDEX idx_research_docs_embedding ON public.research_docs
--   USING hnsw (embedding vector_cosine_ops)
--   WITH (m = 16, ef_construction = 64);

-- Alternative: IVFFlat index (faster build, slower search)
-- CREATE INDEX idx_research_docs_embedding ON public.research_docs
--   USING ivfflat (embedding vector_cosine_ops)
--   WITH (lists = 100);

-- GIN index for JSONB metadata queries
CREATE INDEX idx_research_docs_metadata ON public.research_docs USING GIN(metadata);

-- Comments for documentation
COMMENT ON TABLE public.research_docs IS 'Stores research reports with vector embeddings for RAG';
COMMENT ON COLUMN public.research_docs.title IS 'Document title';
COMMENT ON COLUMN public.research_docs.content IS 'Document text content';
COMMENT ON COLUMN public.research_docs.embedding IS 'Vector embedding for semantic search';
COMMENT ON COLUMN public.research_docs.metadata IS 'Additional document metadata (symbol, report_type, etc.)';
COMMENT ON COLUMN public.research_docs.token_count IS 'Token count for the document';
