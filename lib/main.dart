import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myapp/common/global.dart';
import 'package:myapp/i10n/localization_intl.dart';
import 'package:myapp/routes/home_page.dart';
import 'package:myapp/routes/theme_change.dart';
import 'package:myapp/routes/login.dart';
import 'package:myapp/routes/language.dart';
import 'package:myapp/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
         providers: [
            ChangeNotifierProvider(create: (_) => ThemeModel()),
            ChangeNotifierProvider(create: (_) => UserModel()),
            ChangeNotifierProvider(create: (_) => LocaleModel()),
         ],
       child: Consumer2<ThemeModel, LocaleModel>(
          builder: (BuildContext context, themeModel, localeModel, child) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: themeModel.theme,
              ),
              onGenerateTitle: (context) {
                return GmLocalizations.of(context)!.title;
              },
              home: HomeRoute(),
              locale: localeModel.getLocale(),
              supportedLocales: [
                const Locale('en', 'US'),
                const Locale('zh', 'CN'),
              ],
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GmLocalizationsDelegate()
              ],
              localeResolutionCallback: (_locale, supportedLocales) {
                if (localeModel.getLocale() != null) {
                    return localeModel.getLocale();
                } else {
                  Locale locale;
                  if (supportedLocales.contains(_locale)) {
                    locale = _locale!;
                  } else {
                    locale = Locale('en', 'US');
                  }
                  return locale;
                }
              },
              routes: <String, WidgetBuilder>{
                "login": (context) => LoginRoute(),
                "themes": (context) => ThemeChangeRoute(),
                "language": (context) => LanguageRoute()
              },
            );
          },
       ),
     );
  }
}
