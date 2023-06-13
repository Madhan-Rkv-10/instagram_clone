import '../src/localization/app_locallization.dart';
import 'package:flutter/material.dart';
import 'localization/languages.dart';
import 'routing/routes.dart' as routes;
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: Languages.languages.map((e) => Locale(e.code)).toList(),
      localizationsDelegates: const [
        //Custom App delegates
        AppLocalizations.delegate,
        // material delegates
        GlobalMaterialLocalizations.delegate,
        // Any type of Widget in Locale
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      darkTheme: ThemeData.dark(useMaterial3: true),
      theme: ThemeData.light(useMaterial3: true),
      themeMode: ThemeMode.system,
      builder: (_, child) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child,
        );
      },
      onGenerateRoute: routes.onGenerateRoute,
    );
  }
}
