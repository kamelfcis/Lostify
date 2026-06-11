import 'package:flutter_test/flutter_test.dart';
import 'package:lostify/core/config/env_config.dart';
import 'package:lostify/features/auth/sign_in/models/auth_response.dart';

void main() {
  test('API_BASE_URL is production when built with dart_defines', () {
    expect(
      EnvConfig.apiBaseUrl,
      'https://lostify-ruddy.vercel.app/api/',
    );
  });

  test('AuthResponse parses production login payload', () {
    const payload = {
      'user': {'id': 6, 'username': 'mokamel'},
      'tokens': {
        'refresh': 'refresh-token',
        'access': 'access-token',
      },
    };

    final authResponse = AuthResponse.fromJson(payload);

    expect(authResponse.user.id, 6);
    expect(authResponse.user.username, 'mokamel');
    expect(authResponse.tokens.access, 'access-token');
    expect(authResponse.tokens.refresh, 'refresh-token');
  });
}
