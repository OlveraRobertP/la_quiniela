import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<UserCredential> registration(
    String email,
    String password,
  ) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
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

  //// Native
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // web
  // Future<UserCredential> signInWithGoogle() async {
  //   // Create a new provider
  //   GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //   googleProvider
  //       .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //   googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithPopup(googleProvider);

  //   // Or use signInWithRedirect
  //   // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  // }
}
