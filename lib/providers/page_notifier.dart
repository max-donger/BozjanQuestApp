import 'package:flutter/material.dart';
import '../enums.dart';

class PageNotifier extends ChangeNotifier {
  PageName? _pageName = PageName.home;
  bool _unknownPath = false;
  String? _query = '';

  get pageName => _pageName;
  get isUnknown => _unknownPath;
  get query => _query;

  changePage(
      {required PageName? page, required bool unknown, required String query}) {
    _pageName = page;
    _unknownPath = unknown;
    _query = query;
    notifyListeners();
  }
}
