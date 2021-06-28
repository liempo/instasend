import 'package:flutter/widgets.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';
import '/utils/locator.dart';

class HomeModel extends ChangeNotifier {

  final _profiles = repos<ProfileRepository>();
  final _auth = repos<AuthRepository>();

  get currentProfileFirstName => _profiles
    .getProfileStream(uid: _auth.user!.uid)
    .map((profile) => profile.firstName);

}