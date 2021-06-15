import 'package:flutter/material.dart';
import 'package:instasend/ui/auth/login_form.dart';

class AuthScreen extends StatefulWidget {

  const AuthScreen({
     Key? key
  }) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();

}

class _AuthScreenState extends State<AuthScreen> {

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
    return Container(
      padding: EdgeInsets.only(
        top: 24, left: 48, right: 48
      ),
      child: LoginForm(),
    );
  }

  Widget _getAlternateButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      // Hide when keyboard is visible
      child: TextButton(
        onPressed: () {},
        child: Text("Don't have an account?")
      ),
    );
  }

  Widget _getSubmitButton() {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: 32
      ),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Login",
          style: Theme.of(context)
            .primaryTextTheme.subtitle1
        ),
      )
    );
  }

  // Returns true if keyboard is visible
  bool _isKeyboardVisible() {
    return MediaQuery.of(context)
      .viewInsets.bottom != 0.0;
  }

}