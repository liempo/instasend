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

  // BUG: https://github.com/Lyokone/flutterlocation/issues/572
  Future<Location.LocationData> get lastKnownLocation
    => _location.getLocation();

  Stream<Location.LocationData> getCurrentLocationStream() =>
    _location.onLocationChanged;

  Future<String> get currentPlacemark async {
    final data = await _location.getLocation();
    final placemark = (await Geocoding
      .placemarkFromCoordinates(
        data.latitude!, data.longitude!
    )).first; // Get the first placemark of the result
    return "${placemark.locality}, ${placemark.subLocality}";
  }

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