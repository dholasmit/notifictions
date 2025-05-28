import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> getUser() async {
    return _auth.currentUser;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();

    print("User signed out.");
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      // Save user info to SharedPreferences
      if (userCredential.user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'displayName', userCredential.user!.displayName ?? '');
        await prefs.setString('email', userCredential.user!.email ?? '');
        await prefs.setString('photoURL', userCredential.user!.photoURL ?? '');
      }

      return userCredential;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      print("Password reset email sent to $email");
    } catch (e) {
      print("Error sending password reset email: $e");
    }
  }
// Future<UserCredential?> signInWithGoogle() async {
//   try {
//     final googleUser = await GoogleSignIn().signIn();
//     final googleAuth = await googleUser?.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//     return await _auth.signInWithCredential(credential);
//   } catch (e) {
//     print(e.toString());
//     return null;
//   }
// }
}
