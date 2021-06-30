
import 'package:cloud_firestore/cloud_firestore.dart';

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

}