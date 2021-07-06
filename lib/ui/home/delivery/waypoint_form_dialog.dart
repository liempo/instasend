import 'package:flutter/material.dart';

import '/utils/constants.dart';

class WaypointFormDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10, vertical: 10
      ),
      actions: [
        TextButton(
          child: Text("Done"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
      content: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter Pickup Information",
              style: Theme.of(context)
                .textTheme.subtitle1,
            ),
            SizedBox(height: 24),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Contact Person",
                hintText: "Phone number of contact",
                prefixIcon: Icon(Icons.phone)
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Address",
                hintText: "Enter address or landmark",
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius
          .circular(cardBorderRadius)
      ),
    );
  }

}