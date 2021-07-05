import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 32),
      padding: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        // Change this to a more dynamic color in theme
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Theme.of(context)
              .primaryColor
              .withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Theme.of(context)
                    .primaryColor
                    .withOpacity(0.5)
                )
              ),
            ),
          ),
          Icon(Icons.search)
        ],
      ),
    );
  }
}