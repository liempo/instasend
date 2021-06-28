import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '/ui/home/shop/category_item.dart';
import '/view_models/shop_model.dart';

class ShopContent extends StatefulWidget {
  @override
  _ShopContentState createState()
    => _ShopContentState();

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => ShopModel(),
      builder: (context, child) => ShopContent()
    );
  }
}

class _ShopContentState extends State<ShopContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
        CrossAxisAlignment.start,
      mainAxisAlignment:
        MainAxisAlignment.start,
      children: [
        _getCategoryList()
      ]
    );
  }

  Widget _getCategoryList() {
    // Get provider here to access the category stream
    final provider = Provider
      .of<ShopModel>(context, listen: false);

    return StreamBuilder(
      stream: provider.categories,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();

        final list = snapshot.data
          as List<dynamic>;

        // Define height here to avoid
        //errors when budiling the ListView
        return Container(
          height: 96, width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return CategoryItem(
                category: list[index]
              );
            },
          ),
        );
      }
    );
  }

}