import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../resources/strings_manager.dart';
import '../../locale/app_localizations_setup.dart';
import '../models/locale_model.dart';

abstract class LocalizationLocalDataSource {
  LocaleModel getLocale();
  Future<LocaleModel> setToSystemLocale();
  Future<Unit> setLocale(LocaleModel localeModel);
}

class LocalizationLocalDataSourceImpl implements LocalizationLocalDataSource {
  final SharedPreferences sharedPreferences;
  const LocalizationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  LocaleModel getLocale() {
    final String? jsonString =
        sharedPreferences.getString(StringsManager.storedLocale);
    if (jsonString != null) {
      String decodedJsonData = json.decode(jsonString);
      return LocaleModel(locale: Locale(decodedJsonData));
    }
    //
    else {
      return _setSystemLocaleIfFound();
    }
  }

  @override
  Future<LocaleModel> setToSystemLocale() async {
    final bool result = await sharedPreferences.remove(
      StringsManager.storedLocale,
    );
    if (result == false) {
      throw CacheSavingException();
    }
    return _setSystemLocaleIfFound();
  }

  @override
  Future<Unit> setLocale(LocaleModel localeModel) async {
    final bool result = await sharedPreferences.setString(
      StringsManager.storedLocale,
      json.encode(localeModel.locale.languageCode),
    );
    if (result == false) {
      throw CacheSavingException();
    }
    return Future.value(unit);
  }

  //The system (mobile) language
  Locale _getDeviceLocale() {
    final String result = Platform.localeName; //like en_US or ar_EG
    final String localeString = result.split('_').first;
    return Locale(localeString);
  }

  LocaleModel _setSystemLocaleIfFound() {
    final Locale deviceLocal = _getDeviceLocale();
    Locale systemLocaleOrEnglish =
        AppLocalizationsSetup.localeResolutionCallback(
            deviceLocal, AppLocalizationsSetup.supportedLocales);
    //
    return LocaleModel(locale: systemLocaleOrEnglish);
  }
}
