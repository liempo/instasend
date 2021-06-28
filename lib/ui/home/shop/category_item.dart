/// REFERENCE: https://t.co/sG0yLMJlM4

import 'dart:ui';
import 'package:flutter/material.dart';

import '/view_models/shop_model.dart';

class CategoryItem extends StatelessWidget {

  final CategortyItemViewModel category;
  const CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
  return Container(
      // Height matches parent
      // But the width is fixed
      width: 128,
      margin: EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
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
        borderRadius: BorderRadius.circular(12),
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

}
