import 'package:flutter/material.dart';
import 'package:instasend/view_models/shop_model.dart';

import '/utils/constants.dart';

class ShopItem extends StatelessWidget {

  final ShopItemViewModel shop;

  ShopItem({required this.shop});

  @override
  Widget build(BuildContext context) {
   return Container(
      width: 224,
      // Margins per item should only
      // include the spacing they need
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          _getShopImage(),
          _getShopDetails(context)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 12),
            blurRadius: 12,
            color: Theme.of(context)
              .accentColor
              .withOpacity(0.25)
          )
        ]
      ),
    );
  }

  Widget _getShopDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment:
          MainAxisAlignment.center,
        children: [
          Text(shop.name),
          Spacer(),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context)
                  .primaryColor
                  .withOpacity(0.5)
              ),
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber
                  ),
                ),
                TextSpan(text: "${shop.rating}")
              ]
            )
          )
        ]
      ),
    );
  }

  Widget _getShopImage() {
    return ClipRRect(
      child: Image.network(shop.imageUrl),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          cardBorderRadius),
        topRight: Radius.circular(
          cardBorderRadius)
      ),
    );
  }
}