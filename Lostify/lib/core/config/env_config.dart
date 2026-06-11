class EnvConfig {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://fvjcxqtbqzkhzwjnrcva.supabase.co',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ2amN4cXRicXpraHp3am5yY3ZhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE3MjIzMjYsImV4cCI6MjA3NzI5ODMyNn0.Ih7b8KG_30nx3eNYs2tnkRtiQTIuwpqAJ1dSqwyQm8Y',
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
