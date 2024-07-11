import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:kaze_app/models/app_user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createUser(AppUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<AppUser> getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.doc(uid).get();
      return AppUser.fromData(userData.data() as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AppUser> getUserByUsername(String username) async {
    try {
      var userData = await _usersCollectionReference
          .where('username', isEqualTo: username)
          .get();
      return AppUser.fromData(
          userData.docs.first.data() as Map<String, dynamic>);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
