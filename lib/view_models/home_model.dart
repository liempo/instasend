import 'package:flutter/widgets.dart';

import '/repositories/auth_repository.dart';
import '/repositories/profile_repository.dart';
import '/services/location_service.dart';
import '/utils/locator.dart';

class HomeModel extends ChangeNotifier {

  final _profiles = repos<ProfileRepository>();
  final _auth = repos<AuthRepository>();
  final _loc = services<LocationService>();

  Stream<String> get firstNameStream => _profiles
    .getProfileStream(uid: _auth.user!.uid)
    .map((profile) => profile.firstName);

  Stream<String> get currentAddress => _loc
    .getCurrentLocalityStream()
    .map((data) => "$data");

}