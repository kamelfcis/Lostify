class EnvConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://rroxljxrlaaiwerygwlw.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJyb3hsanhybGFhaXdlcnlnd2x3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkzNjY3NjEsImV4cCI6MjA4NDk0Mjc2MX0.STLtiGUHoI442iRakrz4Hcf-0b6Ex2LRvwFNfw37tgA',
  );

  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://lostify-ruddy.vercel.app/api/',
  );

  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );
}
