import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '/view_models/delivery_page_model.dart';
import '/ui/widgets/widgets.dart';
import '/utils/constants.dart';

class DeliveryPage extends StatefulWidget {

  @override
  _DeliveryPageState createState()
    => _DeliveryPageState();

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => DeliveryPageModel(),
      builder: (context, child) => DeliveryPage()
    );
  }

}

class _DeliveryPageState extends State<DeliveryPage> {

  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _getGoogleMap(),
        _getOverlay()
      ],
    );
  }

  Widget _getGoogleMap() {
    final _astrotel = CameraPosition(
      target: LatLng(
        14.1934414, 121.1657594
      ), zoom: 16
    );
    return GoogleMap(
      initialCameraPosition: _astrotel,
      myLocationButtonEnabled: false,
      onMapCreated: (controller) async {
        _mapController = controller;
        // Pan camera to curr location
        final loc = await Provider
          .of<DeliveryPageModel>(context, listen: false)
            .lastKnownLocation;
        _mapController.animateCamera(
          CameraUpdate.newLatLng(loc.toLatLng())
        );
      },
    );
  }

  SafeArea _getOverlay() {
    return SafeArea(
    child: Column(
      children: [
        _createAddressButton(
          title: "Pickup",
          body: "Current location"
        ),
        _createAddressButton(
          title: "Delivery",
          body: "Please select a destination"
        ),
        Spacer(),
        _getSubmitButton()
      ]
    ),
  );
  }

  Widget _createAddressButton({
    required String title,
    required String body
  }) {
    // Extracted to prevent deep nesting (code-wise)
    var header = Row(
      children: [
        Text(
          title,
          style: Theme.of(context)
            .textTheme.headline6!
            .copyWith(
              fontWeight: FontWeight.bold
            )
        ),
        Spacer(),
        Icon(Icons.chevron_right)
      ],
    );
    return Container(
      margin: EdgeInsets
        .only(
          left: 32, right: 32, bottom: 16
        ),
      child: ClipRRect(
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        child: Material(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                  CrossAxisAlignment.start,
                children: [
                  header,
                  Text(body)
                ],
              ),
            ),
            splashColor: Theme.of(context)
              .accentColor
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: Theme.of(context)
              .primaryColor
                .withOpacity(0.15)
          )
        ]
      ),
    );
  }


  Widget _getSubmitButton() {
    return Container(
      child: AppButton(
        text: "Submit",
        onPressed: () {},
      ),
      margin: EdgeInsets.only(
        left: 32, right: 32, bottom: 16
      )
    );
  }

}

