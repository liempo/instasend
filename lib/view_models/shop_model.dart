
import 'package:flutter/widgets.dart';

import '/repositories/shop_repository.dart';
import '/models/category.dart';
import '/utils/locator.dart';

class ShopModel extends ChangeNotifier {

  final _shops = repos<ShopRepository>();

  // Transform this stream into a view model
  get categories => _shops.getShopCategories()
    .map((list) => list.map(
        (e) => CategortyItemViewModel(e)
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
