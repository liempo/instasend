import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Created my own implementation of coordinates
/// to be used across the project, main use is to
/// avoid confusion among other classes with similar
/// functions like, LocationData, LatLng, GeoPoint, etc.
class Coordinates {

  double lat;
  double lng;

  Coordinates({
    required this.lat,
    required this.lng
  });

  Coordinates.fromGeoPoint(GeoPoint geoPoint) :
    this.lat = geoPoint.latitude,
    this.lng = geoPoint.longitude;

  LatLng toLatLng() =>
    LatLng(lat, lng);

  GeoPoint toGeoPoint() =>
    GeoPoint(lat, lng);

}