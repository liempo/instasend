/// I stole this code from Github HAHAHHAAHA
/// https://github.com/fmmalta/no_context_navigation_package/blob/master/lib/src/navigation_service.dart

import 'package:flutter/material.dart';

typedef _RoutePredicate = bool Function(Route<dynamic>);
class NavigationService {

  final GlobalKey<NavigatorState> navigatorKey =
    new GlobalKey<NavigatorState>();

Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? args,
  }) async {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: args,
    );
  }

  Future<T?> push<T extends Object?>(Route<T> route) async {
    return navigatorKey.currentState?.push<T>(route);
  }

  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? args,
    TO? result,
  }) async {
    return navigatorKey.currentState?.pushReplacementNamed<T, TO>(
      routeName,
      arguments: args,
      result: result,
    );
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? args,
    _RoutePredicate? predicate,
  }) async {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (_) => false,
      arguments: args,
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Route<T> route, {
    _RoutePredicate? predicate,
  }) async {
    return navigatorKey.currentState?.pushAndRemoveUntil<T>(
      route,
      predicate ?? (_) => false,
    );
  }

  Future<bool?> maybePop<T extends Object?>([T? result]) async {
    return navigatorKey.currentState?.maybePop<T>(result);
  }

  bool canPop() => navigatorKey.currentState!.canPop();

  void goBack<T extends Object?>({T? result}) {
    navigatorKey.currentState?.pop<T>(result);
  }

  void popUntil(String route) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(route));
  }

  RouteSettings? pageSettings(BuildContext context) {
    return ModalRoute.of<RouteSettings>(context)?.settings;
  }

}