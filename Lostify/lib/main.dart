import 'package:device_preview/device_preview.dart';
import 'package:lostify/app/my_app.dart';
import 'package:lostify/core/config/env_config.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (EnvConfig.supabaseUrl.isEmpty || EnvConfig.supabaseAnonKey.isEmpty) {
    throw StateError(
      'SUPABASE_URL and SUPABASE_ANON_KEY must be set via --dart-define '
      '(see Lostify/.env.example).',
    );
  }

  await Supabase.initialize(
    url: EnvConfig.supabaseUrl,
    anonKey: EnvConfig.supabaseAnonKey,
  );
  await setupDI();
  assert(() {
    debugPrint('Lostify API base URL: ${EnvConfig.apiBaseUrl}');
    return true;
  }());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}
