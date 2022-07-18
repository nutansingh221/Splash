import 'package:firebase_auth/firebase_auth.dart';
import 'package:splash/Modals/users.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users? _userfromFirebase(User? user) {
    return user != null ? Users(userId: user.uid) : null;
  }

  Future signInWithEMail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = credential.user;
      return _userfromFirebase(firebaseuser);
    } catch (e) {
      print(e);
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? firebaseuser = credential.user;
      return _userfromFirebase(firebaseuser);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future resetpass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}
