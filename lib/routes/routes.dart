import '../enums.dart';

class AppRoute {
  final PageName? pageName;
  final bool _isUnknown;

  AppRoute.home()
      : pageName = PageName.home,
        _isUnknown = false;

  AppRoute.drs()
      : pageName = PageName.drs,
        _isUnknown = false;

  AppRoute.holster()
      : pageName = PageName.holster,
        _isUnknown = false;

  AppRoute.unknown()
      : pageName = null,
        _isUnknown = true;

//Used to get the current path
  bool get isHome => pageName == PageName.home;
  bool get isDrs => pageName == PageName.drs;
  bool get isHolster => pageName == PageName.holster;
  bool get isUnknown => _isUnknown;
}
