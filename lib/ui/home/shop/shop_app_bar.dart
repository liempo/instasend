import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/widgets/widgets.dart';
import '/view_models/home_screen_model.dart';
import '/utils/image_extension.dart';
import '/utils/constants.dart';

class ShopAppBar extends StatelessWidget {

  final _expandedHeightPercent = 0.25;
  final _searchBarHeight = 54.0;
  final _textMaxWidth = 224.0;

  @override
  Widget build(BuildContext context) {
    // Compute expanded height of appBar
    final height = MediaQuery.of(context)
      .size.height * _expandedHeightPercent;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SliverAppBar(
        // Get 20% of the total height
        expandedHeight: height,
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
    // Set the height slightly less than expandedHeight
    final height =  (MediaQuery.of(context).size.height
      * _expandedHeightPercent) - (_searchBarHeight / 2);
    return Container(
      height: height,
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
    final provider = Provider
      .of<HomeScreenModel>(context, listen: false);
    return StreamBuilder(
      stream: provider.firstNameStream,
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
            .headline4!
            .copyWith(
              fontWeight: FontWeight.bold
            ),
          ),
        );
      },
    );
  }

  Widget _getAddressText(BuildContext context) {
    final provider = Provider
      .of<HomeScreenModel>(context,
        listen: false);
    return FutureBuilder(
      future: provider.currentPlacemark,
      builder: (context, snapshot) {
        String text = snapshot.hasData ?
          snapshot.data.toString() :
          "Getting you current location";
        return SizedBox(
          width: _textMaxWidth,
          child:  RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.location_pin,
                    size: 18,
                    color: Theme.of(context)
                      .primaryIconTheme
                      .color
                  ),
                ),
                TextSpan(
                  text: text,
                  style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle2
                )
              ]
            )
          )
        );
      },
    );
  }

  Widget _getSearchBar(BuildContext context) {
    return FloatingContainer(
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