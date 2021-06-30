import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/home_model.dart';
import '/utils/image_extension.dart';
import '/utils/constants.dart';

class HomeAppBar extends StatelessWidget {

  // Get the instance of HomeModel
  late final HomeModel _provider;

  late final _expandedHeight;
  late final _backgroundHeight;

  final _searchBarHeight = 54.0;
  final _textMaxWidth = 196.0;

  @override
  Widget build(BuildContext context) {
    // Initialize the provider object
    _provider = Provider.of<HomeModel>(
      context, listen: false);

    // Set the _expandedHeight to 20% of screen
    _expandedHeight = (MediaQuery
      .of(context).size.height * 0.25);
    _backgroundHeight = _expandedHeight -
      (_searchBarHeight / 2);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SliverAppBar(
        expandedHeight: _expandedHeight,
        backgroundColor: Colors.transparent,
        flexibleSpace: _getFlexibleSpace(context),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            _searchBarHeight
          ),
          child: _getSearchBar(context)
        ),
      ),
    );
  }

  Widget _getFlexibleSpace(BuildContext context) {
    // Set the height slightly more to overlap
    return Container(
      height: _backgroundHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 48.0
      ),
      child: Center(
        child: _getContent(context)
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
          .primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            headerBorderRadius),
          bottomRight: Radius.circular(
            headerBorderRadius),
        )
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment:
            MainAxisAlignment.center,
          children: [
            _getGreetingText(context),
            _getAddressText(context)
          ],
        ),
        Spacer(),
        Image.asset(
          'assets/logos/circle.png',
          width: 48,
        ).withTint(
          color: Theme.of(context)
            .accentColor
        )
      ],
    );
  }

  Widget _getGreetingText(BuildContext context) {
    return StreamBuilder(
      stream: _provider.firstNameStream,
      builder: (context, snapshot) {
        // Get the string data from snapshot
        String firstName =
          snapshot.data.toString();
        return Container(
          width: _textMaxWidth,
          child: Text(
            "Hello $firstName",
            style: Theme.of(context)
            .primaryTextTheme
            .headline5!
            .copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        );
      },
    );
  }

  Widget _getAddressText(BuildContext context) {
    return StreamBuilder(
      stream: _provider.currentAddress,
      builder: (context, snapshot) {
        String text = snapshot.hasData ?
          snapshot.data.toString() :
          "Getting you current location";
        return SizedBox(
          width: _textMaxWidth,
          child: Text(
            text,
            style: Theme.of(context)
              .primaryTextTheme
              .subtitle1
          )
        );
      },
    );
  }

  Widget _getSearchBar(BuildContext context) {
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