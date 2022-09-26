import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_theme_clean_arch/home_screen.dart';
import 'features/localization/locale/app_localizations_setup.dart';
import 'features/localization/presentation/cubits/localization_cubit.dart';
import 'features/theme/app_theme.dart';
import 'features/theme/presentation/cubits/theme_cubit.dart';
import 'injection_container.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LocalizationCubit>()..getLocale()),
        BlocProvider(create: (context) => sl<ThemeCubit>()..getTheme()),
      ],
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'AppStrings.appName',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode:
                    BlocProvider.of<ThemeCubit>(context).selectedThemeMode,
                // onGenerateRoute: AppRoutes.onGenerateRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                locale:
                    BlocProvider.of<LocalizationCubit>(context).selectedLocale,
                // localeResolutionCallback:
                //     AppLocalizationsSetup.localeResolutionCallback,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                home: const Scaffold(
                  body: HomeScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
