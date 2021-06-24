import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/auth_model.dart';

class ProfileForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider
      .of<AuthModel>(context);
    double spacing = 18;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           TextFormField(
            enabled: !provider.isLoading,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: "First Name",
                errorText: provider.errorFirstName
            ),
            onChanged: (text) =>
              provider.firstName = text
          ),
          SizedBox(height: spacing),
          TextFormField(
            enabled: !provider.isLoading,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                labelText: "Last Name",
                errorText: provider.errorLastName
            ),
            onChanged: (text) =>
              provider.lastName = text
          ),
          SizedBox(height: spacing),
          DropdownButton<String>(
            value: provider.profileType,
            items: provider.getProfileTypeList().map((e) {
                return DropdownMenuItem<String>(
                  value: e, child: Text(e)
                );
              }).toList(),
            onChanged: provider.setProfileType,
          )
        ],
      ),
    );
  }

}