import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaze_app/models/app_user.dart';
import 'package:kaze_app/services/firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  AppUser? _currentUser;
  AppUser? get currentUser => _currentUser;

  Future<UserCredential> signInWithUsernamePassword(
      String username, password) async {
    try {
      var user = await _firestoreService.getUserByUsername(username);

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Create a new user profile on firestore
      _currentUser = AppUser(
        id: userCredential.user!.uid,
        email: email,
        username: username,
      );

      // Store the username in Firestore
      await _firestoreService.createUser(_currentUser!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = _auth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }

  Future _populateCurrentUser(User? user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
