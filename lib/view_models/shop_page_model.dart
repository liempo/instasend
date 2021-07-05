
import 'package:flutter/widgets.dart';

import '/repositories/shop_repository.dart';
import '/models/shop.dart';
import '/models/category.dart';
import '/utils/locator.dart';

class ShopPageModel extends ChangeNotifier {

  final _shops = repos<ShopRepository>();

  // Transform these streams into a view model
  get categoriesStream => _shops.getShopCategories()
    .map((list) => list.map(
        (e) => CategortyItemViewModel(e)
      ).toList()
    );

  get shopsStream => _shops.getShops()
    .map((list) => list.map(
        (e) => ShopItemViewModel(e)
      ).toList()
    );

}

class CategortyItemViewModel {

  final String name;
  final String imageUrl;

  CategortyItemViewModel(Category category) :
    this.name = category.name,
    this.imageUrl = category.imageUrl;

}

class ShopItemViewModel {

  final String imageUrl;
  final String name;
  final double rating;

  ShopItemViewModel(Shop shop) :
    this.imageUrl = shop.imageUrl,
    this.name = shop.name,
    this.rating = shop.rating;

}