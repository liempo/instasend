import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double spacing = 18;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                labelText: "Email"
            )
          ),
          SizedBox(height: spacing),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password"
            )
          ),
          SizedBox(height: spacing),
          TextButton(
            onPressed: () {},
            child: Text("Forgot password?")
          ),
        ],
      ),
    );
  }

}