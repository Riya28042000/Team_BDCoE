import 'package:bdcoe/notifiers/preferences.dart';
import 'package:flutter/foundation.dart';

class DarkThemeProvider with ChangeNotifier {
  BigData bdcoe = BigData();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    bdcoe.setDarkTheme(value);
    notifyListeners();
  }
}