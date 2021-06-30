import 'package:location/location.dart' as Location;
import 'package:geocoding/geocoding.dart' as Geocoding;

class LocationService {

  LocationService() { _enable(); }

  final _location = new Location.Location();

  // Initial values will be negative until enable()
  var _serviceEnabled = false;
  var _permissionStatus = Location.PermissionStatus.denied;

  get serviceEnabled => _serviceEnabled;
  get permissinGranted =>
    _permissionStatus == Location.PermissionStatus.granted;

  Stream<Location.LocationData> getCurrentLocationStream() =>
    _location.onLocationChanged;

  Stream<String> getCurrentLocalityStream() =>
    _location.onLocationChanged
    .asyncMap((data) => Geocoding.placemarkFromCoordinates(
      data.latitude!, data.longitude!)
      .then((value) => value.first.locality!)
    );

  void _enable() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return;
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == Location.PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
    }
  }

}