import 'package:flutter/material.dart';

class HomeNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -8),
            blurRadius: 24,
            color: Theme.of(context)
              .primaryColor
              .withOpacity(0.15)
          )
        ]
      ),
      child: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: "Feed",
            icon: Icon(Icons.feed),
          ),
          BottomNavigationBarItem(
            label: "Orders",
            icon: Icon(Icons.delivery_dining),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ]
      ),
    );
  }
}