import 'package:flutter/material.dart';
import 'package:instasend/ui/auth/recover_form.dart';
import 'package:provider/provider.dart';

import '/models/auth_type.dart';
import '/providers/auth_provider.dart';

import 'login_form.dart';
import 'register_form.dart';

class AuthScreen extends StatefulWidget {

  const AuthScreen({
     Key? key
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();

  static Widget withProvider() {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      builder: (context, child) => AuthScreen()
    );
  }

}

class _AuthScreenState extends State<AuthScreen> {

  late final _provider = Provider
    .of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _getImageHeader(),
            _getActiveForm(),
            Spacer(),
            _getSubmitButton(),
            _getAlternateButton()
          ],
        )
      )
    );
  }

  Widget _getImageHeader() {
    final radius = Radius.circular(32);
    return Container(
      padding: EdgeInsets.only(
        top: 32, left: 64, right: 64
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
          .canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey
              .withOpacity(0.25),
            blurRadius: 30,
            offset: Offset(0, 4)
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: radius,
          bottomRight: radius
        )
      ),
      child: _getBrandingImage(),
    );
  }

  Widget _getBrandingImage() {
    final image = Container(
      child: ColorFiltered(
        child: Image.asset(
          'assets/logos/script.png',
            height: 128,
        ),
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
            BlendMode.srcATop
        )
      ),
    );

    return _isKeyboardVisible() ? Container() : image;
  }

  Widget _getActiveForm() {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        // Create the form based on type
        // NOTE: Not sure if I did this correctly,
        //  because as far as I know, the View layer
        //  should not be aware of the models. Fix pls.
        Widget? form;
        switch (value.type) {
          case AuthType.LOGIN:
            form = Column(
              children: [
                LoginForm(),
                // Create an extension to LoginForm
                TextButton(
                  onPressed: () =>
                    _provider.setTypeToRecover(),
                  child: Text("Forgot password?")
                )
              ],
            );
            break;
          case AuthType.REGISTER:
            form = RegisterForm(); break;
          case AuthType.RECOVER:
            form = RecoverForm(); break;
        }

        // Return the widget with padding
        return  Container(
          padding: EdgeInsets.only(
            top: 24, left: 48, right: 48
          ),
          child: form,
        );
      },
    );
  }

  Widget _getAlternateButton() {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.only(bottom: 16),
          // Hide when keyboard is visible
          child: TextButton(
            onPressed: () => value.swap(),
            child: Text(value.getAlternateButtonText())
          ),
        );
      },
    );
  }

  Widget _getSubmitButton() {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Container(
          height: 60,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: 32
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              value.getPrimaryButtonText(),
              style: Theme.of(context)
                .primaryTextTheme.subtitle1
            ),
          )
        );
      },
    );
  }

  // Returns true if keyboard is visible
  bool _isKeyboardVisible() {
    return MediaQuery.of(context)
      .viewInsets.bottom != 0.0;
  }

}