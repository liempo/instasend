import '/models/waypoint.dart';
import '/utils/string_extension.dart';

class Delivery {

  final Waypoint pickup;
  final Waypoint destination;
  final DeliveryStatus status;

  Delivery({
    required this.pickup,
    required this.destination,
    required this.status
  });

  Delivery.fromMap(Map<String, dynamic> map) :
    this.pickup = Waypoint.fromMap(map['pickup']),
    this.destination = Waypoint.fromMap(map['destination']),
    this.status = DeliveryStatusExtension
      .fromBetterString(map['status']);

  Map<String, dynamic> toMap() => {
    'pickup' : this.pickup,
    'destination' : this.destination,
    'status' : this.status.toBetterString()
  };

}

enum DeliveryStatus {
  searching, // App is still searching for a rider
  transit, // Rider has picked up parcel and is on the way to destination
  delivered // Parcel has been delivered to destination
}

extension DeliveryStatusExtension on DeliveryStatus {

  String toBetterString() =>
    toString().substring(
       toString().indexOf('.') + 1
    ).capitalize();

  static DeliveryStatus fromBetterString(String text) {
    for (var type in DeliveryStatus.values)
      if (type.toBetterString() == text)
        return type;
    throw Exception("$text not found");
  }

}