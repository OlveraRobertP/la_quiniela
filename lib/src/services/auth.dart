import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // sing in anonym
  Future singInAnonymous() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      return res.user;
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> singInEmail(String email, String password) async {
    // try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
  }
}
