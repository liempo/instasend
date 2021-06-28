import 'package:flutter/foundation.dart';

import '/utils/locator.dart';
import '/repositories/shop_repository.dart';

class ShopModel extends ChangeNotifier {

  final _shops = repos<ShopRepository>();

  get categories => _shops.getShopCategories();

}