import 'package:flutter/material.dart';

class FloatingContainer extends StatelessWidget {

  final Widget? child;

  const FloatingContainer({ this.child });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        // Change this to a more dynamic color in theme
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Theme.of(context)
              .primaryColor
              .withOpacity(0.2)
          )
        ]
      ),
      child: child
    );
  }
}