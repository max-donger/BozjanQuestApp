import 'package:flutter/material.dart';
import '../enums.dart';
import 'routes.dart';

//This holds an unknown path typed into the uri
Uri? _unknownPath;

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = routeInformation.uri;

    if (uri.pathSegments.isEmpty) {
      return AppRoute.home();
    }

    //If path includes more than one segement, go to 404
    if (uri.pathSegments.length > 1) {
      _unknownPath = routeInformation.uri;
      return AppRoute.unknown();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.first == PageName.drs.name) {
        return AppRoute.drs();
      }
    }

    if (uri.pathSegments.first == PageName.holster.name) {
      return AppRoute.holster();
    }

    _unknownPath = uri;
    return AppRoute.unknown();
  }

//This passes route information to the parseRouteInformation method depending on the current AppRoute
  @override
  RouteInformation? restoreRouteInformation(AppRoute configuration) {
    if (configuration.isDrs) {
      return _getRouteInformation(configuration.pageName!.name);
    }

    if (configuration.isHolster) {
      return _getRouteInformation(configuration.pageName!.name);
    }

    if (configuration.isUnknown) {
      return RouteInformation(uri: _unknownPath);
    }

    return RouteInformation(uri: Uri.parse("/"));
  }

//Get Route Information depending on the PageName passed
  RouteInformation _getRouteInformation(String page) {
    return RouteInformation(uri: Uri.parse('/$page'));
  }
}
