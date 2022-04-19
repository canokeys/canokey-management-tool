import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:logging/logging.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/oath.dart';
import 'components/openpgp.dart';
import 'components/piv.dart';
import 'components/settings.dart';
import 'generated/l10n.dart';
import 'home.dart';
import 'routes.dart';

main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

final log = Logger('ManagementTool:Main');

class MainApp extends StatefulWidget {
  static void setLanguage(BuildContext context, String lang) async {
    _MainAppState? state = context.findAncestorStateOfType<_MainAppState>();

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', lang);

    state?.setState(() {
      state._locale = getLocale(lang);
    });
  }

  static Locale getLocale(String lang) {
    Locale locale;
    switch (lang) {
      case 'English':
        locale = Locale('en');
        break;
      case '简体中文':
        locale = Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans');
        break;
      default:
        log.warning('unknown language $lang');
        locale = Locale('en');
    }
    return locale;
  }

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale _locale = Locale('en');

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      String lang = prefs.getString('lang') ?? 'English';
      setState(() {
        this._locale = MainApp.getLocale(lang);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      builder: (context) {
        return MaterialApp(
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          onGenerateTitle: (context) => S.of(context).homeScreenTitle,
          theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
          debugShowCheckedModeBanner: false,
          home: Home(),
          navigatorObservers: [NavigationHistoryObserver()],
          routes: {
            Routes.openpgp: (_) => OpenPGP(),
            Routes.settings: (_) => Settings(),
            Routes.oath: (_) => OATH(),
            Routes.piv: (_) => PIV(),
          },
        );
      },
      maximumSize: Size(1200.0, 2160.0),
      enabled: kIsWeb,
      backgroundColor: Colors.grey,
    );
  }
}
