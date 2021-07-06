import 'package:flutter/widgets.dart';

import '/models/coordinates.dart';
import '/services/location_service.dart';
import '/utils/locator.dart';

class DeliveryPageModel extends ChangeNotifier {

  final _loc = services<LocationService>();

  Future<Coordinates> get lastKnownLocation async {
    final data = await _loc.lastKnownLocation;
    return Coordinates(
      lat: data.latitude!,
      lng: data.longitude!
    );
  }
}