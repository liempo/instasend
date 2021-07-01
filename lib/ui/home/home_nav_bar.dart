import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/home_model.dart';

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
      child: Consumer<HomeModel>(
        builder: (context, value, child) =>
          BottomNavigationBar(
            currentIndex: value.stateIndex,
            onTap: value.setStateByIndex,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "Shop",
                icon: Icon(Icons.store),
              ),
              BottomNavigationBarItem(
                label: "Delivery",
                icon: Icon(Icons.delivery_dining),
              ),
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
              ),
            ]
          ),
      ),
    );
  }
}