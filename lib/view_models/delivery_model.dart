import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/services/location_service.dart';
import '/utils/locator.dart';

class DeliveryModel extends ChangeNotifier {

  final _loc = services<LocationService>();

  Future<LatLng> get lastKnownLocation async {
    final data = await _loc.lastKnownLocation;
    return LatLng(
      data.latitude!,
      data.longitude!
    );
  }

}