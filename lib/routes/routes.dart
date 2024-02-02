import '../enums.dart';
import '../pages/drs.dart';

class AppRoute {
  final PageName? pageName;
  final bool _isUnknown;
  final String? query;

  AppRoute.home()
      : pageName = PageName.home,
        _isUnknown = false,
        query = '';

  AppRoute.drs()
      : pageName = PageName.drs,
        _isUnknown = false,
        query = '';

  AppRoute.holster()
      : pageName = PageName.holster,
        _isUnknown = false,
        query = drsQuery;

  AppRoute.unknown()
      : pageName = null,
        _isUnknown = true,
        query = '';

//Used to get the current path
  bool get isHome => pageName == PageName.home;
  bool get isDrs => pageName == PageName.drs;
  bool get isHolster => pageName == PageName.holster;
  bool get isUnknown => _isUnknown;
}
