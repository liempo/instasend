import 'package:flutter/material.dart';
import 'package:instasend/view_models/shop_model.dart';

import '/utils/constants.dart';

class ShopItem extends StatelessWidget {

  final ShopItemViewModel shop;

  ShopItem({ required this.shop });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _getShopImage(context),
          _getShopDetails(context)
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Theme.of(context)
              .accentColor
              .withOpacity(0.75)
          )
        ]
      ),
    );
  }

  Widget _getShopDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment:
          MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              shop.name,
              maxLines: 1,
            overflow: TextOverflow.fade,
            softWrap: false,
            ),
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Theme.of(context)
                  .primaryColorLight
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

  Widget _getShopImage(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        child: Image.network(
          shop.imageUrl,
          width: double.infinity,
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            cardBorderRadius),
          topRight: Radius.circular(
            cardBorderRadius)
        ),
      ),
    );
  }
}