import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/auth_model.dart';

class RegisterForm extends StatelessWidget {

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
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Email",
                errorText: provider.errorEmail
            ),
            onChanged: (text) =>
              provider.email = text
          ),
          SizedBox(height: spacing),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              errorText: provider.errorPassword,
            ),
            onChanged: (text) =>
              provider.password = text
          ),
          SizedBox(height: spacing),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
            ),
            onChanged: provider.confirmPassword,
          ),
        ],
      ),
    );
  }

}