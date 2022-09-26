import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization_theme_clean_arch/core/extensions/string_extension.dart';

import 'features/localization/presentation/cubits/localization_cubit.dart';
import 'features/theme/presentation/cubits/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'welcome'.tr(context),
            style: const TextStyle(fontSize: 32),
          ),
          OutlinedButton(
            child: const Text('change to english'),
            onPressed: () {
              BlocProvider.of<LocalizationCubit>(context)
                  .setLocale(const Locale('en'));
            },
          ),
          OutlinedButton(
            child: const Text('change to Arabic'),
            onPressed: () {
              BlocProvider.of<LocalizationCubit>(context)
                  .setLocale(const Locale('ar'));
            },
          ),
          OutlinedButton(
            child: const Text('change to system'),
            onPressed: () {
              BlocProvider.of<LocalizationCubit>(context).setToSystemLocale();
            },
          ),
          const SizedBox(
            height: 30,
          ),
          //
          OutlinedButton(
            child: const Text('change to light'),
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.light);
            },
          ),
          OutlinedButton(
            child: const Text('change to dark'),
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.dark);
            },
          ),
          OutlinedButton(
            child: const Text('change to system'),
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).setTheme(ThemeMode.system);
            },
          ),
          Switch(
            value: BlocProvider.of<ThemeCubit>(context).selectedThemeMode ==
                    ThemeMode.dark
                ? true
                : BlocProvider.of<ThemeCubit>(context).selectedThemeMode ==
                        ThemeMode.system
                    ? MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? true
                        : false
                    : false,
            onChanged: (_) {
              switch (BlocProvider.of<ThemeCubit>(context).selectedThemeMode) {
                //
                case ThemeMode.dark:
                  {
                    BlocProvider.of<ThemeCubit>(context)
                        .setTheme(ThemeMode.light);
                  }
                  break;
                //
                case ThemeMode.light:
                  {
                    BlocProvider.of<ThemeCubit>(context)
                        .setTheme(ThemeMode.dark);
                  }
                  break;
                //
                case ThemeMode.system:
                  {
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? BlocProvider.of<ThemeCubit>(context)
                            .setTheme(ThemeMode.light)
                        : BlocProvider.of<ThemeCubit>(context)
                            .setTheme(ThemeMode.dark);
                  }
                  break;
                //
              }
            },
          )
        ],
      ),
    );
  }
}
