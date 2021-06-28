import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/view_models/home_model.dart';
import '/utils/image_extension.dart';

class HomeAppBar extends StatelessWidget {

  late final _expandedHeight;
  late final _backgroundHeight;
  final _searchBarHeight = 54.0;

  @override
  Widget build(BuildContext context) {
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
        flexibleSpace: _getContent(context),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
            _searchBarHeight
          ),
          child: _getSearchBar(context)
        ),
      ),
    );
  }

  Widget _getContent(BuildContext context) {
    // Set the height slightly more to overlap
    return Container(
      height: _backgroundHeight,
      padding: EdgeInsets.symmetric(
        horizontal: 48.0
      ),
      child: Center(
        child: _getGreeting(context)
      ),
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
    // Get the instance of HomeModel
    final provider = Provider
      .of<HomeModel>(context, listen: false);

    return Row(
      children: [
        StreamBuilder(
          stream: provider.currentProfileFirstName,
          builder: (context, snapshot) {
            // Get the string data from snapshot
            String firstName =
              snapshot.data.toString();

            return SizedBox(
              width: 196,
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