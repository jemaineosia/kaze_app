import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(
      String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store the username in Firestore
      // await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
      //   'username': username,
      // });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = _auth.currentUser;
    return user != null;
  }

  // Future _populateCurrentUser(User user) async {
  //   if (user != null) {
  //     _currentUser = await _firestoreService.getUser(user.uid);
  //   }
  // }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
