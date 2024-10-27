import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaze_app/models/profile_user.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ProfileUser?> fetchUserProfile(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data();

        if (userData != null) {
          return ProfileUser.fromJson(userData);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      await _firestore.collection('users').doc(updatedProfile.id).update({
        'bio': updatedProfile.bio,
        'profileImageUrl': updatedProfile.profileImageUrl,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
