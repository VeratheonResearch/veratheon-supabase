-- Create user_settings table for storing user preferences, notifications, and privacy settings
CREATE TABLE public.user_settings (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,

  -- UI/UX preferences (theme, preferred model, etc.)
  preferences JSONB DEFAULT '{}'::jsonb,

  -- Notification settings (email, push, etc.)
  notifications JSONB DEFAULT '{}'::jsonb,

  -- Privacy/data controls (analytics, cache, retention)
  privacy JSONB DEFAULT '{}'::jsonb,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(user_id)
);

-- Enable Row Level Security
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

-- RLS Policies: Users can only access their own settings
CREATE POLICY "Users can view own settings"
  ON public.user_settings
  FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own settings"
  ON public.user_settings
  FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own settings"
  ON public.user_settings
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Create or replace the updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update updated_at on row updates
CREATE TRIGGER update_user_settings_updated_at
  BEFORE UPDATE ON public.user_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Index for faster user lookups
CREATE INDEX idx_user_settings_user_id ON public.user_settings(user_id);

-- Comments for documentation
COMMENT ON TABLE public.user_settings IS 'Stores user preferences, notification settings, and privacy controls';
COMMENT ON COLUMN public.user_settings.preferences IS 'UI/UX preferences like theme and preferred model';
COMMENT ON COLUMN public.user_settings.notifications IS 'Notification settings for email, push, etc.';
COMMENT ON COLUMN public.user_settings.privacy IS 'Privacy and data control settings';
