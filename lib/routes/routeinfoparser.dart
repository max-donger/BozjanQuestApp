import 'package:flutter/material.dart';
import '../enums.dart';
import 'routes.dart';

//This holds an unknown path typed into the uri
String? _unknownPath;

class AppRouteInformationParser extends RouteInformationParser<AppRoute> {
  @override
  Future<AppRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return AppRoute.home();
    }

    //If path includes more than one segement, go to 404
    if (uri.pathSegments.length > 1) {
      _unknownPath = routeInformation.location;
      return AppRoute.unknown();
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.first == PageName.drs.name) {
        return AppRoute.drs();
      }
    }

    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.first == PageName.holster.name) {
        return AppRoute.holster();
      }
    }

    _unknownPath = uri.path;
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
      return RouteInformation(location: _unknownPath);
    }

    return const RouteInformation(location: "/");
  }

//Get Route Information depending on the PageName passed
  RouteInformation _getRouteInformation(String page) {
    return RouteInformation(location: "/$page");
  }
}
