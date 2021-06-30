/// REFERENCE: https://t.co/sG0yLMJlM4

import 'dart:ui';
import 'package:flutter/material.dart';

import '/view_models/shop_model.dart';
import '/utils/constants.dart';

class CategoryItem extends StatelessWidget {

  final CategortyItemViewModel category;
  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
  return Container(
      // Height matches parent
      // But the width is fixed
      width: 128,
      // Margins per item should only
      // include the spacing they need
      margin: EdgeInsets.symmetric(horizontal: 8),
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
            offset: Offset(0, 0),
            blurRadius: 24,
            color: Theme.of(context)
              .accentColor
              .withOpacity(0.25)
          )
        ]
      ),
    );
  }

}
