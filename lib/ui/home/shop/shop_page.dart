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
              _getPopularGroup()
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
    return StreamBuilder(
      stream: provider.categories,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();
        final list = snapshot.data
          as List<CategortyItemViewModel>;

        // Define height here to avoid
        //errors when budiling the ListView
        return Container(
          height: 72,
          // Margin for the spacing on the column
          margin: EdgeInsets.only(top: 24),
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

  Widget _getPopularGroup() {
    // Get provider here to access the shops stream
    final provider = Provider
      .of<ShopModel>(context, listen: false);
    return Column(
      children: [
        _createGroupTitle(
          title: "Popular Near You",
          onPressed: () {}
        ),
        StreamBuilder(
          stream: provider.shops,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container();
            final list = snapshot.data
              as List<ShopItemViewModel>;

            // Define height here to avoid
            //errors when budiling the ListView
            return Container(
              height: 172,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // Wrap with align to avoid
                  // the items from expanding
                  // the listView's parent
                  return Align(
                    alignment: Alignment.topCenter,
                    child: ShopItem(
                      shop: list[index]
                    ),
                  );
                },
              ),
            );

          },
        )
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