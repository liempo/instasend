import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
import 'package:cloud_firestore/cloud_firestore.dart';

/// To be deprecated in the future in favor of GeoFire
class LatLng {

  double lat;
  double lng;

  LatLng({
    required this.lat,
    required this.lng
  });

  LatLng.fromGeoPoint(GeoPoint geoPoint) :
    this.lat = geoPoint.latitude,
    this.lng = geoPoint.longitude;

  GoogleMaps.LatLng toGoogleMapsLatLng() =>
    GoogleMaps.LatLng(lat, lng);

}