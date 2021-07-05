/// REFERENCE: https://t.co/sG0yLMJlM4

import 'dart:ui';
import 'package:flutter/material.dart';

import '/view_models/shop_page_model.dart';
import '/utils/constants.dart';

class CategoryItem extends StatelessWidget {

  final CategortyItemViewModel category;
  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
  return Container(
      child: ClipRRect(
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 1.0, sigmaY: 1.0,
          ),
          child: Container(
            color: Theme.of(context)
              .primaryColorDark
              .withOpacity(0.35),
            child: Center(
              child: Text(
                category.name,
                style: Theme.of(context)
                  .primaryTextTheme
                  .headline6
              )
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(category.imageUrl),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius
          .circular(cardBorderRadius),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 8,
            color: Theme.of(context)
              .accentColor
              .withOpacity(0.5)
          )
        ]
      ),
    );
  }

}
