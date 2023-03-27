import 'package:diaco_test/data/enums/enums.dart';
import 'package:diaco_test/data/resource_data/locale/base_box.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
   bool _isDark=false;

  bool get isDark => _isDark;

  ThemeProvider() {
    initTheme();
  }

  final BaseBox<String> themeBox = BaseBox<String>('theme-box');

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  Future<void> initTheme() async {
    await themeBox.open();
    getTheme();
  }

  Future<void> getTheme() async {
    if (themeBox.isNotEmpty) {
      String? themeMode = await themeBox.first();
      isDark = themeMode == ThemeModel.dark.name ? true : false;
    } else {
      //default theme
      isDark = false;
    }
  }

  Future<void> setTheme(ThemeModel theme) async {
    themeBox.clear();
    themeBox['theme']=theme.name;
    isDark = (theme == ThemeModel.dark) ? true : false;
  }

  @override
  void dispose() {
    themeBox.close();
    super.dispose();
  }
}
