import 'package:flutter/widgets.dart';
import 'package:instasend/models/home_state.dart';

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

  Future<String> get currentPlacemark =>
    _loc.currentPlacemark;

  HomeState _state = HomeState.SHOP;
  HomeState get state => _state;
  get stateIndex => HomeState.values.indexOf(_state);

  void setStateByIndex(int index) {
    _state = HomeState
      .values.elementAt(index);
    notifyListeners();
  }

}