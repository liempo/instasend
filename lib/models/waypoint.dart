// Details for pickup/delivery location
import 'coordinates.dart';

class Waypoint {

  final Coordinates location;
  final String address;
  final String contactNumber;

  Waypoint({
    required this.location,
    required this.address,
    required this.contactNumber
  });

  Waypoint.fromMap(Map<String, dynamic> map) :
    this.address = map['address'],
    this.contactNumber = map['contactNumber'],
    this.location = Coordinates.fromGeoPoint(map['location']);

  Map<String, dynamic> toMap() => {
    'address' : this.address,
    'location' : this.location,
    'contactNumber' : this.address
  };

}
