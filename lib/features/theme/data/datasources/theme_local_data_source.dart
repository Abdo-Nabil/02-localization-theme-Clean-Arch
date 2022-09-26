import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../resources/strings_manager.dart';
import '../models/theme_model.dart';

abstract class ThemeLocalDataSource {
  ThemeModel getTheme();
  Future<Unit> setTheme(ThemeModel themeModel);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  const ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  ThemeModel getTheme() {
    final bool? isLightTheme =
        sharedPreferences.getBool(StringsManager.isLightTheme);
    if (isLightTheme != null) {
      if (isLightTheme) {
        return const ThemeModel(themeMode: ThemeMode.light);
      } else {
        return const ThemeModel(themeMode: ThemeMode.dark);
      }
    }
    //
    else {
      return const ThemeModel(themeMode: ThemeMode.system);
    }
  }

  @override
  Future<Unit> setTheme(ThemeModel themeModel) async {
    switch (themeModel.themeMode) {
      //
      case ThemeMode.system:
        {
          await sharedPreferences.remove(StringsManager.isLightTheme);
        }
        break;
      //
      case ThemeMode.light:
        {
          await sharedPreferences.setBool(StringsManager.isLightTheme, true);
        }
        break;
      //
      case ThemeMode.dark:
        {
          await sharedPreferences.setBool(StringsManager.isLightTheme, false);
        }
        break;
      //
    }
    return Future.value(unit);
  }
}
