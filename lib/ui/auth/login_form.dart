import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/auth_model.dart';

class LoginForm extends StatelessWidget {

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
            )
          ),
          SizedBox(height: spacing),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              errorText: provider.errorPassword
            )
          ),
        ],
      ),
    );
  }

}