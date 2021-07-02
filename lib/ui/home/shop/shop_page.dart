import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '/view_models/shop_model.dart';

import 'shop_app_bar.dart';
import 'category_item.dart';
import 'shop_item.dart';

class ShopPage extends StatefulWidget {

  @override
  _ShopPageState createState()
    => _ShopPageState();

  static Widget withViewModel() {
    return ChangeNotifierProvider(
      create: (context) => ShopModel(),
      builder: (context, child) => ShopPage()
    );
  }

}

class _ShopPageState extends State<ShopPage> {

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        HomeAppBar(),
        SliverFillRemaining(
          child: Column(
            crossAxisAlignment:
              CrossAxisAlignment.start,
            mainAxisAlignment:
              MainAxisAlignment.start,
            children: [
              _getCategoryGroup(),
              _getPopularGroup(),
            ]
          )
        )
      ],
    );
  }

  Widget _getCategoryGroup() {
    // Get provider here to access the category stream
    final provider = Provider
      .of<ShopModel>(context, listen: false);

    // Calculate the dimensions and size here
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width * 0.35;
    final itemHeight = size.height * 0.10;

    return Container(
      // Define height here to avoid
      //errors when budiling the ListView
      height: itemHeight,
      // Margin for the spacing on the column
      margin: EdgeInsets.only(top: 24),
      child: StreamBuilder(
        stream: provider.categoriesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container();
          final list = snapshot.data
            as List<CategortyItemViewModel>;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              // Apply categoryItem dimensions
              return Container(
                width: itemWidth,
                padding: EdgeInsets
                  .only(bottom: 12),
                margin: EdgeInsets
                  .symmetric(horizontal: 4),
                child: CategoryItem(
                  category: list[index]
                ),
              );
            },
          );
        }
      ),
    );
  }

  Widget _getPopularGroup() {
    // Get provider here to access the shops stream
    final provider = Provider
      .of<ShopModel>(context, listen: false);

    // Calculate the dimensions and size here
    final size = MediaQuery.of(context).size;
    final itemWidth = size.width * 0.50;
    final itemHeight = size.height * 0.20;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _createGroupTitle(
          title: "Popular Near You",
          onPressed: () {}
        ),
        Container(
          // Define height here to avoid errors
          // when budiling the ListView
          height: itemHeight,
          child: StreamBuilder(
            stream: provider.shopsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Container();
              final list = snapshot.data
                as List<ShopItemViewModel>;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // Apply dimensions for each ShopItem
                  return Container(
                    width: itemWidth,
                    height: itemHeight,
                    padding: EdgeInsets
                      .symmetric(vertical: 8),
                    margin: EdgeInsets
                      .symmetric(horizontal: 8),
                    alignment: Alignment.topCenter,
                    child: ShopItem(
                      shop: list[index]
                    ),
                  );
                },
              );
            },
          )
        ),
      ],
    );
  }

  Widget _createGroupTitle({
    required String title,
    Function()? onPressed
  }) {
    return Container(
      height: 32, // Set a fixed height
      margin: EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
          title,
          style: Theme.of(context)
            .textTheme.headline6!
            .copyWith(
              fontWeight: FontWeight.bold
            )
          ),
          Spacer(),
          TextButton(
            child: Text("More"),
            onPressed: onPressed,
          )
        ]
      ),
    );
  }

}