import 'package:flutter/material.dart';

import 'home_nav_bar.dart';
import 'home_app_bar.dart';
import 'shop/shop_content.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          HomeAppBar(),
          SliverFillRemaining(
            child: ShopContent
              .withViewModel(),
          )
        ],
      ),
      bottomNavigationBar: HomeNavBar(),
    );
  }
}