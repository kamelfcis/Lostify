// import 'package:dive_connect/core/di/dependancy_injection.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// GoogleSignInAccount? googleUser;
// Future<AuthResponse> signInWithGoogle() async {
//   const webClientId =
//       '54028343357-u0nhe0arh61mdc885llpf2ehp6gj12l0.apps.googleusercontent.com';
//   final GoogleSignIn googleSignIn = GoogleSignIn(
//     serverClientId: webClientId,
//   );
//   googleUser = await googleSignIn.signIn();
//   if (googleUser == null) {
//     return AuthResponse();
//   }
//   final googleAuth = await googleUser!.authentication;
//   final accessToken = googleAuth.accessToken;
//   final idToken = googleAuth.idToken;

//   if (accessToken == null) {
//     throw 'No Access Token found.';
//   }
//   if (idToken == null) {
//     throw 'No ID Token found.';
//   }

//   final result = await getIt<SupabaseClient>().auth.signInWithIdToken(
//         provider: OAuthProvider.google,
//         idToken: idToken,
//         accessToken: accessToken,
//       );
//   return result;
// }
