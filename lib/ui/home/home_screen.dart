import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/home_state.dart';
import '/view_models/home_model.dart';

import 'home_nav_bar.dart';
import 'shop/shop_page.dart';

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
      body: _getActivePage(context),
      bottomNavigationBar: HomeNavBar(),
    );
  }

  Widget _getActivePage(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, value, child) {
        switch (value.state) {
          case HomeState.SHOP:
            return ShopPage.withViewModel();
          case HomeState.DELIVERY:
            return Scaffold();
          case HomeState.PROFILE:
            return Scaffold();
        }
      }
    );
  }
}