import 'package:cloud_firestore/cloud_firestore.dart';

import '/models/category.dart';
import '/models/shop.dart';

class ShopRepository {

  final _shops = FirebaseFirestore
    .instance.collection("shops");
  final _categories = FirebaseFirestore
    .instance.collection("shop_categories");

  Stream<List<Shop>> getShops() =>
    _shops.snapshots().map(
      (snapshots) => snapshots.docs.map(
        (e) => Shop.fromMap(e.data())
      ).toList()
    );

  Stream<List<Category>> getShopCategories() =>
    _categories.snapshots().map(
      (snapshots) => snapshots.docs.map(
        (e) => Category.fromMap(e.data())
      ).toList()
    );


}