import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/profile.dart';

class ProfileRepository {

  final _profiles = FirebaseFirestore
    .instance.collection("profiles");

  Future<String> createProfile({
    required String uid,
    required Profile profile
  }) async {
    try {
      _profiles.doc(uid)
        .set(profile.toMap());
    } catch (e) {
      return e.toString();
    }

    return 'success';
  }

}