import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthUtils {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final DatabaseReference _userRef = FirebaseDatabase.instance.reference().child('users');

  static Future<User?> isLoggedIn() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      final String email = user.email!;
      final userSnapshot = await _userRef.child(email).once();
      final userData = userSnapshot.snapshot.value as Map<dynamic, dynamic>?;
      if (userData != null) {
        return user;
      } else {
        print('User data not found for email: $email');
      }
    } else {
      print('User is not logged in.');
    }

    return null;
  }
}
