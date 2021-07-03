import 'package:flutter/material.dart';

/// Main button to be used across the app
class AppButton extends StatelessWidget {

  final String text;
  final bool isLoading;
  final Function() onPressed;

  const AppButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading ?
          _getProgressBar(context) :
          _getText(context),
      ),
    );
  }

  Widget _getText(BuildContext context) {
    return Text(
        text,
        style: Theme.of(context)
          .primaryTextTheme
          .subtitle1!
          .copyWith(
            fontWeight: FontWeight.bold
          )
      );
  }

  Widget _getProgressBar(BuildContext context) {
    return Container(
      width: 24, height: 24,
      child: CircularProgressIndicator(
        color: Theme.of(context)
        .primaryIconTheme.color,
      ),
    );
  }

}