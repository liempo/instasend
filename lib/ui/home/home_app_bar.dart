import 'package:flutter/material.dart';

import '/utils/image_extension.dart';

class HomeAppBar extends StatelessWidget {

  // Declare height variables for the widgets
  // which will be used to compute offset
  // to achieve a "hanging" search bar
  final double _searchBarHeight = 54.0;
  late final _appBarHeight;
  late final _backgroundHeight;

  @override
  Widget build(BuildContext context) {
    // Set the appBarHeight to 20% of screen
    _appBarHeight = MediaQuery.of(context)
      .size.height * 0.2;
    _backgroundHeight = _appBarHeight
      - (_searchBarHeight / 2.0);

    return SliverAppBar(
      expandedHeight: _appBarHeight,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getContent(context),
    );
  }

  Widget _getContent(BuildContext context) {
    // Wrap the stack in a container to
    // be sure that the height is equals to
    // the total height of the appBar.
    return Container(
      height: _appBarHeight,
      child: Stack(
        children: [
          // Create the background
          Positioned(
            top: 0, left: 0, right: 0,
            child: _getBackground(context)
          ),

          Positioned(
            bottom: _backgroundHeight / 2,
            left: 32, right: 32,
            child: _getGreeting(context)
          ),

          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _getSearchBar(context)
          )
        ],
      ),
    );
  }

  Container _getBackground(BuildContext context) {
    return Container(
      height: _backgroundHeight,
      decoration: BoxDecoration(
        color: Theme.of(context)
          .primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        )
      ),
    );
  }

  Widget _getGreeting(BuildContext context) {
    return Row(
      children: [
        Text(
          "Welcome",
          style: Theme.of(context)
          .primaryTextTheme
          .headline5!
          .copyWith(
            fontWeight: FontWeight.bold
          )
        ),
        Spacer(),
        Image.asset(
          'assets/logos/circle.png',
          height: 48, width: 48
        ).withTint(
          color: Theme.of(context)
            .accentColor
        )
      ],
    );
  }

  Widget _getSearchBar(BuildContext context) {
    return Container(
      height: _searchBarHeight,
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