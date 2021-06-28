import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/category.dart';

class ShopRepository {

  final _categories = FirebaseFirestore
    .instance.collection("shop_categories");

  Stream<List<Category>> getShopCategories() {
    return _categories.snapshots().map(
      (snapshots) => snapshots.docs.map(
        (e) => Category.fromMap(e.data())
      ).toList()
    );
  }

}