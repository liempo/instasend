import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/home_model.dart';

import 'home_nav_bar.dart';
import 'home_app_bar.dart';
import 'shop/shop_content.dart';

class HomeScreen extends StatelessWidget {

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => HomeModel(),
      builder: (context, child) => HomeScreen(),
    );
  }

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