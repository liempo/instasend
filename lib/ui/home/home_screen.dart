import 'package:flutter/material.dart';

import '/ui/home/home_nav_bar.dart';
import 'home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),

        ],
      ),
      bottomNavigationBar: HomeNavBar(),
    );
  }
}