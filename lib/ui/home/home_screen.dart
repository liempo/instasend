import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/home_screen_model.dart';
import 'home_nav_bar.dart';
import 'shop/shop_page.dart';
import 'delivery/delivery_page.dart';

class HomeScreen extends StatelessWidget {

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenModel(),
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
    return Consumer<HomeScreenModel>(
      builder: (context, value, child) {
        switch (value.state) {
          case HomeState.SHOP:
            return ShopPage.withViewModel();
          case HomeState.DELIVERY:
            return DeliveryPage.withViewModel();
          case HomeState.PROFILE:
            return Scaffold();
        }
      }
    );
  }

}