-- Enable Realtime for research_jobs table
-- This allows the frontend to subscribe to live job status updates

-- Enable realtime on research_jobs table
ALTER PUBLICATION supabase_realtime ADD TABLE public.research_jobs;

-- Optional: Enable realtime for other tables if needed
-- ALTER PUBLICATION supabase_realtime ADD TABLE public.user_research_history;
-- ALTER PUBLICATION supabase_realtime ADD TABLE public.research_cache;

-- Comments
COMMENT ON PUBLICATION supabase_realtime IS 'Realtime publication for live updates to subscribed tables';
