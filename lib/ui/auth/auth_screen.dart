import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/widgets/widgets.dart';
import '/models/auth_type.dart';
import '/view_models/auth_screen_model.dart';
import '/utils/image_extension.dart';
import '/utils/constants.dart';

import 'login_form.dart';
import 'register_form.dart';
import 'profile_form.dart';
import 'recover_form.dart';

class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState()
     => _AuthScreenState();

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => AuthScreenModel(),
      builder: (context, child) => AuthScreen()
    );
  }

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
            _getAuthenticationEror(),
            _getSubmitButton(),
            _getAlternateButton()
          ],
        )
      )
    );
  }

  Widget _getImageHeader() {
    final radius = Radius.circular(headerBorderRadius);
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
    final size = MediaQuery
      .of(context).size;
    final image = Container(
      child: Image.asset(
        'assets/logos/script.png',
        // Set to 20% of screen
        height: size.height * 0.2
      ).withTint(
        color: Theme.of(context)
          .primaryColor
      )
    );
    final placeholder = Container(
      height: size.height * 0.05,
    );
    return _isKeyboardVisible() ?
      placeholder : image;
  }

  Widget _getActiveForm() {
    final size = MediaQuery
      .of(context).size;
    return Consumer<AuthScreenModel>(
      builder: (context, value, child) {
        // Create the form based on type
        // NOTE: Not sure if I did this correctly,
        //  because as far as I know, the View layer
        //  should not be aware of the models. Fix pls.
        Widget? form;
        switch (value.type) {
          case AuthType.LOGIN:
            form = Column(
              crossAxisAlignment:
                CrossAxisAlignment.start,
              children: [
                LoginForm(),
                // Create an extension to LoginForm
                TextButton(
                  onPressed: value.isLoading ? null :
                    () => value.setTypeToRecover(),
                  child: Text("Forgot password?")
                )
              ],
            );
            break;
          case AuthType.REGISTER:
            form = RegisterForm(); break;
          case AuthType.RECOVER:
            form = RecoverForm(); break;
          case AuthType.PROFILE:
            form = ProfileForm(); break;
        }

        // Add 15% padding to forms
        final horizontalPadding =
          size.width * 0.15;

        // Return the widget with padding
        return Container(
          padding: EdgeInsets.only(
            top: _isKeyboardVisible() ? 4 : 24,
            left: horizontalPadding,
            right: horizontalPadding
          ),
          child: form,
        );
      },
    );
  }

  Widget _getAlternateButton() {
    return Consumer<AuthScreenModel>(
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.only(
            bottom: _isKeyboardVisible() ? 0 : 32
          ),
          // Hide when keyboard is visible
          child: TextButton(
            onPressed: value.isLoading ? null :
              () => value.swap(),
            child: Text(value.getAlternateButtonText())
          ),
        );
      },
    );
  }

  Widget _getAuthenticationEror() {
    return Consumer<AuthScreenModel>(
      builder: (context, value, child) {
        if (value.errorAuth == null)
          return Container();
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            value.errorAuth,
            style: Theme.of(context)
              .textTheme.bodyText2!.copyWith(
                color: Theme.of(context)
                  .errorColor
              ),
          ),
        );
      },
    );
  }

  Widget _getSubmitButton() {
    return Consumer<AuthScreenModel>(
      builder: (context, value, child) {
        return Container(
          margin: EdgeInsets
            .symmetric(horizontal: 32),
          child: AppButton(
            text: value.getPrimaryButtonText(),
            onPressed: value.submit,
            isLoading: value.isLoading,
          ),
        );
      }
    );
  }

  // Returns true if keyboard is visible
  bool _isKeyboardVisible() {
    return MediaQuery.of(context)
      .viewInsets.bottom != 0.0;
  }

}